# SRP Claude Code Marketplace 使用指南

> 内部工具集成平台 | 让 AI 助手更懂你的工作流

---

## 📌 概述

**SRP Claude Code Marketplace** 是 Serendipity One Inc. (SRP) 为内部员工打造的 Claude Code 插件市场。通过这个平台，你可以让 Claude AI 助手无缝对接公司内部的各种工具和服务。

### 🎯 核心价值

- **🔌 开箱即用**：预配置的插件，安装即可使用
- **🔐 安全可靠**：基于你的真实身份和权限，无需担心权限泄露
- **🚀 提升效率**：用自然语言操作飞书、Gmail、GitHub、GCP、Kubernetes 等工具
- **🤖 智能自动化**：通过 Rube 实现跨应用办公自动化，告别重复性工作
- **🔧 持续更新**：由 SRP 团队维护，定期增加新功能

---

## 🧩 可用插件

### 1. 📱 **SRP AllStaff**（全员基础插件）

**面向人群**：所有 SRP 员工

**功能**：飞书（Lark/Feishu）深度集成 + Rube 办公自动化

#### 🔷 飞书集成

**核心能力**：
- ✅ **文档搜索**：快速查找云文档、电子表格、多维表格、知识库
- ✅ **群聊管理**：查看群列表、群成员、历史消息
- ✅ **消息收发**：读取和发送飞书消息（文本、富文本、卡片等）

**使用命令**：
```bash
/srp:msg          # 飞书消息管理
/srp:docs         # 飞书文档搜索
/srp:lark-messages  # 飞书消息与群组访问
/srp:lark-docs      # 飞书云文档权限访问
```

**典型场景**：
```
"搜索包含 OKR 的文档"
"显示产品团队群的最新消息"
"给张三发送一条飞书消息：会议推迟到下午3点"
```

#### 🤖 **Rube 办公自动化**（重要功能）

> **强烈推荐**：所有 SRP 员工配置 Rube，实现跨应用的智能办公自动化

**Rube 是什么？**

Rube 是由 Composio 提供的 AI 自动化平台，让 Claude 能够直接操作你日常使用的各种办公工具。通过 Rube，你可以用自然语言指挥 AI 完成跨应用的复杂任务，大幅提升工作效率。

**核心优势**：
- 🔗 **统一接口**：一次配置，连接所有你的工作应用
- 🤖 **智能执行**：AI 自动处理多步骤、跨应用的工作流
- 🔐 **安全认证**：基于 OAuth 授权，遵循你的真实权限
- 🎯 **场景丰富**：邮件、日历、任务、文档等全方位覆盖

**支持的应用集成**：
- ✉️ **Gmail / Google Workspace**：邮件管理、智能摘要、自动回复
- 📅 **Google Calendar**：日程安排、会议管理、时间阻塞
- 📁 **Google Drive**：文档搜索、文件管理、协作
- 📋 **Linear**：任务创建、Issue 管理、项目追踪
- 📝 **Notion**：笔记整理、知识库管理
- 💬 **Slack**：消息管理、频道监控（可选）

**推荐使用场景**：

1. **📧 智能邮件助手**
   ```
   "总结今天所有未读邮件的要点"
   "给 John 发一封邮件，主题是项目进度汇报"
   "查找上周来自产品团队的所有邮件"
   ```

2. **📅 日历与时间管理**
   ```
   "明天上午 10 点安排一个 1 小时的团队会议"
   "帮我在日历上标记下周的专注工作时间"
   "查看本周我有哪些会议"
   ```

3. **✅ 任务流转自动化**
   ```
   "把这封邮件转成 Linear 任务"
   "创建一个新的 Linear Issue：修复登录 Bug，优先级高"
   "查看我在 Linear 上今天要完成的任务"
   ```

4. **📄 文档协作**
   ```
   "在 Google Drive 中搜索 Q1 OKR 相关的文档"
   "创建一个新的 Google Doc，标题是会议纪要"
   "把这段文字保存到 Notion 的工作笔记中"
   ```

5. **🔄 跨应用工作流**
   ```
   "从 Gmail 读取客户反馈邮件，创建 Linear Issue，并在 Notion 中记录"
   "总结今天的 Slack 消息，整理成日报发送给我的邮箱"
   "查看明天的日程，如果有空闲时间就创建一个专注时间块"
   ```

