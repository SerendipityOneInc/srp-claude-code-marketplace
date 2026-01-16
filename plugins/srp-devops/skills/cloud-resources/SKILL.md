---
name: cloud-resources
description: Cloud resource management and monitoring for GCP (云资源管理与监控 - GCP)
---

# Cloud Resources Management (云资源管理)

为运维人员提供 GCP 云资源的管理和监控功能，包括查看和管理 Compute Engine、Cloud Storage、网络资源等。

Provides GCP cloud resource management and monitoring for DevOps engineers, including Compute Engine, Cloud Storage, networking, and more.

## Quick Start

### List Compute Instances (列出计算实例)

```
显示所有 GCE 实例
List all Compute Engine instances
```

### Check Cloud Storage (检查云存储)

```
列出所有 GCS buckets
List all Cloud Storage buckets
```

### View Project Resources (查看项目资源)

```
显示项目 srpproduct-dc37e 的资源概况
Show resource overview for project srpproduct-dc37e
```

## Key Features

### 1. Compute Engine Management (计算引擎管理)

View and monitor GCE instances:

**Common Operations:**
```bash
# List instances
gcloud compute instances list

# Get instance details
gcloud compute instances describe <instance-name>

# Check instance status
gcloud compute instances get-serial-port-output <instance-name>
```

### 2. Cloud Storage (云存储)

Monitor and manage GCS buckets and objects:

**Common Operations:**
```bash
# List buckets
gcloud storage buckets list

# List objects in bucket
gcloud storage ls gs://<bucket-name>/

# Get object metadata
gcloud storage objects describe gs://<bucket-name>/<object-name>
```

### 3. Network Resources (网络资源)

View network configuration and health:

**Common Operations:**
```bash
# List networks
gcloud compute networks list

# List firewalls
gcloud compute firewall-rules list

# List load balancers
gcloud compute forwarding-rules list
```

### 4. Resource Monitoring (资源监控)

Monitor resource usage and costs:

**Common Operations:**
```bash
# Project info
gcloud projects describe <project-id>

# List services
gcloud services list --enabled

# Check quotas
gcloud compute project-info describe --project=<project-id>
```

## Common Workflows

### Workflow 1: Instance Health Check

```markdown
1. User: "检查所有 production 实例的健康状态"
2. List instances: gcloud compute instances list --filter="labels.env=production"
3. Check each instance status
4. Review recent logs if needed
5. Report health summary
```

### Workflow 2: Storage Audit

```markdown
1. User: "审计 GCS buckets 的访问权限"
2. List all buckets
3. Get IAM policy for each bucket
4. Check public access
5. Identify potential security issues
6. Generate audit report
```

### Workflow 3: Network Troubleshooting

```markdown
1. User: "为什么服务 A 无法连接到服务 B？"
2. Check firewall rules
3. Verify network connectivity
4. Review load balancer config
5. Check DNS settings
6. Diagnose issue and suggest fixes
```

## Examples (示例)

### Example 1: List Compute Instances (列出计算实例)

**User (Chinese):**
```
显示项目中所有正在运行的 GCE 实例
```

**Assistant Response:**
```markdown
我会列出所有正在运行的 GCE 实例。

<executes: gcloud compute instances list --filter="status=RUNNING">

**Running Compute Engine Instances:**

| Name | Zone | Machine Type | Internal IP | External IP | Status |
|------|------|--------------|-------------|-------------|--------|
| api-server-prod-1 | us-east1-b | n2-standard-4 | 10.0.1.10 | 34.xxx.xxx.1 | RUNNING |
| api-server-prod-2 | us-east1-c | n2-standard-4 | 10.0.1.11 | 34.xxx.xxx.2 | RUNNING |
| worker-prod-1 | us-east1-b | n2-standard-8 | 10.0.2.10 | - | RUNNING |
| db-primary | us-east1-b | n2-highmem-8 | 10.0.3.10 | - | RUNNING |

**Summary:**
- Total running instances: 4
- Machine types: n2-standard-4 (2), n2-standard-8 (1), n2-highmem-8 (1)
- 2 instances with external IPs
- All instances in us-east1 region
```

### Example 2: Storage Bucket Overview (存储桶概览)

**User (English):**
```
List all Cloud Storage buckets and their sizes
```

**Assistant Response:**
```markdown
I'll list all GCS buckets with size information.

<executes: gcloud storage buckets list>
<executes: gcloud storage du -s gs://<bucket>/* for each bucket>

**Cloud Storage Buckets:**

| Bucket Name | Location | Storage Class | Size | Objects |
|-------------|----------|---------------|------|---------|
| srp-prod-data | us-east1 | STANDARD | 2.3 TB | 450,230 |
| srp-prod-logs | us-east1 | NEARLINE | 890 GB | 1,250,000 |
| srp-prod-backups | us-east1 | COLDLINE | 5.1 TB | 125 |
| srp-dev-data | us-east1 | STANDARD | 120 GB | 15,430 |

**Summary:**
- Total storage: 8.4 TB
- Monthly estimated cost: ~$180 (based on storage class)
- Largest bucket: srp-prod-backups (5.1 TB)
- Most objects: srp-prod-logs (1.25M objects)

**Recommendations:**
- Consider lifecycle policies for old logs
- Review backup retention policy
- Monitor storage costs
```

