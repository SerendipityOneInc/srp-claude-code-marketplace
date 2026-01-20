---
name: raydata
description: Write, test, deploy, and troubleshoot Ray Data jobs for large-scale data processing with GPU/CPU coordination
---

# Ray Data Job Development

Help developers build, test, deploy, and debug Ray Data jobs at SRP. Ray Data is designed for large-scale ML workloads with distributed CPU/GPU coordination.

## When to Use This Skill

Use this skill when:
- Writing new Ray Data jobs for batch inference, data preprocessing, or ETL
- Testing Ray Data code locally or on GPU clusters
- Deploying jobs to production RayCluster
- Debugging performance issues or failures
- Setting up scheduled jobs in Airflow

## Development Workflow

### 1. Local Development on A10

**Environment Setup:**

```bash
# Connect to A10 development machine
ssh oci-dev2.ssh.buildagi.us  # A102 dev machine
# OR
ssh oci-dev3.ssh.buildagi.us  # A103 dev machine

# Create virtual environment
python3 -m venv my_venv
source my_venv/bin/activate

# Install Ray Data and dependencies
pip install ray[data]
pip install transformers Pillow torch  # Add other dependencies as needed
```

**Development Tips:**
- Use VSCode/Cursor for remote editing
- Always use virtualenv to avoid dependency conflicts
- Store code in `/data/srp/raydata/code/` for RayCluster visibility
- Test with small datasets first

**Running Locally:**

```bash
# Simple Python execution
python /data/srp/raydata/code/your-job.py
```

**When to Use Local Development:**
- Initial code writing and debugging
- Jobs that don't require GPU
- Models that fit in A10 GPU memory (~24GB)

### 2. Testing on Slurm H100/H200

When models are too large for A10 or require more GPU memory:

```bash
# Connect to Slurm cluster
ssh -p 2222 zhuguangbin@129.80.180.16

# Start apptainer with H100/H200 GPU
sapptainer -c 20 -m 200G -g 1 -p h100 -i /data/srp/apptainer/ray_2.52.0-py310-gpu.sif

# Run your job inside apptainer
python /data/srp/raydata/code/your-job.py
```

**Use Slurm Testing For:**
- Large models (e.g., Qwen3-VL-8B-Instruct-FP8)
- GPU-intensive workloads
- Final testing before production

### 3. Production Deployment on RayCluster

**Setup Ray Client:**

```bash
# On your Mac or any machine with Ray installed
conda create -n ray python=3.10 -y
conda activate ray
pip install -U "ray[all]"

# Set RayCluster address
export RAY_ADDRESS="https://ray.g.yesy.online"
```

**Submit Job:**

```bash
ray job submit \
  --runtime-env-json='{
    "pip": ["torch", "torchvision", "transformers"],
    "env_vars": {
      "INPUT_PATH": "s3://bucket/path/to/input",
      "OUTPUT_PATH": "/data/srp/project/output"
    }
  }' \
  -- python /data/srp/raydata/code/your-job.py
```

**Runtime Environment Parameters:**
- `pip`: List of Python packages to install
- `env_vars`: Environment variables (input/output paths, configs)

**Important Notes:**
- Code must be in `/data/srp/` (mounted via JuiceFS)
- RayCluster provides auto-scaling, failover, and job scheduling
- Dashboard: https://ray.g.yesy.online/

### 4. Scheduled Jobs in Airflow

For periodic execution, use Airflow BashOperator:

```yaml
operator: airflow.operators.bash.BashOperator
bash_command: |-
    echo "Installing ray[data]..."
    pip install ray[data]
    ~/.local/bin/ray job submit \
      --runtime-env-json='{"pip": ["torch"], "env_vars": {"INPUT_PATH": "..."}}' \
      -- python /data/srp/raydata/code/your-job.py

env:
    RAY_ADDRESS: "https://ray.g.yesy.online"
dependencies:
    - start
```

**Reference:** https://github.com/SerendipityOneInc/favie-data-etl/tree/main/dags/raydata_job_demo

## Code Structure