**如何配置 Rube？**

1. **注册 Rube 账号**
   - 访问：https://rube.app/
   - 使用公司邮箱注册账号

2. **连接你的工作应用**
   - 登录后进入 Settings → Connections
   - 依次授权连接：
     - ✅ Gmail / Google Workspace（必需）
     - ✅ Google Calendar（必需）
     - ✅ Google Drive（推荐）
     - ✅ Linear（推荐）
     - ✅ Notion（可选）
     - ✅ Slack（可选）

3. **在 Claude Code 中配置**
   - Rube 已集成在 `srp-allstaff` 插件中
   - 安装插件后，Claude 会自动使用你的 Rube 连接
   - 只需确保你在 https://rube.app/ 上完成了应用授权

4. **验证配置**
   ```
   "帮我总结今天的邮件"
   ```
   如果能够成功执行，说明 Rube 配置成功！

**注意事项**：
- 🔐 首次使用时，Rube 会引导你完成 OAuth 授权流程
- 🔐 你的凭证和数据不会被 SRP 或 Claude 直接访问
- 🔐 所有操作都基于你的真实权限，不会越权
- 💡 定期检查 https://rube.app/ 的连接状态，确保授权未过期

**参考资源**：
- 官方网站：https://rube.app/
- MCP 市场：https://mcpmarket.com/server/rube

---

### 2. 💻 **SRP Developer**（开发者插件）

**面向人群**：研发工程师、算法工程师、数据工程师

**前置要求**：需先安装 `srp-allstaff`

**功能扩展**：GitHub + GCP 读取权限 + Cloudflare 开发工具 + Ray Data 数据处理 + Slurm 集群管理

#### 🔷 GitHub 集成

**核心能力**：
- ✅ **代码审查**：列出 PR、提交代码审查意见、管理 Issue
- ✅ **自动化**：查看 CI/CD 状态、搜索代码、管理分支
- ✅ **协作**：Fork 仓库、创建分支、合并 PR

**使用命令**：
```bash
/srp:github       # GitHub 集成
/srp:gh          # GitHub 快捷方式
```

**典型场景**：
```
"列出 srp-claude-code-marketplace 仓库中待审查的 PR"
"帮我审查 PR #123，检查代码质量"
"在 main 分支创建一个新分支 feature/add-cloudflare-support"
```

#### 🔷 GCP 开发者访问

**核心能力**：
- ✅ **BigQuery 查询**：执行 SELECT 查询、查看表结构（只读权限）
- ✅ **数据探索**：列出数据集和表、查看表 Schema
- ✅ **数据分析**：执行复杂 SQL 查询、导出结果

**使用命令**：
```bash
/srp:gcp         # GCP 开发者访问
/srp:bq          # BigQuery 快捷方式
```

**典型场景**：
```
"查询 analytics.user_events 表的前 10 条记录"
"显示 srpproduct-dc37e 项目中的所有 BigQuery 表"
"分析上周的用户活跃度数据"
```

#### ☁️ Cloudflare 开发工具

> **新功能**：支持 Cloudflare 全栈开发，包括边缘计算、无服务器函数、存储服务

**核心能力**：

1. **Cloudflare Workers**（边缘计算）
   - ⚡ 创建和部署无服务器函数到全球边缘网络
   - ⚡ 使用 Wrangler CLI 管理 Workers 项目
   - ⚡ 本地开发和调试（Miniflare）
   - ⚡ 集成 KV、Durable Objects、R2、D1、Queues

2. **Cloudflare KV**（键值存储）
   - 💾 低延迟的全球分布式键值存储
   - 💾 适合存储配置、会话、缓存等数据
   - 💾 与 Workers 无缝集成

3. **Cloudflare Pages**（全栈部署）
   - 🌐 全栈 JAMstack 平台，支持静态站点和无服务器函数
   - 🌐 Git 集成，自动构建和部署
   - 🌐 全球 CDN 加速
   - 🌐 原生绑定 Workers、KV、R2、D1、Durable Objects

4. **Cloudflare R2**（对象存储）
   - 📦 S3 兼容 API 的对象存储
   - 📦 零出口费用（Zero egress fees）
   - 📦 适合存储媒体文件、备份、静态资源

