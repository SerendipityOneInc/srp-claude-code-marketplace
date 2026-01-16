# SRP DevOps Plugin (SRP运维插件)

运维专用插件，扩展 srp-allstaff 功能，增加 Kubernetes 管理、云资源监控、告警处理等运维工具。

DevOps-specific plugin that extends srp-allstaff with Kubernetes management, cloud resource monitoring, alert handling, and other operations tools.

## Overview (概述)

The SRP DevOps plugin builds on the srp-allstaff foundation, adding essential DevOps tools including Kubernetes cluster management, GCP cloud resource monitoring, and infrastructure operations.

SRP运维插件基于 srp-allstaff 基础，增加了 Kubernetes 集群管理、GCP 云资源监控、基础设施运维等核心工具。

## Features (功能特性)

### 📦 Inherited from srp-allstaff (继承自 srp-allstaff)
- 📄 Lark Docs Access (飞书云文档访问)
- 💬 Lark Messages (飞书消息管理)

### 🆕 DevOps-Specific Features (运维专属功能)

#### ☸️ Kubernetes Management (Kubernetes 管理)
- View pod status and logs
- Monitor deployments and services
- Check resource usage
- Troubleshoot cluster issues
- **Read-only**: Safe investigation operations

#### ☁️ Cloud Resources Management (云资源管理)
- Manage GCP Compute Engine instances
- Monitor Cloud Storage buckets
- Review network and firewall rules
- Audit resource access and security
- Track costs and quotas

## Prerequisites (前置要求)

### 1. Install srp-allstaff First (先安装 srp-allstaff)

This plugin depends on srp-allstaff:
```bash
/plugin install srp-allstaff@srp-claude-code-marketplace
```

### 2. Set Up Environment Variables (设置环境变量)

**Lark (from srp-allstaff):**
```bash
export LARK_APP_ID="cli_your_app_id"
export LARK_APP_SECRET="your_app_secret"
```

**GCP:**
```bash
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_REGION="us-east1"
export GCP_ZONE="us-east1-b"
```

**Reload shell:**
```bash
source ~/.zshrc  # or source ~/.bashrc
```

### 3. Install and Configure Tools (安装和配置工具)

**kubectl (for Kubernetes):**
```bash
# Install kubectl
# macOS: brew install kubectl
# Linux: See https://kubernetes.io/docs/tasks/tools/

# Configure cluster access
kubectl config use-context <your-cluster>

# Verify access
kubectl cluster-info
```

**gcloud (for GCP):**
```bash
# Install gcloud SDK
# See https://cloud.google.com/sdk/docs/install

# Authenticate
gcloud auth login

# Set default project
gcloud config set project srpproduct-dc37e

# Verify access
gcloud projects describe srpproduct-dc37e
```

## Installation (安装)

```bash
# Navigate to marketplace directory
cd ~/Downloads/srp-claude-code-marketplace

# Install the plugin
/plugin install srp-devops@srp-claude-code-marketplace
```

## Usage (使用方法)

### Skill 1: Kubernetes Management (Kubernetes 管理)

**Activate the skill:**
```bash
/k8s-management
```

**Example prompts:**

Chinese (中文):
```
显示 production namespace 中的所有 pods
查看 pod api-server-abc123 的日志
检查集群资源使用情况
哪些 pods 出现了问题？
```

English:
```
List all pods in the production namespace
Get logs from pod api-server-abc123
Show cluster resource usage
Which pods are having issues?
```

**Key operations:**
- 📋 List pods, services, deployments
- 📊 Monitor resource usage
- 📝 View pod logs
- 🔍 Troubleshoot issues
- ⚠️ **Read-only**: No modifications

### Skill 2: Cloud Resources (云资源管理)

**Activate the skill:**
```bash
/cloud-resources
```

**Example prompts:**

Chinese (中文):
```
显示所有 GCE 实例
列出所有 GCS buckets
检查防火墙规则是否安全
审计项目资源使用情况
```

English:
```
List all Compute Engine instances
Show all Cloud Storage buckets
Check if firewall rules are secure
Audit project resource usage
```

**Key operations:**
- 💻 Manage compute instances
- 📦 Monitor storage buckets
- 🔒 Review security settings
- 📊 Track resource costs
- ⚠️ Management operations require caution

## Configuration (配置)

### Tool Requirements

This plugin uses command-line tools:
- **kubectl**: Kubernetes cluster management
- **gcloud**: GCP resource management

No additional MCP servers are required for this plugin.

## Troubleshooting (故障排除)

### Issue 1: "kubectl: command not found"

**Problem:** kubectl is not installed.

**Solutions:**
1. Install kubectl:
   - macOS: `brew install kubectl`
   - Linux: Follow https://kubernetes.io/docs/tasks/tools/
