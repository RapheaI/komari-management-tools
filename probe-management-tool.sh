#!/bin/bash

# 探针管理工具
# 使用API令牌: KWRFkL8F9Fmvug_n (数据上报)
# 管理密码: komari-fGIyLH6aQM5FlJzmy2UK7Y2afkgrGX62 (面板登录)

PROBE_API_TOKEN="KWRFkL8F9Fmvug_n"
PROBE_API_ENDPOINT="http://agent.statues.eu.cc:25774"

# API调用函数
probe_api_call() {
    local endpoint="$1"
    curl -s -H "Authorization: Bearer $PROBE_API_KEY" \
         "$PROBE_API_ENDPOINT$endpoint"
}

case "$1" in
    "servers")
        echo "=== 📊 服务器列表 ==="
        probe_api_call "/api/v1/servers" | jq '.' 2>/dev/null || \
        probe_api_call "/api/v1/servers"
        ;;
    "metrics")
        echo "=== 📈 监控指标 ==="
        probe_api_call "/api/v1/metrics" | jq '.' 2>/dev/null || \
        probe_api_call "/api/v1/metrics"
        ;;
    "alerts")
        echo "=== 🔔 告警信息 ==="
        probe_api_call "/api/v1/alerts" | jq '.' 2>/dev/null || \
        probe_api_call "/api/v1/alerts"
        ;;
    "status")
        echo "=== 🟢 系统状态 ==="
        probe_api_call "/api/v1/status" | jq '.' 2>/dev/null || \
        probe_api_call "/api/v1/status"
        ;;
    "config")
        echo "=== ⚙️ 配置信息 ==="
        echo "API密钥: $PROBE_API_KEY"
        echo "API端点: $PROBE_API_ENDPOINT"
        echo ""
        echo "使用示例:"
        echo "  $0 servers    # 查看服务器列表"
        echo "  $0 metrics    # 查看监控指标"
        echo "  $0 alerts     # 查看告警信息"
        echo "  $0 status     # 查看系统状态"
        ;;
    *)
        echo "探针管理工具"
        echo "用法: $0 {servers|metrics|alerts|status|config}"
        ;;
esac