**使用命令**：
```bash
# Cloudflare Workers
"创建一个新的 Cloudflare Worker 项目"
"部署这个 Worker 到生产环境"
"在本地测试这个 Worker"

# Cloudflare KV
"在 KV 中存储配置数据"
"从 KV 读取用户会话信息"

# Cloudflare Pages
"创建一个新的 Pages 项目"
"部署这个静态站点到 Cloudflare Pages"

# Cloudflare R2
"上传文件到 R2 存储桶"
"从 R2 获取对象列表"
```

**典型场景**：
```
"帮我创建一个 Cloudflare Worker，用于处理 API 请求并缓存到 KV"
"部署这个 Next.js 项目到 Cloudflare Pages"
"在 R2 中创建一个新的存储桶来存储用户上传的图片"
"配置 Worker 连接到 KV 和 R2"
```

**参考资源**：
- Cloudflare Workers 文档：https://developers.cloudflare.com/workers/
- Cloudflare Pages 文档：https://developers.cloudflare.com/pages/
- Cloudflare R2 文档：https://developers.cloudflare.com/r2/
- Cloudflare KV 文档：https://developers.cloudflare.com/kv/

#### 🚀 Ray Data 数据处理

> **新功能**：大规模分布式数据处理和 GPU 批量推理，专为机器学习工作负载优化

**核心能力**：

1. **分布式数据处理**
   - 📊 处理超出单机内存的大规模数据集
   - 🖼️ 图像、视频、文本等多模态数据支持
   - ⚡ CPU/GPU 协同处理，最大化资源利用率
   - 🔄 自动容错和任务重试机制

2. **批量推理优化**
   - 🤖 支持 Transformers、vLLM、OpenAI API 等多种推理方式
   - 🎯 自动 batch 优化，提升 GPU 利用率
   - 💾 内存管理优化，避免 OOM
   - 📈 性能监控和调优指导

3. **开发到生产全流程**
   - 💻 **本地开发**：A10 开发机快速迭代
   - 🧪 **GPU 测试**：Slurm H100/H200 大模型测试
   - 🚀 **生产部署**：RayCluster 自动扩缩容
   - 📅 **定时调度**：Airflow 周期性执行

**使用命令**：
```bash
srp:raydata       # Ray Data 数据处理技能
/raydata          # 或使用原始技能名
```

**典型场景**：

```
# 批量推理
"创建一个 Ray Data job 对 1000 张图片进行分类"
"使用 vLLM 在 RayCluster 上批量处理文本数据"
"优化这个批量推理脚本的 GPU 内存使用"

# 数据处理
"用 Ray Data 读取 S3 上的 Parquet 文件并做数据清洗"
"并行处理视频数据集，提取关键帧"

# 部署和调度
"把这个 Ray Data job 部署到 RayCluster"
"设置 Airflow 每天凌晨 2 点运行这个数据处理任务"
"查看 Ray job 的运行状态和性能指标"
```

**开发工作流程**：

```
1. 本地开发（A10）
   ├─ 编写 Ray Data Pipeline 代码
   ├─ 使用小数据集测试
   └─ 验证逻辑正确性

2. GPU 测试（Slurm）
   ├─ 在 H100/H200 上测试大模型
   ├─ 验证 GPU 内存使用
   └─ 性能基准测试

3. 生产部署（RayCluster）
   ├─ 提交到 RayCluster
   ├─ 自动资源扩缩容
   └─ Dashboard 监控

4. 定时调度（Airflow）
   └─ 设置周期性执行
```

**性能优化要点**：
- ✅ Batch size：使用最大 GPU 可承受的 batch size
- ✅ 并发度：根据 GPU 数量调整 ActorPoolStrategy size
- ✅ 预处理：将 CPU 密集操作与 GPU 推理分离
- ✅ 内存管理：监控 GPU 显存，避免 OOM

**参考资源**：
- Ray Data Dashboard: https://ray.g.yesy.online/
- 官方文档: https://docs.ray.io/en/latest/data/quickstart.html
- SRP Wiki: https://starquest.feishu.cn/wiki/Kpb3w8MNZieJGkkMhbqcIkrTnTc
- GitHub: https://github.com/SerendipityOneInc/ray-data-etl