### Basic Ray Data Pipeline

```python
import os
import ray

# 1. Initialize Ray session
ray.init()

# 2. Load data
# From S3
ds = ray.data.read_parquet("s3://bucket/path/*.parquet")
# From JuiceFS
ds = ray.data.read_parquet("/data/srp/project/data/*.parquet")
# Images
ds = ray.data.read_images("s3://bucket/images/", mode="RGB")

# 3. Transform data
ds = ds.map_batches(
    YourProcessor,
    compute=ray.data.ActorPoolStrategy(size=1),
    num_gpus=1,
    batch_size=16
)

# 4. Save results
ds.write_parquet("/data/srp/project/output/")
```

### Processor Class Pattern

**Simple Function UDF:**

```python
def process_batch(batch):
    # Process batch data
    batch["result"] = [compute(item) for item in batch["input"]]
    return batch

ds = ds.map_batches(process_batch, batch_size=32)
```

**Model-Based Processor (Recommended):**

```python
from typing import Dict
import numpy as np
from transformers import pipeline
from PIL import Image

BATCH_SIZE = 16

class ImageClassifier:
    def __init__(self):
        # Load model once in __init__
        self.classifier = pipeline(
            "image-classification",
            model="google/vit-base-patch16-224",
            device=0  # GPU device
        )

    def __call__(self, batch: Dict[str, np.ndarray]):
        # Convert numpy arrays to PIL Images
        images = [Image.fromarray(img) for img in batch["image"]]

        # Run inference
        outputs = self.classifier(
            images,
            top_k=1,
            batch_size=BATCH_SIZE
        )

        # Add results to batch
        batch["score"] = [out[0]["score"] for out in outputs]
        batch["label"] = [out[0]["label"] for out in outputs]
        return batch

# Use with ActorPoolStrategy for GPU efficiency
predictions = ds.map_batches(
    ImageClassifier,
    compute=ray.data.ActorPoolStrategy(size=1),  # Number of GPU replicas
    num_gpus=1,  # GPUs per replica
    batch_size=BATCH_SIZE
)
```

### Using vLLM for Batch Inference

```python
from ray.data.llm import LLMPredictor, vLLMEngineProcessorConfig

model_id = "meta-llama/Llama-3.1-8B-Instruct"

processor = vLLMEngineProcessorConfig(
    model_id=model_id,
    tensor_parallel_size=1,
    max_model_len=2048,
    max_num_batched_tokens=4096
)

ds = ds.map_batches(
    LLMPredictor,
    fn_constructor_kwargs={"processor": processor},
    num_gpus=1,
    batch_size=32
)
```

## Best Practices

### Performance Optimization

1. **Batch Sizing:**
   - Use largest batch size that fits in GPU memory
   - Larger batches = better GPU utilization
   - Start with batch_size=16, increase until OOM

2. **Concurrent Processing:**
   - Separate CPU preprocessing from GPU inference
   - Use multiple `map_batches` operations
   - Enables parallel preprocessing while inference runs

3. **GPU Utilization:**
   - Set `num_gpus=1` per actor
   - Use `ActorPoolStrategy(size=N)` for N GPU replicas
   - Match replicas to available GPUs in cluster

4. **Memory Management:**
   - Monitor memory usage in Ray dashboard
   - Reduce batch_size if hitting OOM
   - Use smaller models or more capable GPUs

### Error Handling

```python
# Set AWS region to avoid endpoint resolution issues
import os
if "AWS_DEFAULT_REGION" not in os.environ:
    os.environ["AWS_DEFAULT_REGION"] = "us-east-1"

# Use environment variables for paths
input_path = os.environ.get("INPUT_PATH", "default/path")
output_path = os.environ.get("OUTPUT_PATH", "default/output")

# Add error handling in processor
class RobustProcessor:
    def __call__(self, batch):
        try:
            # Process batch
            return batch
        except Exception as e:
            print(f"Error processing batch: {e}")
            # Add error column or skip
            batch["error"] = str(e)
            return batch
```

## Monitoring & Debugging

