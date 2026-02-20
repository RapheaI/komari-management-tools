#!/bin/bash

# Komari管理工具安装脚本

echo "=== 🔧 Komari管理工具安装 ==="
echo ""

# 检查依赖
echo "📋 检查系统依赖..."
command -v curl >/dev/null 2>&1 || { echo "❌ 需要安装curl"; exit 1; }
command -v jq >/dev/null 2>&1 && echo "✅ jq已安装" || echo "⚠️ jq未安装，部分功能受限"

# 创建安装目录
INSTALL_DIR="/usr/local/bin"
echo "📁 安装到: $INSTALL_DIR"

# 复制脚本
cp komari-api-tool.sh "$INSTALL_DIR/"
cp probe-management-tool.sh "$INSTALL_DIR/"
cp probe-api-config.sh "$INSTALL_DIR/"

# 设置执行权限
chmod +x "$INSTALL_DIR/komari-api-tool.sh"
chmod +x "$INSTALL_DIR/probe-management-tool.sh"
chmod +x "$INSTALL_DIR/probe-api-config.sh"

# 创建符号链接（可选）
ln -sf "$INSTALL_DIR/komari-api-tool.sh" "$INSTALL_DIR/komari" 2>/dev/null

echo ""
echo "✅ 安装完成！"
echo ""
echo "🚀 使用方法:"
echo "  komari-api-tool.sh nodes    # 查看所有节点"
echo "  komari-api-tool.sh test     # 测试API连接"
echo "  komari-api-tool.sh help     # 查看帮助"