#### 🖥️ Slurm 集群管理

> **新功能**：GPU 集群作业提交和管理，支持 H100/H200 大规模训练和推理

**核心能力**：

1. **GPU 作业提交**
   - 🎯 简化的作业脚本模板
   - 🐳 Apptainer 容器集成
   - 🔧 多节点分布式训练支持
   - 📊 自动资源分配和调度

2. **集群监控**
   - 📈 Grafana 实时监控面板
   - 💬 自动飞书消息通知（作业开始/完成/失败）
   - 🔍 Job 级别性能分析
   - 📉 资源使用趋势追踪

3. **便捷管理**
   - ⚡ ssubmit 封装工具，简化提交流程
   - 📋 作业队列管理
   - 🔄 作业取消和重启
   - 🐛 故障排查指南

**可用集群**：

| 集群 | GPU 型号 | 访问方式 | 用途 |
|------|---------|---------|------|
| **Oracle OKE** | H100 | `ssh -p 2222 <username>@129.80.180.16` | 大模型训练、高性能推理 |
| **DO DOKS** | H200 | `ssh -p 2222 <username>@129.212.240.50` | 最新 GPU、大规模训练 |

**使用命令**：
```bash
srp:slurm         # Slurm 集群管理技能
/slurm            # 或使用原始技能名
```

**典型场景**：

```
# 作业提交
"写一个 Slurm 脚本在 H100 上训练 GPT 模型"
"提交一个使用 2 个 GPU 的训练任务到 Oracle 集群"
"用 Apptainer 容器运行 PyTorch 训练脚本"

# 作业管理
"查看我在 DO 集群上运行的所有任务"
"取消 job ID 为 12345 的任务"
"为什么我的任务一直在排队？"

# 监控调试
"查看 Oracle 集群的 GPU 可用情况"
"这个作业为什么失败了？帮我看看日志"
"打开 Grafana 查看集群负载"
```

**核心 Slurm 命令**：

```bash
# 提交作业
sbatch job_script.sh               # 提交批处理作业
ssubmit -j my-job -p h100 -g 2     # 使用 ssubmit 封装工具

# 查看作业
squeue -u $USER                    # 查看我的作业
sinfo -p h100                      # 查看 H100 分区资源

# 管理作业
scancel <job_id>                   # 取消作业
sacct -j <job_id>                  # 查看作业历史

# 监控
nvidia-smi                         # GPU 状态（容器内）
```

**Apptainer 容器使用**：

```bash
# 运行容器
apptainer run --nv /data0/apptainer/pytorch_24.01-py3.sif python train.py

# 交互式容器
sapptainer -c 20 -m 200G -g 1 -p h100 -i /data0/apptainer/pytorch_24.01-py3.sif

# 可用容器镜像
/data0/apptainer/pytorch_24.01-py3.sif      # PyTorch 24.01
/data0/apptainer/ray_2.52.0-py310-gpu.sif  # Ray 2.52.0
```

**自动通知**：
- ✅ 作业开始运行
- ✅ 作业成功完成
- ❌ 作业失败（含错误信息）
- ⏱️ 作业超时
- 📊 资源使用总结
- 🔗 日志文件位置

**监控面板**：

**Oracle OKE 集群：**
- 集群概览: https://grafana.g.yesy.site/d/edrg5th9t1edcb/slinky-slurm
- 工作负载: https://grafana.g.yesy.site/d/f2c83374-71e2-42c6-92a1-10505b584cf2/workload
- Job 统计: https://grafana.g.yesy.site/d/HRLkiLS7k/slurmjobstats

**DO DOKS 集群：**
- 集群概览: https://grafana.g2.yesy.site/d/edrg5th9t1edcb/slinky-slurm
- 工作负载: https://grafana.g2.yesy.site/d/workload/workload
- Job 统计: https://grafana.g2.yesy.site/d/slurm/slurm

**参考资源**：
- Slurm 官方文档: https://slurm.schedmd.com/
- Apptainer 用户指南: https://apptainer.org/docs/user/latest/
- SRP Wiki: https://starquest.feishu.cn/wiki/TZASwm86nivXLTkMV6kcoJF4n2I
- ssubmit 示例: https://github.com/SerendipityOneInc/llm-jobs/tree/main/slurm/ssubmit-examples