### Ray Dashboard

Access dashboard at: https://ray.g.yesy.online/

**Key Metrics:**
- **Job Status:** Running/completed/failed jobs
- **Cluster Nodes:** Available GPUs, CPU, memory
- **Task Timeline:** Per-task execution time
- **Operator Metrics:** Throughput, batch processing time
- **Resource Usage:** GPU utilization, memory pressure

### Viewing Job Logs

```bash
# List jobs
ray job list

# Get job logs
ray job logs <job_id>

# Follow logs in real-time
ray job logs <job_id> --follow
```

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| **GPU OOM** | Batch too large | Reduce `batch_size` |
| **CPU OOM** | Too many concurrent actors | Increase `num_cpus` per actor |
| **Slow preprocessing** | Sequential processing | Separate into distinct `map` operations |
| **Low GPU utilization** | Batch too small | Increase `batch_size` |
| **Model loading fails** | Missing dependencies | Add to `runtime-env-json` pip list |
| **S3 access errors** | Missing AWS region | Set `AWS_DEFAULT_REGION` env var |

### Debug Mode

```python
# Run with local mode for debugging
ray.init(local_mode=True)  # Single-process execution

# Take small sample for testing
sample = ds.take(10)  # Get 10 items
print(sample)

# Limit data for quick tests
ds = ds.limit(100)  # Process only 100 items
```

## Example Workflows

### 1. Image Classification

```python
import os
import ray
from transformers import pipeline
from PIL import Image

ray.init()

ds = ray.data.read_images(
    os.environ.get("INPUT_PATH", "s3://bucket/images/"),
    mode="RGB"
)

class ImageClassifier:
    def __init__(self):
        self.classifier = pipeline(
            "image-classification",
            model="google/vit-base-patch16-224",
            device=0
        )

    def __call__(self, batch):
        images = [Image.fromarray(img) for img in batch["image"]]
        outputs = self.classifier(images, top_k=1, batch_size=16)
        batch["label"] = [out[0]["label"] for out in outputs]
        batch["score"] = [out[0]["score"] for out in outputs]
        return batch

predictions = ds.map_batches(
    ImageClassifier,
    compute=ray.data.ActorPoolStrategy(size=1),
    num_gpus=1,
    batch_size=16
)

predictions.write_parquet(
    os.environ.get("OUTPUT_PATH", "/data/srp/output/")
)
```

### 2. Vision-Language Model (Qwen-VL)

```python
import os
import ray
import torch
from transformers import AutoProcessor, AutoModelForVision2Seq
from PIL import Image
from qwen_vl_utils import process_vision_info

ray.init()

ds = ray.data.read_images(
    os.environ.get("INPUT_PATH", "s3://bucket/images/"),
    mode="RGB"
)

PROMPT = os.environ.get(
    "PROMPT",
    "请详细描述这张图片中的内容，包括主要对象、场景和任何值得注意的细节。"
)

class QwenVLAnalyzer:
    def __init__(self):
        model_name = "Qwen/Qwen3-VL-8B-Instruct-FP8"
        self.processor = AutoProcessor.from_pretrained(model_name)
        self.model = AutoModelForVision2Seq.from_pretrained(
            model_name,
            torch_dtype=torch.float16,
            device_map="auto"
        )
        self.model.eval()

    def __call__(self, batch):
        images = [Image.fromarray(img) for img in batch["image"]]

        messages_list = [
            [{
                "role": "user",
                "content": [
                    {"type": "image", "image": img},
                    {"type": "text", "text": PROMPT}
                ]
            }]
            for img in images
        ]

        image_inputs, video_inputs = process_vision_info(messages_list)
        texts = self.processor.apply_chat_template(
            messages_list,
            tokenize=False,
            add_generation_prompt=True
        )

        inputs = self.processor(
            text=texts,
            images=image_inputs,
            videos=video_inputs,
            padding=True,
            return_tensors="pt"
        ).to(self.model.device)

        with torch.no_grad():
            generated_ids = self.model.generate(**inputs, max_new_tokens=512)
            generated_ids_trimmed = [
                out[len(inp):]
                for inp, out in zip(inputs.input_ids, generated_ids)
            ]
            output_texts = self.processor.batch_decode(
                generated_ids_trimmed,
                skip_special_tokens=True,
                clean_up_tokenization_spaces=False
            )

        batch["description"] = output_texts
        return batch

predictions = ds.map_batches(
    QwenVLAnalyzer,
    compute=ray.data.ActorPoolStrategy(size=1),
    num_gpus=1,
    batch_size=20
)

predictions.write_parquet(
    os.environ.get("OUTPUT_PATH", "/data/srp/output/")
)
```

