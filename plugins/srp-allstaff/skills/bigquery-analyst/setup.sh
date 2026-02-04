#!/bin/bash
# BigQuery Analyst Skill - 一键安装脚本
# 用途: 检查并安装所有必需的依赖
# 版本: 1.1.0

set -e

# 技能版本号
SKILL_VERSION="1.1.0"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 BigQuery Analyst Skill v${SKILL_VERSION} - 安装/更新"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_LOG="${SCRIPT_DIR}/install.log"

# 记录日志
log() {
    echo "$1" | tee -a "$INSTALL_LOG"
}

# 清空旧日志
> "$INSTALL_LOG"

ERRORS=0
WARNINGS=0

echo "📋 开始检查依赖..."
echo ""

# ============================================
# 检查 1: Skill 文件
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[1/4] 检查 Skill 文件"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -f "${SCRIPT_DIR}/skill.md" ]; then
    echo "✅ Skill 文件已就绪"
    echo "   路径: ${SCRIPT_DIR}/skill.md"
else
    echo "❌ 错误: 找不到 skill.md"
    ERRORS=$((ERRORS + 1))
fi

if [ -d "${SCRIPT_DIR}/metadata" ]; then
    TABLE_COUNT=$(find "${SCRIPT_DIR}/metadata" -name "README.md" -path "*/tables/*" | wc -l)
    echo "✅ 元数据知识库已就绪"
    echo "   表数量: ${TABLE_COUNT}"
else
    echo "❌ 错误: 找不到 metadata 目录"
    ERRORS=$((ERRORS + 1))
fi

echo ""

# ============================================
# 检查 2: BigQuery CLI
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[2/4] 检查 BigQuery CLI"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if command -v bq &> /dev/null; then
    BQ_VERSION=$(bq version 2>&1 | head -1)
    echo "✅ BigQuery CLI 已安装"
    echo "   版本: $BQ_VERSION"
    echo "   路径: $(which bq)"
else
    echo "❌ BigQuery CLI 未安装"
    echo ""
    echo "📦 安装方法:"
    echo ""

    # 检测操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   # macOS"
        echo "   brew install google-cloud-sdk"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "   # Linux"
        echo "   # 参考: https://cloud.google.com/sdk/docs/install"
    fi

    echo ""
    read -p "是否现在安装 BigQuery CLI? (y/N): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "🔄 正在安装 Google Cloud SDK..."
            if command -v brew &> /dev/null; then
                brew install google-cloud-sdk
                echo "✅ 安装完成"
            else
                echo "❌ Homebrew 未安装，无法自动安装"
                echo "   请访问: https://cloud.google.com/sdk/docs/install"
                ERRORS=$((ERRORS + 1))
            fi
        else
            echo "⚠️  请手动安装 Google Cloud SDK"
            echo "   访问: https://cloud.google.com/sdk/docs/install"
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo "⚠️  跳过安装，您需要手动安装 BigQuery CLI"
        ERRORS=$((ERRORS + 1))
    fi
fi

echo ""

# ============================================
# 检查 3: BigQuery 认证
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[3/4] 检查 BigQuery 认证"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if command -v gcloud &> /dev/null; then
    # 检查是否有活跃的账号
    ACTIVE_ACCOUNT=$(gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null | head -1)

    if [ -n "$ACTIVE_ACCOUNT" ]; then
        echo "✅ BigQuery 已认证"
        echo "   账号: $ACTIVE_ACCOUNT"

        # 测试 BigQuery 访问
        if bq ls srpproduct-dc37e: &> /dev/null; then
            echo "✅ BigQuery 访问测试通过"
        else
            echo "⚠️  无法访问项目 srpproduct-dc37e"
            echo "   可能原因: 权限不足或项目不存在"
            WARNINGS=$((WARNINGS + 1))
        fi
    else
        echo "❌ BigQuery 未认证"
        echo ""
        echo "🔐 认证方法:"
        echo ""
        echo "   # 步骤 1: 登录 GCP"
        echo "   gcloud auth login"
        echo ""
        echo "   # 步骤 2: 设置应用默认凭据"
        echo "   gcloud auth application-default login"
        echo ""
        echo "   # 步骤 3: 设置默认项目"
        echo "   gcloud config set project srpproduct-dc37e"
        echo ""

        read -p "是否现在进行认证? (y/N): " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "🔄 开始认证流程..."

            # 步骤 1: 登录
            echo "步骤 1/3: 登录 GCP..."
            gcloud auth login

            # 步骤 2: 应用默认凭据
            echo "步骤 2/3: 设置应用默认凭据..."
            gcloud auth application-default login

            # 步骤 3: 设置项目
            echo "步骤 3/3: 设置默认项目..."
            gcloud config set project srpproduct-dc37e

            echo "✅ 认证完成"
        else
            echo "⚠️  跳过认证，您需要手动完成认证"
            ERRORS=$((ERRORS + 1))
        fi
    fi
else
    echo "❌ gcloud 命令未找到"
    echo "   BigQuery CLI 可能未正确安装"
    ERRORS=$((ERRORS + 1))
fi

echo ""

# ============================================
# 检查 4: PreHook
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[4/4] 检查 PreHook"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

PREHOOK_SOURCE="${SCRIPT_DIR}/bigquery_prehook.sh"
PREHOOK_TARGET="${HOME}/.claude/hooks/bigquery_prehook.sh"