---

### 3. 🔧 **SRP DevOps**（运维插件）

**面向人群**：DevOps 工程师、SRE

**前置要求**：需先安装 `srp-allstaff`

**功能扩展**：Kubernetes + GCP 云资源管理

**核心能力**：
- ✅ **Kubernetes 管理**：查看 Pods、Services、Deployments 状态
- ✅ **日志查看**：实时查看 Pod 日志、排查故障
- ✅ **GCP 资源审计**：管理 Compute Engine、Cloud Storage、防火墙规则
- ✅ **成本监控**：追踪资源使用和配额

**使用命令**：
```bash
/srp:k8s         # Kubernetes 管理
/srp:cloud       # GCP 云资源管理
```

**典型场景**：
```
"显示 production 命名空间中所有有问题的 pods"
"查看 api-server pod 的最近 100 行日志"
"列出所有 Compute Engine 实例及其运行状态"
"检查防火墙规则是否存在安全风险"
```

---

## 📦 安装配置

### 步骤 1：添加市场源

在 Claude Code 中执行：

```bash
/plugin marketplace add SerendipityOneInc/srp-claude-code-marketplace
```

### 步骤 2：安装插件

**基础插件（必装）**：
```bash
/plugin install srp-allstaff@srp-claude-code-marketplace
```

**开发者插件（可选）**：
```bash
/plugin install srp-developer@srp-claude-code-marketplace
```

**运维插件（可选）**：
```bash
/plugin install srp-devops@srp-claude-code-marketplace
```

### 步骤 3：配置环境变量

#### 📱 配置飞书（srp-allstaff 必需）

1. 获取飞书应用凭证（联系 IT 部门）
2. 设置环境变量：

```bash
# 编辑 ~/.zshrc 或 ~/.bashrc
export LARK_APP_ID="cli_your_app_id"
export LARK_APP_SECRET="your_app_secret"

# 重新加载配置
source ~/.zshrc
```

#### 🤖 配置 Rube（srp-allstaff 强烈推荐）

**重要提示**：配置 Rube 可以大幅提升办公效率，强烈建议所有员工完成配置！

1. **注册并登录 Rube**
   ```bash
   # 访问 Rube 官网
   open https://rube.app/
   ```
   - 使用你的公司邮箱注册账号
   - 完成邮箱验证

2. **连接你的工作应用**

   登录后，在 Rube 网站上依次授权以下应用：

   **必需连接**（基础办公）：
   - ✅ **Gmail / Google Workspace** - 邮件管理
   - ✅ **Google Calendar** - 日程管理

   **推荐连接**（提升效率）：
   - ✅ **Google Drive** - 文档管理
   - ✅ **Linear** - 任务管理

   **可选连接**（按需配置）：
   - ✅ **Notion** - 笔记和知识库
   - ✅ **Slack** - 团队沟通（如果你使用）

3. **验证 Rube 配置**

   安装 `srp-allstaff` 插件后，直接在 Claude Code 中测试：

   ```bash
   # 在 Claude Code 中尝试
   "帮我总结今天的 Gmail 未读邮件"
   ```

   首次使用时，Rube 会自动引导你完成 OAuth 授权流程。

4. **保持连接状态**

   定期检查应用授权状态：
   ```bash
   # 访问 Rube Settings
   open https://rube.app/settings
   ```

   如果某个应用显示"已过期"，重新授权即可。

**故障排查**：
- 如果 Rube 工具无法使用，先确认你已在 https://rube.app/ 上完成授权
- 检查授权是否过期（访问 Rube Settings → Connections）
- 尝试重新授权对应的应用

#### 💻 配置 GitHub（srp-developer 必需）

1. 创建 GitHub Personal Access Token：
   - 访问：https://github.com/settings/tokens
   - 权限范围：`repo`, `read:user`, `read:org`

2. 设置环境变量：

```bash
export GITHUB_TOKEN="ghp_your_github_token"
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_LOCATION="us-east1"

# 登录 GCP
gcloud auth application-default login
```

#### 🔧 配置 Kubernetes（srp-devops 必需）

```bash
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_REGION="us-east1"
export GCP_ZONE="us-east1-b"

# 配置 kubectl
kubectl config use-context <your-cluster>

# 登录 GCP
gcloud auth login
```

