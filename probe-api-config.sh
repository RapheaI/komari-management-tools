#!/bin/bash

# 探针API配置脚本
# API密钥: komari-fGIyLH6aQM5FlJzmy2UK7Y2afkgrGX62

export PROBE_API_KEY="komari-fGIyLH6aQM5FlJzmy2UK7Y2afkgrGX62"
export PROBE_API_ENDPOINT="http://agent.statues.eu.cc:25774"
export PROBE_PANEL_URL="https://statues.eu.cc"

echo "=== 🔧 探针API配置完成 ==="
echo "API端点: $PROBE_API_ENDPOINT"
echo "面板地址: $PROBE_PANEL_URL"
echo ""

# 测试API连接
echo "🔍 测试API连接..."
response=$(curl -s -H "Authorization: Bearer $PROBE_API_KEY" \
                "$PROBE_API_ENDPOINT/api/v1/servers" 2>/dev/null)

if [ -n "$response" ]; then
    echo "✅ API连接成功"
    echo "响应长度: ${#response} 字符"
else
    echo "⚠️ API连接需要进一步配置"
fi