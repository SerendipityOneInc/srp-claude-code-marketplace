---
name: k8s-management
description: Kubernetes cluster management and monitoring (Kubernetes集群管理与监控)
---

# Kubernetes Management (Kubernetes 管理)

为运维人员提供 Kubernetes 集群管理和监控功能，包括查看 Pod 状态、日志、资源使用等。

Provides Kubernetes cluster management and monitoring for DevOps engineers, including pod status, logs, resource usage, and more.

## Quick Start

### View Pods (查看 Pod)

```
显示 production namespace 中的所有 pods
List all pods in the production namespace
```

### Check Pod Logs (查看 Pod 日志)

```
查看 pod api-server-abc123 的日志
Get logs from pod api-server-abc123
```

### Check Resource Usage (查看资源使用)

```
显示集群资源使用情况
Show cluster resource usage
```

## Key Features

### 1. Pod Management (Pod 管理)

View and monitor pods across namespaces:

**Common Operations:**
```bash
# List pods
kubectl get pods -n <namespace>

# Get pod details
kubectl describe pod <pod-name> -n <namespace>

# View pod logs
kubectl logs <pod-name> -n <namespace>

# Follow logs
kubectl logs -f <pod-name> -n <namespace>
```

### 2. Service and Deployment (服务与部署)

Monitor services and deployments:

**Common Operations:**
```bash
# List services
kubectl get services -n <namespace>

# List deployments
kubectl get deployments -n <namespace>

# Check deployment status
kubectl rollout status deployment/<name> -n <namespace>
```

### 3. Resource Monitoring (资源监控)

Check cluster and pod resource usage:

**Common Operations:**
```bash
# Node resource usage
kubectl top nodes

# Pod resource usage
kubectl top pods -n <namespace>

# Check cluster info
kubectl cluster-info
```

## Common Workflows

### Workflow 1: Troubleshoot Pod Issues

```markdown
1. User: "production namespace 中有哪些 pod 出问题了？"
2. List pods: kubectl get pods -n production
3. Identify pods with issues (Not Running, CrashLoopBackOff)
4. Get pod details: kubectl describe pod <problem-pod>
5. Check logs: kubectl logs <problem-pod>
6. Analyze error messages
7. Suggest solutions
```

### Workflow 2: Check Deployment Health

```markdown
1. User: "检查 api-server deployment 的健康状态"
2. Get deployment: kubectl get deployment api-server -n production
3. Check replicas: desired vs available
4. Check rollout status
5. View recent events
6. Report status and any issues
```

### Workflow 3: Monitor Resource Usage

```markdown
1. User: "集群资源使用情况如何？"
2. Get node metrics: kubectl top nodes
3. Get pod metrics: kubectl top pods --all-namespaces
4. Calculate utilization percentages
5. Identify resource-intensive pods
6. Provide recommendations
```

## Examples (示例)

### Example 1: List Pods (列出 Pods)

**User (Chinese):**
```
显示 production namespace 中的所有 pods
```

**Assistant Response:**
```markdown
我会列出 production namespace 中的所有 pods。

<executes: kubectl get pods -n production>

**Production Namespace - Pods:**

| Name | Status | Restarts | Age |
|------|--------|----------|-----|
| api-server-7d4f8b9c-abc123 | Running | 0 | 5d |
| api-server-7d4f8b9c-def456 | Running | 1 | 5d |
| web-app-5c8a7b-ghi789 | Running | 0 | 3d |
| worker-queue-9f3e2d-jkl012 | CrashLoopBackOff | 10 | 2h |
| database-6a4b5c-mno345 | Running | 0 | 15d |

**Summary:**
- Total: 5 pods
- Running: 4 pods
- Issues: 1 pod (worker-queue)

⚠️ **Alert**: worker-queue-9f3e2d-jkl012 is in CrashLoopBackOff状态。需要检查日志吗？
```

### Example 2: View Pod Logs (查看 Pod 日志)

**User (English):**
```
Get logs from pod worker-queue-9f3e2d-jkl012 in production namespace
```