### 步骤 4：验证安装

```bash
/plugin list
```

你应该能看到已安装的 SRP 插件。

---

## 💡 使用示例

### 场景 1：快速找到项目文档

```
用户："帮我找一下 Q1 OKR 相关的文档"

Claude 使用 /srp:docs：
- 搜索飞书云文档
- 返回匹配的文档列表
- 提供直接访问链接
```

### 场景 2：查看团队群聊消息

```
用户："产品团队群里今天讨论了什么？"

Claude 使用 /srp:msg：
- 定位"产品团队"群聊
- 获取今天的消息记录
- 智能摘要关键讨论内容
```

### 场景 3：GitHub 代码审查

```
用户："审查一下我们仓库最新的 PR"

Claude 使用 /srp:github：
- 列出待审查的 PR
- 分析代码变更
- 提出改进建议
- 直接在 GitHub 上提交审查意见
```

### 场景 4：BigQuery 数据分析

```
用户："查询上周的用户活跃度数据"

Claude 使用 /srp:gcp：
- 构建 SQL 查询
- 执行 BigQuery 查询
- 分析数据并生成报告
```

### 场景 5：Kubernetes 故障排查

```
用户："生产环境的 API 服务有问题，帮我排查一下"

Claude 使用 /srp:k8s：
- 列出异常的 Pods
- 查看错误日志
- 分析资源使用情况
- 提供修复建议
```

### 场景 6：Ray Data 批量推理

```
用户："我需要对 10 万张图片做分类，用 ViT 模型"

Claude 使用 /raydata：
- 设计 Ray Data Pipeline
- 配置 GPU 批处理参数
- 生成可运行的 Python 代码
- 指导如何提交到 RayCluster
- 设置性能监控
```

### 场景 7：Slurm GPU 训练

```
用户："提交一个 LLaMA 模型训练任务到 H100 集群"

Claude 使用 /slurm：
- 生成 Slurm 作业脚本
- 配置 Apptainer 容器
- 设置多 GPU 分布式训练
- 提交作业到 Oracle OKE 集群
- 提供 Grafana 监控链接
```

---

## 🔒 安全与权限

### 权限继承原则

所有插件都基于**你的真实身份和权限**工作：

- ✅ **飞书**：使用你的 OAuth 授权，只能访问你有权限的文档和群聊
- ✅ **GitHub**：使用你的 Personal Access Token，遵循你的仓库权限
- ✅ **GCP**：使用你的 gcloud 认证，受 IAM 策略限制
- ✅ **Kubernetes**：使用你的 kubectl 配置，受 RBAC 策略限制

### 数据隐私

- 🔐 所有凭证存储在本地环境变量中
- 🔐 插件不会上传你的敏感信息
- 🔐 所有 API 调用都使用你的身份认证
- 🔐 日志和历史记录仅保存在本地

---

## ❓ 常见问题

### Q1：安装插件后无法使用怎么办？

**A1**：检查以下几点：
1. 确认环境变量已正确设置（`echo $LARK_APP_ID`）
2. 重启 Claude Code 或重新加载配置（`source ~/.zshrc`）
3. 验证 MCP 服务器是否正常运行（查看 Claude Code 日志）
4. 在 [GitHub Issues](https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues) 提交问题寻求帮助

### Q2：为什么我看不到某些飞书文档？

**A2**：插件使用你的真实飞书权限。如果你无法在飞书 App 中访问某个文档，Claude 也无法访问。请联系文档所有者申请权限。

### Q3：srp-developer 和 srp-devops 可以同时安装吗？

**A3**：可以！它们都依赖 `srp-allstaff`，可以共存。你可以根据自己的角色安装所需的插件。

### Q4：如何更新插件到最新版本？

**A4**：
```bash
# 更新市场索引
/plugin marketplace update SerendipityOneInc/srp-claude-code-marketplace

# 重新安装插件
/plugin install srp-allstaff@srp-claude-code-marketplace
```

### Q5：GCP 插件是否有写入权限？

**A5**：
- **srp-developer**：仅读取权限（BigQuery SELECT 查询）
- **srp-devops**：根据你的 GCP IAM 角色，可能包含管理权限（需谨慎操作）