2. Verify installation: `kubectl version --client`
3. Restart Claude Code

### Issue 2: "Cannot connect to cluster"

**Problem:** kubectl is not configured or cluster is unreachable.

**Solutions:**
1. Check kubectl context: `kubectl config current-context`
2. List available contexts: `kubectl config get-contexts`
3. Switch context: `kubectl config use-context <context-name>`
4. Verify access: `kubectl cluster-info`

### Issue 3: "gcloud: command not found"

**Problem:** gcloud SDK is not installed.

**Solutions:**
1. Install gcloud: https://cloud.google.com/sdk/docs/install
2. Add to PATH
3. Authenticate: `gcloud auth login`
4. Set project: `gcloud config set project srpproduct-dc37e`

### Issue 4: "Permission denied" (GCP)

**Problem:** Insufficient IAM permissions.

**Solutions:**
1. Check current account: `gcloud auth list`
2. Verify IAM roles in GCP Console
3. Contact GCP admin for access
4. Required roles:
   - `roles/compute.viewer`
   - `roles/storage.objectViewer`
   - `roles/container.viewer`

## Permissions & Security (权限与安全)

### Kubernetes Access (Kubernetes 访问)
- Defined by RBAC roles
- Read-only operations recommended
- Required permissions:
  - `pods/list`, `pods/get`, `pods/log`
  - `services/list`, `deployments/list`
  - `nodes/list`

### GCP Access (GCP 访问)
- Defined by IAM roles
- Read operations: Viewer roles
- Management operations: Admin roles (use with caution)
- All operations are logged in Cloud Audit Logs

### Best Practices (最佳实践)
- Use least privilege access
- Prefer read-only operations for investigation
- Follow change management for modifications
- Document all infrastructure changes
- Regular access reviews

## Examples (示例场景)

### Example 1: Troubleshoot Production Issue (生产问题排查)

```bash
/k8s-management

Prompt: "production namespace 中有 pod 在 crash，帮我排查原因"

Claude will:
1. List pods in production namespace
2. Identify pods with issues (CrashLoopBackOff, Error)
3. Get pod details and events
4. Retrieve and analyze pod logs
5. Diagnose root cause
6. Suggest remediation steps
```

### Example 2: Security Audit (安全审计)

```bash
/cloud-resources

Prompt: "审计 GCP 防火墙规则，检查是否有安全风险"

Claude will:
1. List all firewall rules
2. Check for overly permissive rules (0.0.0.0/0)
3. Identify exposed services
4. Review port configurations
5. Generate security audit report
6. Recommend remediation actions
```

### Example 3: Resource Optimization (资源优化)

```bash
# Check Kubernetes resources
/k8s-management
Prompt: "哪些 pods 占用资源最多？"

# Then check GCP resources
/cloud-resources
Prompt: "显示 GCE 实例的资源使用和成本"

Claude will provide comprehensive resource analysis across K8s and GCP.
```

## Limitations (限制)

### Current Limitations
- Uses CLI tools (kubectl, gcloud) not direct APIs
- No real-time monitoring dashboards
- No automated remediation
- Limited to configured clusters and projects
- No integration with monitoring systems (Prometheus, Grafana)

### Future Enhancements
- Direct Kubernetes/GCP API integration via MCP
- Real-time monitoring and alerting
- Automated issue detection
- Integration with monitoring tools
- Incident response workflows
- Cost optimization recommendations
- Terraform/IaC integration

## Support (支持)

### Documentation
- Plugin: `plugins/srp-devops/README.md` (this file)
- Skills:
  - `plugins/srp-devops/skills/k8s-management/SKILL.md`
  - `plugins/srp-devops/skills/cloud-resources/SKILL.md`

### Getting Help
- Internal support: Contact SRP Team (team@srp.one)
- Kubernetes docs: https://kubernetes.io/docs/
- GCP docs: https://cloud.google.com/docs

## Safety Guidelines (安全指南)

### Read-Only Operations (只读操作) ✅
- List resources
- View status and logs
- Check configurations
- Monitor metrics
- Safe for investigation

### Management Operations (管理操作) ⚠️
- Restart pods/instances
- Modify configurations
- Create/delete resources
- Change security settings
- **Require caution and proper authorization**

**Always follow change management processes for any infrastructure modifications.**

## Version History (版本历史)

### v1.0.0 (2026-01-16)
- Initial release
- Depends on srp-allstaff v1.0.0
- Kubernetes Management skill
- Cloud Resources skill
- Bilingual documentation

## License (许可证)

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-devops
**Version:** 1.0.0
**Dependencies:** srp-allstaff ^1.0.0
**Author:** SRP Team (team@srp.one)
**Tags:** kubernetes, k8s, monitoring, devops, gcp, cloud