**Assistant Response:**
```markdown
I'll retrieve the logs from the pod.

<executes: kubectl logs worker-queue-9f3e2d-jkl012 -n production --tail=50>

**Pod Logs: worker-queue-9f3e2d-jkl012**

```
[2026-01-16 10:15:23] INFO: Worker starting...
[2026-01-16 10:15:24] INFO: Connecting to Redis...
[2026-01-16 10:15:25] ERROR: Connection failed: redis://redis-service:6379
[2026-01-16 10:15:25] ERROR: Error: getaddrinfo ENOTFOUND redis-service
[2026-01-16 10:15:26] INFO: Retrying connection (1/10)...
[2026-01-16 10:15:27] ERROR: Connection failed: redis://redis-service:6379
[2026-01-16 10:15:28] FATAL: Max retries exceeded, exiting
```

**Analysis:**
- **Issue**: Cannot connect to Redis service
- **Root Cause**: DNS resolution failure for `redis-service`
- **Possible Reasons**:
  1. Redis service not running in the namespace
  2. Service name mismatch
  3. Network policy blocking connection

**Recommendations:**
1. Check if Redis service exists: `kubectl get svc redis-service -n production`
2. Verify service endpoints: `kubectl get endpoints redis-service -n production`
3. Check network policies
4. Review deployment configuration
```

### Example 3: Resource Usage (资源使用)

**User (Chinese):**
```
显示集群各节点的资源使用情况
```

**Assistant Response:**
```markdown
我会显示集群节点的资源使用情况。

<executes: kubectl top nodes>

**Cluster Resource Usage:**

| Node | CPU (cores) | CPU % | Memory (GB) | Memory % |
|------|-------------|-------|-------------|----------|
| node-1 | 3.2 / 8 | 40% | 12.5 / 32 | 39% |
| node-2 | 5.6 / 8 | 70% | 18.2 / 32 | 57% |
| node-3 | 2.1 / 8 | 26% | 8.7 / 32 | 27% |
| node-4 | 6.8 / 8 | 85% | 24.3 / 32 | 76% |

**Analysis:**
- **node-4** is running at high utilization (85% CPU, 76% Memory)
- **node-3** has the most available capacity
- Average cluster utilization: 55% CPU, 50% Memory

**Recommendations:**
1. Consider redistributing pods from node-4
2. Monitor node-4 for potential issues
3. Check if any pods need resource limit adjustments
4. Review horizontal pod autoscaling settings
```

## Important Notes

### Access Control (访问控制)
- Requires kubectl configured with cluster access
- User permissions defined by RBAC roles
- Some operations may be restricted based on role
- Always verify namespace access before operations

### Safety Guidelines (安全指南)
- **Read operations only** through this skill
- No pod deletion or modification
- No deployment changes
- No configuration updates
- For changes, use standard deployment processes

### Best Practices (最佳实践)
- Always specify namespace
- Use labels for filtering
- Check resource limits before scaling
- Monitor metrics before making decisions
- Document all investigations

## Prerequisites

### kubectl Configuration

Ensure kubectl is configured to access your clusters:

```bash
# Verify kubectl is installed
kubectl version --client

# List available contexts
kubectl config get-contexts

# Switch context if needed
kubectl config use-context <context-name>

# Verify access
kubectl get nodes
```

### GKE Authentication (GCP)

For GKE clusters:
```bash
# Authenticate with GCP
gcloud auth login

# Get cluster credentials
gcloud container clusters get-credentials <cluster-name> --region=<region>

# Verify access
kubectl cluster-info
```

### Required Permissions

Minimum RBAC permissions needed:
- `pods/list` - List pods
- `pods/get` - Get pod details
- `pods/log` - Read pod logs
- `services/list` - List services
- `deployments/list` - List deployments
- `nodes/list` - List nodes

## Limitations

### Current Limitations
- Read-only operations via kubectl commands
- No direct MCP server integration (uses kubectl CLI)
- No real-time monitoring dashboards
- No automated remediation
- Limited to configured clusters

### Future Enhancements
- Direct Kubernetes API integration
- Real-time pod monitoring
- Automated issue detection
- Integration with monitoring systems (Prometheus, Grafana)
- Pod restart and scaling capabilities
- Log aggregation and search

## Troubleshooting

### Issue 1: "kubectl: command not found"

**Solutions:**
1. Install kubectl: https://kubernetes.io/docs/tasks/tools/
2. Add to PATH
3. Restart Claude Code

### Issue 2: "Unable to connect to cluster"

**Solutions:**
1. Verify kubectl context: `kubectl config current-context`
2. Check cluster credentials
3. Verify network access
4. Re-authenticate if needed

### Issue 3: "Forbidden: User cannot list pods"

**Solutions:**
1. Check RBAC permissions
2. Contact cluster admin
3. Verify service account
4. Switch to correct namespace

## Related Skills

- `cloud-resources`: Manage cloud infrastructure
- Future: `monitoring-alerts`, `incident-response`

## Safety & Compliance

This skill provides **read-only** access to Kubernetes clusters:
- ✅ View pod status and logs
- ✅ Monitor resource usage
- ✅ Check service health
- ❌ Cannot delete pods
- ❌ Cannot modify deployments
- ❌ Cannot change configurations

For any modifications, use established CI/CD pipelines and change management processes.