### Q6：Rube 是否安全？会不会泄露我的数据？

**A6**：Rube 的安全性有保障：
- 🔐 使用标准 OAuth 2.0 授权流程，符合行业安全标准
- 🔐 你的凭证（密码、Token）不会被 SRP 或 Claude 直接访问
- 🔐 所有操作都基于你的真实权限，不会越权访问
- 🔐 Rube 由 Composio 提供（知名 AI 工具集成平台），有完善的安全机制
- 💡 你可以随时在 https://rube.app/ 上撤销授权

### Q7：Rube 配置后为什么还是无法使用？

**A7**：请按以下步骤排查：
1. 确认已在 https://rube.app/ 上完成应用授权
2. 检查授权是否过期（访问 Rube Settings → Connections）
3. 确认 `srp-allstaff` 插件已正确安装
4. 尝试重启 Claude Code
5. 如果仍有问题，尝试重新授权对应的应用

### Q8：我可以贡献新的插件吗？

**A8**：当然可以！这是一个内部开源项目：
1. Fork 仓库：https://github.com/SerendipityOneInc/srp-claude-code-marketplace
2. 参考 `plugins/example-hello-world` 创建新插件
3. 提交 PR，CI 会自动验证格式
4. 团队审核后合并

---

## 📞 获取帮助与反馈

我们非常欢迎你的反馈和建议！请通过 **GitHub Issues** 来帮助我们改进：

**👉 https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues**

你可以在这里：
- 🐛 **报告 Bug** - 遇到问题？告诉我们，我们会尽快修复
- 💡 **提出功能建议** - 有好想法？我们很乐意听取
- 📚 **改进文档** - 发现文档不清楚的地方？帮助我们完善
- 🔌 **请求新插件** - 需要某个工具的集成？提交你的需求
- ❓ **寻求帮助** - 使用中遇到困难？在 Issues 中提问

**如何提交 Issue：**
1. 访问上述 GitHub Issues 链接
2. 点击 "New Issue" 按钮
3. 选择合适的模板（Bug Report / Feature Request / Question）
4. 填写详细信息并提交

你的每一个反馈都能帮助我们做得更好！🙏

---

## 🚀 快速上手检查清单

**基础配置（所有员工）：**
- [ ] 添加 marketplace 源
- [ ] 安装 `srp-allstaff` 插件
- [ ] 配置飞书环境变量（LARK_APP_ID, LARK_APP_SECRET）
- [ ] 🌟 **注册并配置 Rube**（强烈推荐）
  - [ ] 访问 https://rube.app/ 注册账号
  - [ ] 连接 Gmail / Google Workspace
  - [ ] 连接 Google Calendar
  - [ ] 连接 Google Drive
  - [ ] 连接 Linear
- [ ] 重启 Claude Code
- [ ] 尝试执行 `/srp:msg` 命令（测试飞书）
- [ ] 尝试 "帮我总结今天的邮件"（测试 Rube）

**进阶配置（开发者/运维）：**
- [ ] （开发者）安装 `srp-developer` 并配置 GitHub Token
- [ ] （算法/数据工程师）尝试 `/raydata` 技能处理数据
- [ ] （ML 工程师）配置 Slurm 集群访问，尝试 `/slurm` 技能
- [ ] （运维）安装 `srp-devops` 并配置 GCP/K8s
- [ ] 查看文档和 GitHub Issues 获取最新消息

---

## 🚧 TODO & 持续优化方向

以下是我们计划持续优化和改进的方向，欢迎提供建议和贡献！

### 🧠 智能记忆系统

**目标**：让 Claude 更懂公司的规范和流程

**计划**：
- [ ] **公司知识库集成**
  - 将 SRP 内部的通用文档、规则、流程整理成结构化知识库
  - 集成到各个 skill 的持久记忆中
  - Claude 能够自动引用公司规范回答问题

- [ ] **技术规范记忆**
  - 编码规范（代码风格、命名约定、最佳实践）
  - 架构设计原则
  - 安全规范和合规要求
  - API 设计标准

- [ ] **流程记忆**
  - Code Review 流程和标准
  - 发布流程和检查清单
  - 事故响应流程
  - 需求管理流程