### Example 3: Network Firewall Audit (网络防火墙审计)

**User (Chinese):**
```
检查是否有过于宽松的防火墙规则
```

**Assistant Response:**
```markdown
我会检查防火墙规则，识别潜在的安全风险。

<executes: gcloud compute firewall-rules list>

**Firewall Rules Audit:**

**✅ Secure Rules (10):**
- allow-internal-prod: 10.0.0.0/8 → All (Internal only)
- allow-ssh-bastion: Specific IPs → tcp:22
- allow-https-lb: Load balancer → tcp:443
- ... (7 more)

**⚠️ Potentially Risky Rules (2):**
1. **allow-all-dev** ⚠️
   - Source: 0.0.0.0/0 (All internet)
   - Ports: tcp:8080, tcp:3000
   - Target: dev-instances
   - **Risk**: Development ports exposed to internet
   - **Recommendation**: Restrict to office IPs or VPN

2. **allow-ssh-temp** ⚠️ HIGH PRIORITY
   - Source: 0.0.0.0/0 (All internet)
   - Port: tcp:22
   - Target: All instances
   - **Risk**: SSH open to entire internet
   - **Recommendation**: DELETE immediately and use bastion host

**Summary:**
- Total rules: 12
- Secure: 10
- Needs review: 2

**Action Items:**
1. 🔴 URGENT: Review and restrict allow-ssh-temp rule
2. 🟡 Review allow-all-dev and limit to VPN/office IPs
3. 🟢 Document all firewall rule purposes
```

## Important Notes

### Access Control (访问控制)
- Requires GCP authentication (gcloud)
- Operations limited by IAM permissions
- Read access to most resources
- Some management operations available with proper roles

### Safety Guidelines (安全指南)
- **Caution with management operations**: Always verify before executing
- Prefer read-only commands for investigation
- Use appropriate environments (dev/staging/prod)
- Follow change management processes
- Document all changes

### Best Practices (最佳实践)
- Use labels for resource organization
- Enable audit logging
- Regular security reviews
- Monitor costs and quotas
- Use least privilege access

## Prerequisites

### GCP CLI (gcloud)

Ensure gcloud is installed and configured:

```bash
# Check gcloud installation
gcloud version

# Authenticate
gcloud auth login

# Set default project
gcloud config set project srpproduct-dc37e

# Verify access
gcloud projects describe srpproduct-dc37e
```

### Environment Variables

```bash
export GCP_PROJECT_ID="srpproduct-dc37e"
export GCP_REGION="us-east1"
export GCP_ZONE="us-east1-b"
```

### Required IAM Roles

Minimum roles needed:
- `roles/compute.viewer` - View compute resources
- `roles/storage.objectViewer` - View storage objects
- `roles/viewer` - Basic project viewing

For management operations:
- `roles/compute.instanceAdmin` - Manage instances
- `roles/storage.admin` - Manage storage
- `roles/iam.securityReviewer` - Security audits

## Limitations

### Current Limitations
- Uses gcloud CLI (not direct API integration)
- No real-time dashboards
- Limited cost analytics
- No automated remediation
- Manual execution of commands

### Future Enhancements
- Direct GCP API integration via MCP
- Real-time resource monitoring
- Cost analytics and optimization
- Automated compliance checks
- Integration with Terraform/IaC
- Alert and notification system

## Troubleshooting

### Issue 1: "gcloud: command not found"

**Solutions:**
1. Install gcloud SDK: https://cloud.google.com/sdk/docs/install
2. Add to PATH
3. Restart terminal

### Issue 2: "Permission denied"

**Solutions:**
1. Check current account: `gcloud auth list`
2. Verify IAM permissions
3. Switch account if needed: `gcloud config set account <email>`
4. Contact GCP admin

### Issue 3: "Project not found"

**Solutions:**
1. List available projects: `gcloud projects list`
2. Set correct project: `gcloud config set project <project-id>`
3. Verify project ID spelling

## Security & Compliance

### Resource Access Audit
- All operations are logged in Cloud Audit Logs
- Review logs regularly
- Follow principle of least privilege
- Use service accounts for automation

### Sensitive Data
- Do not expose credentials
- Use Secret Manager for secrets
- Enable data encryption
- Regular access reviews

### Compliance
- Follow company security policies
- Document all infrastructure changes
- Regular compliance audits
- Incident response procedures

## Related Skills

- `k8s-management`: Kubernetes cluster management
- Future: `monitoring-alerts`, `cost-optimization`, `incident-response`

## Operations Reference

### Safe Read Operations (安全的只读操作)
✅ List resources
✅ Describe resources
✅ Get logs
✅ Check status
✅ View metrics

### Management Operations (需谨慎执行)
⚠️ Start/stop instances
⚠️ Modify configurations
⚠️ Create/delete resources
⚠️ Change IAM policies
⚠️ Network changes

**Always verify management operations before executing and follow change management processes.**