### 3. Batch Inference with vLLM

Reference: https://github.com/SerendipityOneInc/ray-data-etl/blob/main/jobs/demo/raydata-demo-qwenvl-vllm.py

### 4. HTTP API Inference

Reference: https://github.com/SerendipityOneInc/ray-data-etl/blob/main/jobs/demo/raydata-demo-qwenvl-http.py

## Resources

### Official Documentation
- Ray Data Quickstart: https://docs.ray.io/en/latest/data/quickstart.html
- Working with LLMs: https://docs.ray.io/en/latest/data/working-with-llms.html
- Batch Inference: https://docs.ray.io/en/latest/data/batch_inference.html
- Loading Data: https://docs.ray.io/en/releases-2.52.0/data/loading-data.html
- Transforming Data: https://docs.ray.io/en/releases-2.52.0/data/transforming-data.html
- Working with Images: https://docs.ray.io/en/releases-2.52.0/data/working-with-images.html
- Runtime Environments: https://docs.ray.io/en/latest/ray-core/handling-dependencies.html

### SRP Resources
- RayData Wiki: https://starquest.feishu.cn/wiki/Kpb3w8MNZieJGkkMhbqcIkrTnTc
- ray-data-etl Project: https://github.com/SerendipityOneInc/ray-data-etl
- RayCluster Dashboard: https://ray.g.yesy.online/
- Airflow Examples: https://github.com/SerendipityOneInc/favie-data-etl/tree/main/dags/raydata_job_demo

## Quick Reference

### Common Commands

```bash
# Local development
ssh oci-dev2.ssh.buildagi.us
python3 -m venv venv && source venv/bin/activate
pip install ray[data]

# Slurm testing
ssh -p 2222 zhuguangbin@129.80.180.16
sapptainer -c 20 -m 200G -g 1 -p h100 -i /data/srp/apptainer/ray_2.52.0-py310-gpu.sif

# Production submission
export RAY_ADDRESS="https://ray.g.yesy.online"
ray job submit --runtime-env-json='...' -- python /data/srp/raydata/code/job.py

# Monitoring
ray job list
ray job logs <job_id> --follow
```

### File Locations
- Code storage: `/data/srp/raydata/code/`
- Output storage: `/data/srp/project/output/`
- Apptainer images: `/data/srp/apptainer/`

## Implementation Steps

When helping users with Ray Data jobs, follow this workflow:

1. **Understand Requirements:**
   - What type of processing? (inference, ETL, preprocessing)
   - Input data source and format
   - Model requirements (GPU memory, batch size)
   - Expected output format

2. **Choose Development Environment:**
   - Start with A10 local development for testing
   - Move to Slurm H100/H200 if needed for larger models
   - Deploy to RayCluster for production scale

3. **Write Code:**
   - Use the processor class pattern
   - Include proper error handling
   - Use environment variables for paths
   - Start with small batch sizes

4. **Test Iteratively:**
   - Test with `.take(10)` or `.limit(100)` first
   - Verify output format
   - Check resource usage in dashboard
   - Optimize batch size and concurrency

5. **Deploy to Production:**
   - Submit to RayCluster with proper runtime-env
   - Monitor via dashboard
   - Set up Airflow scheduling if needed

6. **Debug Issues:**
   - Check Ray dashboard for errors
   - Review job logs
   - Adjust batch size or resources
   - Consult troubleshooting table