- [ ] **团队信息记忆**
  - 项目负责人和团队结构
  - 各系统的技术栈和依赖
  - 常见问题和解决方案（FAQ）

**预期效果**：
```
用户："这个代码符合我们的编码规范吗？"
Claude：根据 SRP 编码规范（参考 company-guidelines.md）：
- ✅ 函数命名使用驼峰命名法
- ❌ 缺少必要的错误处理
- ❌ 未添加必要的注释
建议修改...
```

---

### 🔒 研发质量强制流程

**目标**：通过自动化检查提升代码质量和安全性

**计划**：

#### 1. **代码质量检查（必需）**
- [ ] **自动 Lint 检查**
  - 提交前自动运行 ESLint / Pylint / Rustfmt
  - 不通过 lint 检查的代码不允许提交
  - 支持自定义 lint 规则配置

- [ ] **代码格式化**
  - 强制使用 Prettier / Black / rustfmt
  - 自动修复格式问题
  - 统一团队代码风格

- [ ] **类型检查**
  - TypeScript 严格模式检查
  - Python 类型注解检查（mypy）
  - 消除类型不安全的代码

#### 2. **安全检查（必需）**
- [ ] **依赖漏洞扫描**
  - 自动检查 npm / pip / cargo 依赖的已知漏洞
  - 阻止包含高危漏洞的代码提交
  - 提供修复建议和升级路径

- [ ] **代码安全审查**
  - 检测常见安全问题（SQL 注入、XSS、CSRF）
  - 敏感信息泄露检测（密钥、密码、Token）
  - OWASP Top 10 漏洞检查

- [ ] **License 合规检查**
  - 检查依赖包的 License 是否合规
  - 避免引入不兼容的开源许可证

#### 3. **测试覆盖率检查（推荐）**
- [ ] **单元测试覆盖率**
  - 强制要求最低测试覆盖率（如 80%）
  - 自动生成测试覆盖率报告
  - 新增代码必须有对应测试

- [ ] **集成测试验证**
  - 关键路径必须有集成测试
  - API 端点必须有测试覆盖

#### 4. **Code Review 强化（必需）**
- [ ] **自动化 Review 清单**
  - 提交 PR 时自动生成 Review 检查清单
  - 包含：代码质量、安全性、测试、文档
  - 必须通过所有检查项才能合并

- [ ] **AI 辅助 Review**
  - Claude 自动初步审查代码
  - 提供改进建议和潜在问题警告
  - 人工 Review 前的预检查

- [ ] **Review 指标追踪**
  - 记录 Review 时间和质量
  - 识别需要更多关注的代码区域

#### 5. **Git 提交规范（必需）**
- [ ] **Commit Message 规范**
  - 强制使用 Conventional Commits 格式
  - 自动生成 CHANGELOG
  - 提供 commit 模板

- [ ] **分支命名规范**
  - 强制分支命名格式（feature/xxx, bugfix/xxx）
  - 自动关联 Linear Issue

**实现方式**：
- Git Hooks（pre-commit, pre-push）
- GitHub Actions / CI 流程
- Claude Code Skills 集成
- 可配置的规则引擎

**预期效果**：
```
用户："提交这个代码"
Claude：代码质量检查中...
- ✅ Lint 检查通过
- ❌ 发现 1 个安全问题：检测到硬编码的 API Key（line 42）
- ⚠️ 测试覆盖率 65%，低于要求的 80%
- ❌ Commit message 不符合规范

请修复上述问题后再提交。
```

---

### 💡 如何参与

如果你对以上优化方向有想法或建议：

1. **提交 Feature Request**
   - 在 [GitHub Issues](https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues) 中创建新的 Feature Request
   - 标签：`enhancement`

2. **参与开发**
   - Fork 仓库并创建 PR
   - 参考 [贡献指南](#贡献指南)

3. **提供反馈**
   - 在 GitHub Issues 中分享你的使用体验和改进建议

---

## 📊 版本信息

- **Marketplace 版本**：2.1.0
- **最后更新**：2026-01-20
- **插件总数**：5 个（含示例插件）
- **srp-developer 版本**：1.1.1（新增 Ray Data 和 Slurm 命令快捷方式）
- **License**：MIT

---

**Happy Coding with Claude! 🎉**

让 AI 成为你的得力助手，专注于更有价值的工作！