if [ ! -f "$PREHOOK_SOURCE" ]; then
    echo "❌ 错误: 找不到 PreHook 源文件"
    echo "   路径: $PREHOOK_SOURCE"
    ERRORS=$((ERRORS + 1))
elif [ -f "$PREHOOK_TARGET" ] && [ -x "$PREHOOK_TARGET" ]; then
    echo "✅ PreHook 已安装"
    echo "   路径: $PREHOOK_TARGET"

    # 检查是否需要更新（对比文件内容）
    if ! diff -q "$PREHOOK_SOURCE" "$PREHOOK_TARGET" &> /dev/null; then
        echo "⚠️  检测到 PreHook 有更新"
        echo ""
        read -p "是否更新 PreHook? (Y/n): " -n 1 -r
        echo

        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            echo "🔄 正在更新 PreHook..."

            # 备份旧版本
            BACKUP_FILE="${PREHOOK_TARGET}.backup.$(date +%Y%m%d_%H%M%S)"
            cp "$PREHOOK_TARGET" "$BACKUP_FILE"
            echo "   备份旧版本: $BACKUP_FILE"

            # 更新到新版本
            cp "$PREHOOK_SOURCE" "$PREHOOK_TARGET"
            chmod +x "$PREHOOK_TARGET"
            echo "✅ PreHook 更新成功"
        else
            echo "⚠️  跳过更新，继续使用旧版本"
            WARNINGS=$((WARNINGS + 1))
        fi
    else
        echo "✅ PreHook 已是最新版本"
    fi

    # 测试 PreHook
    if $PREHOOK_TARGET "SELECT 1" &> /dev/null; then
        echo "✅ PreHook 测试通过"
    else
        echo "⚠️  PreHook 测试失败"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo "⚠️  PreHook 未安装"
    echo ""
    read -p "是否现在安装 PreHook? (Y/n): " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        echo "🔄 正在安装 PreHook..."

        # 创建目录
        mkdir -p "${HOME}/.claude/hooks"

        # 复制文件
        cp "$PREHOOK_SOURCE" "$PREHOOK_TARGET"
        chmod +x "$PREHOOK_TARGET"

        if [ -x "$PREHOOK_TARGET" ]; then
            echo "✅ PreHook 安装成功"

            # 测试
            if $PREHOOK_TARGET "SELECT 1" &> /dev/null; then
                echo "✅ PreHook 测试通过"
            else
                echo "⚠️  PreHook 测试失败（可能需要 BigQuery 认证）"
                WARNINGS=$((WARNINGS + 1))
            fi
        else
            echo "❌ PreHook 安装失败"
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo "❌ 跳过安装 PreHook"
        echo ""
        echo "⚠️  警告: 没有 PreHook，Skill 将拒绝执行查询"
        echo "   PreHook 提供关键的安全防护:"
        echo "   - 拦截破坏性操作（DROP/DELETE/UPDATE/INSERT）"
        echo "   - 预估查询成本，超过阈值拒绝执行"
        echo "   - 验证核心规则（dt 过滤、user_group 过滤）"
        echo ""
        ERRORS=$((ERRORS + 1))
    fi
fi

echo ""

# ============================================
# 安装总结
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 安装总结"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $ERRORS -eq 0 ]; then
    echo "✅ 所有必需组件已就绪"
    echo ""
    echo "🎉 BigQuery Analyst Skill 已完全配置！"
    echo ""
    echo "📝 下一步:"
    echo "   1. 在 Claude Code 中输入: /bigquery-analyst"
    echo "   2. 开始提问，例如: 查询最近7天积分消耗量最高的功能"
    echo ""

    if [ $WARNINGS -gt 0 ]; then
        echo "⚠️  有 $WARNINGS 个警告，但不影响基本使用"
        echo "   详细信息请查看上方输出"
        echo ""
    fi

    echo "📄 相关文档:"
    echo "   - 快速开始: QUICK_START.md"
    echo "   - 工作原理: HOW_IT_WORKS.md"
    echo "   - 测试指南: ../../READY_FOR_TESTING.md"
    echo ""

    exit 0
else
    echo "❌ 有 $ERRORS 个错误需要解决"

    if [ $WARNINGS -gt 0 ]; then
        echo "⚠️  有 $WARNINGS 个警告"
    fi

    echo ""
    echo "🔧 需要手动完成的步骤:"
    echo ""

    # 根据错误类型给出具体建议
    if ! command -v bq &> /dev/null; then
        echo "   1. 安装 BigQuery CLI:"
        echo "      brew install google-cloud-sdk"
        echo ""
    fi

    if [ -z "$ACTIVE_ACCOUNT" ]; then
        echo "   2. 完成 BigQuery 认证:"
        echo "      gcloud auth login"
        echo "      gcloud auth application-default login"
        echo "      gcloud config set project srpproduct-dc37e"
        echo ""
    fi

    if [ ! -f "$PREHOOK_TARGET" ] || [ ! -x "$PREHOOK_TARGET" ]; then
        echo "   3. 安装 PreHook:"
        echo "      cd $(dirname $PREHOOK_SOURCE)"
        echo "      ./install_prehook.sh"
        echo ""
    fi

    echo "完成后，请重新运行此脚本进行验证:"
    echo "   ./setup.sh"
    echo ""
    echo "📄 安装日志已保存到: $INSTALL_LOG"
    echo ""

    exit 1
fi
