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
- [ ] （运维）安装 `srp-devops` 并配置 GCP/K8s
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
