# SRP DevOps Plugin

DevOps plugin providing Kubernetes management, cloud resource monitoring, and operations tools.

## Overview

The SRP DevOps plugin provides essential DevOps tools including Kubernetes cluster management, GCP cloud resource monitoring, and infrastructure operations.

## Features

#### ☸️ Kubernetes Management
- View pod status and logs
- Monitor deployments and services
- Check resource usage
- Troubleshoot cluster issues
- **Read-only**: Safe investigation operations

#### ☁️ Cloud Resources Management
- Manage GCP Compute Engine instances
- Monitor Cloud Storage buckets
- Review network and firewall rules
- Audit resource access and security
- Track costs and quotas

## Prerequisites

### 1. Set Up Environment Variables

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

### 2. Install and Configure Tools

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

## Installation

```bash
# Navigate to marketplace directory
cd ~/Downloads/srp-claude-code-marketplace

# Install the plugin
/plugin install srp-devops@srp-claude-code-marketplace
```

## Usage

### Available Commands

The plugin provides the following commands with the `srp:` namespace:

| Command | Alias | Skill | Description |
|---------|-------|-------|-------------|
| `srp:k8s` | `srp:k8s-mgmt` | k8s-management | Kubernetes cluster management and monitoring |
| `srp:cloud` | `srp:gcp-ops` | cloud-resources | Cloud resources management for GCP |

**Usage examples:**
```bash
# Full command names
srp:k8s
srp:cloud

# Short aliases
srp:k8s-mgmt
srp:gcp-ops

# Original skill names (also work)
/k8s-management
/cloud-resources
```

### Skill 1: Kubernetes Management

**Activate the skill:**
```bash
srp:k8s  # or srp:k8s-mgmt or /k8s-management
```

**Example prompts:**

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

### Skill 2: Cloud Resources

**Activate the skill:**
```bash
srp:cloud  # or srp:gcp-ops or /cloud-resources
```

**Example prompts:**

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

## Configuration

### Tool Requirements

This plugin uses command-line tools:
- **kubectl**: Kubernetes cluster management
- **gcloud**: GCP resource management

No additional MCP servers are required for this plugin.

## Troubleshooting

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

## Permissions & Security

### Kubernetes Access
- Defined by RBAC roles
- Read-only operations recommended
- Required permissions:
  - `pods/list`, `pods/get`, `pods/log`
  - `services/list`, `deployments/list`
  - `nodes/list`

### GCP Access
- Defined by IAM roles
- Read operations: Viewer roles
- Management operations: Admin roles (use with caution)
- All operations are logged in Cloud Audit Logs

### Best Practices
- Use least privilege access
- Prefer read-only operations for investigation
- Follow change management for modifications
- Document all infrastructure changes
- Regular access reviews

## Examples

### Example 1: Troubleshoot Production Issue

```bash
/k8s-management

Prompt: "There are pods crashing in the production namespace, help me troubleshoot"

Claude will:
1. List pods in production namespace
2. Identify pods with issues (CrashLoopBackOff, Error)
3. Get pod details and events
4. Retrieve and analyze pod logs
5. Diagnose root cause
6. Suggest remediation steps
```

### Example 2: Security Audit

```bash
/cloud-resources

Prompt: "Audit GCP firewall rules and check for security risks"

Claude will:
1. List all firewall rules
2. Check for overly permissive rules (0.0.0.0/0)
3. Identify exposed services
4. Review port configurations
5. Generate security audit report
6. Recommend remediation actions
```

### Example 3: Resource Optimization

```bash
# Check Kubernetes resources
/k8s-management
Prompt: "Which pods are using the most resources?"

# Then check GCP resources
/cloud-resources
Prompt: "Show GCE instance resource usage and costs"

Claude will provide comprehensive resource analysis across K8s and GCP.
```

## Limitations

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

## Support

### Documentation
- Plugin: `plugins/srp-devops/README.md` (this file)
- Skills:
  - `plugins/srp-devops/skills/k8s-management/SKILL.md`
  - `plugins/srp-devops/skills/cloud-resources/SKILL.md`

### Getting Help
- Internal support: Contact SRP Team (infra@srp.one)
- Kubernetes docs: https://kubernetes.io/docs/
- GCP docs: https://cloud.google.com/docs

## Safety Guidelines

### Read-Only Operations ✅
- List resources
- View status and logs
- Check configurations
- Monitor metrics
- Safe for investigation

### Management Operations ⚠️
- Restart pods/instances
- Modify configurations
- Create/delete resources
- Change security settings
- **Require caution and proper authorization**

**Always follow change management processes for any infrastructure modifications.**

## Version History

### v1.0.1 (2026-01-19)
- Changed owner email to infra@srp.one

### v1.0.0 (2026-01-16)
- Initial release
- Kubernetes Management skill
- Cloud Resources skill

## License

Internal use only by SRP (Serendipity One Inc.) employees.

---

**Plugin Name:** srp-devops
**Version:** 1.0.1
**Author:** SRP Team (infra@srp.one)
**Tags:** kubernetes, k8s, monitoring, devops, gcp, cloud
