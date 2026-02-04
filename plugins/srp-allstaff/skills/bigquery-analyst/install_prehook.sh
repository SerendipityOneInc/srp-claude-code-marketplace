#!/bin/bash
# BigQuery Analyst Skill - PreHook 安装脚本
# 用途: 将 PreHook 安装到 Claude Code 全局 hooks 目录

set -e

echo "🔧 BigQuery Analyst Skill - PreHook 安装"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 获取脚本所在目录（skill 目录）
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PREHOOK_SOURCE="${SCRIPT_DIR}/bigquery_prehook.sh"

# Claude Code 全局 hooks 目录
HOOKS_DIR="${HOME}/.claude/hooks"
PREHOOK_TARGET="${HOOKS_DIR}/bigquery_prehook.sh"

# 检查源文件是否存在
if [ ! -f "$PREHOOK_SOURCE" ]; then
    echo "❌ 错误: 找不到 PreHook 源文件"
    echo "   路径: $PREHOOK_SOURCE"
    exit 1
fi

echo "📋 检查安装环境..."
echo "   源文件: $PREHOOK_SOURCE"
echo "   目标位置: $PREHOOK_TARGET"
echo ""

# 创建 hooks 目录（如果不存在）
if [ ! -d "$HOOKS_DIR" ]; then
    echo "📁 创建 hooks 目录: $HOOKS_DIR"
    mkdir -p "$HOOKS_DIR"
fi

# 检查是否已经安装
if [ -f "$PREHOOK_TARGET" ]; then
    echo "⚠️  PreHook 已存在"
    echo ""
    read -p "是否覆盖现有 PreHook? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 取消安装"
        exit 0
    fi
    echo "🔄 备份现有 PreHook..."
    cp "$PREHOOK_TARGET" "${PREHOOK_TARGET}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "   ✅ 备份完成"
fi

# 复制 PreHook 到全局目录
echo ""
echo "📦 安装 PreHook..."
cp "$PREHOOK_SOURCE" "$PREHOOK_TARGET"
chmod +x "$PREHOOK_TARGET"

# 验证安装
if [ -x "$PREHOOK_TARGET" ]; then
    echo "   ✅ PreHook 安装成功"
else
    echo "   ❌ PreHook 安装失败"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 安装完成"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 PreHook 功能:"
echo "   ✅ 破坏性操作拦截 (DROP/DELETE/TRUNCATE/UPDATE/INSERT)"
echo "   ✅ 成本预估检查 (需要 gcloud auth login)"
echo "   ✅ 数据层级建议 (ODS/DWD/DWS/RPT)"
echo "   ✅ 核心规则检查 (dt 过滤、user_group 过滤)"
echo ""
echo "🔍 测试 PreHook:"
echo "   $PREHOOK_TARGET \"SELECT * FROM test WHERE dt > '2026-01-01'\""
echo ""
echo "⚙️  可选: 启用完整成本检查"
echo "   gcloud auth login"
echo "   gcloud auth application-default login"
echo ""
echo "📄 详细文档: 查看 skill.md 和 PREHOOK_LOCATION.md"
echo ""
