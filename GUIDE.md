# SRP Claude Code Marketplace 使用指南

> 内部工具集成平台 | 让 AI 助手更懂你的工作流

---

## 📌 概述

**SRP Claude Code Marketplace** 是 Serendipity One Inc. (SRP) 为内部员工打造的 Claude Code 插件市场。通过这个平台，你可以让 Claude AI 助手无缝对接公司内部的各种工具和服务。

### 🎯 核心价值

- **🔌 开箱即用**：预配置的插件，安装即可使用
- **🔐 安全可靠**：基于你的真实身份和权限，无需担心权限泄露
- **🚀 提升效率**：用自然语言操作飞书、GitHub、GCP、Kubernetes 等工具
- **🔧 持续更新**：由 SRP 团队维护，定期增加新功能

---

## 🧩 可用插件

### 1. 📱 **SRP AllStaff**（全员基础插件）

**面向人群**：所有 SRP 员工

**功能**：飞书（Lark/Feishu）深度集成

**核心能力**：
- ✅ **文档搜索**：快速查找云文档、电子表格、多维表格、知识库
- ✅ **群聊管理**：查看群列表、群成员、历史消息
- ✅ **消息收发**：读取和发送飞书消息（文本、富文本、卡片等）

**使用命令**：
```bash
/srp:msg          # 飞书消息管理
/srp:docs         # 飞书文档搜索
```

**典型场景**：
```
"搜索包含 OKR 的文档"
"显示产品团队群的最新消息"
"给张三发送一条飞书消息：会议推迟到下午3点"
```

---

### 2. 💻 **SRP Developer**（开发者插件）

**面向人群**：研发工程师

**前置要求**：需先安装 `srp-allstaff`

**功能扩展**：GitHub + GCP 读取权限

**核心能力**：
- ✅ **GitHub 代码审查**：列出 PR、提交代码审查意见、管理 Issue
- ✅ **GitHub 自动化**：查看 CI/CD 状态、搜索代码、管理分支
- ✅ **BigQuery 查询**：执行 SELECT 查询、查看表结构（只读权限）

**使用命令**：
```bash
/srp:github       # GitHub 集成
/srp:gh          # GitHub 快捷方式
/srp:gcp         # GCP 开发者访问
/srp:bq          # BigQuery 快捷方式
```

**典型场景**：
```
"列出 srp-claude-code-marketplace 仓库中待审查的 PR"
"帮我审查 PR #123，检查代码质量"
"查询 analytics.user_events 表的前 10 条记录"
"显示 srpproduct-dc37e 项目中的所有 BigQuery 表"
```

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
4. 在 GitHub Issues 提交问题或联系 IT 部门寻求帮助

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

### Q6：我可以贡献新的插件吗？

**A6**：当然可以！这是一个内部开源项目：
1. Fork 仓库：https://github.com/SerendipityOneInc/srp-claude-code-marketplace
2. 参考 `plugins/example-hello-world` 创建新插件
3. 提交 PR，CI 会自动验证格式
4. 团队审核后合并

---

## 📞 获取帮助

### 支持渠道

- **GitHub Issues**：https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues
- **Linear 任务**：INF-341
- **飞书群组**：联系 IT 部门获取技术支持群
- **Email**：team@srp.one

### 反馈与建议

我们欢迎你的反馈！如果你有以下需求，请随时联系我们：

- 🐛 报告 Bug
- 💡 功能建议
- 📚 文档改进
- 🔌 新插件需求

---

## 🚀 快速上手检查清单

- [ ] 添加 marketplace 源
- [ ] 安装 `srp-allstaff` 插件
- [ ] 配置飞书环境变量（LARK_APP_ID, LARK_APP_SECRET）
- [ ] 重启 Claude Code
- [ ] 尝试执行 `/srp:msg` 命令
- [ ] （可选）安装 `srp-developer` 并配置 GitHub Token
- [ ] （可选）安装 `srp-devops` 并配置 GCP/K8s
- [ ] 查看文档和 GitHub Issues 获取最新消息

---

## 📊 版本信息

- **Marketplace 版本**：2.0.0
- **最后更新**：2026-01-19
- **插件总数**：5 个（含示例插件）
- **License**：MIT

---

**Happy Coding with Claude! 🎉**

让 AI 成为你的得力助手，专注于更有价值的工作！
