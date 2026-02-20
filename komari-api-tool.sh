#!/bin/bash

# Komari探针API管理工具
# 基于官方API文档: https://komari-document.pages.dev/dev/api.html

PROBE_API_ENDPOINT="http://agent.statues.eu.cc:25774"
PROBE_API_TOKEN="KWRFkL8F9Fmvug_n"  # 数据上报令牌
ADMIN_PASSWORD="komari-fGIyLH6aQM5FlJzmy2UK7Y2afkgrGX62"  # 管理面板密码

# API调用函数
api_call() {
    local endpoint="$1"
    local method="${2:-GET}"
    local data="$3"
    
    if [ "$method" = "POST" ] && [ -n "$data" ]; then
        curl -s -X "$method" -H "Content-Type: application/json" \
             "$PROBE_API_ENDPOINT$endpoint" -d "$data"
    else
        curl -s -X "$method" "$PROBE_API_ENDPOINT$endpoint"
    fi
}

# 认证API调用 (需要Bearer认证)
auth_api_call() {
    local endpoint="$1"
    local method="${2:-GET}"
    local data="$3"
    
    if [ "$method" = "POST" ] && [ -n "$data" ]; then
        curl -s -X "$method" -H "Content-Type: application/json" \
             -H "Authorization: Bearer $PROBE_API_TOKEN" \
             "$PROBE_API_ENDPOINT$endpoint" -d "$data"
    else
        curl -s -X "$method" -H "Authorization: Bearer $PROBE_API_TOKEN" \
             "$PROBE_API_ENDPOINT$endpoint"
    fi
}

case "$1" in
    "public")
        echo "=== 🌐 公开信息 ==="
        api_call "/api/public"
        ;;
    "nodes")
        echo "=== 📊 所有节点信息 ==="
        api_call "/api/nodes" | jq '.' 2>/dev/null || api_call "/api/nodes"
        ;;
    "version")
        echo "=== 🔧 版本信息 ==="
        api_call "/api/version" | jq '.' 2>/dev/null || api_call "/api/version"
        ;;
    "recent")
        echo "=== 📈 节点最近状态 ==="
        if [ -n "$2" ]; then
            api_call "/api/recent/$2" | jq '.' 2>/dev/null || api_call "/api/recent/$2"
        else
            echo "请提供节点UUID，例如: $0 recent <uuid>"
            echo "使用 '$0 nodes' 获取节点列表"
        fi
        ;;
    "records")
        echo "=== 📋 负载历史记录 ==="
        if [ -n "$2" ] && [ -n "$3" ]; then
            api_call "/api/records/load?uuid=$2&hours=$3" | jq '.' 2>/dev/null || \
            api_call "/api/records/load?uuid=$2&hours=$3"
        else
            echo "用法: $0 records <uuid> <hours>"
            echo "示例: $0 records abc123 24"
        fi
        ;;
    "login")
        echo "=== 🔐 用户登录 ==="
        login_data='{"username":"admin","password":"'$ADMIN_PASSWORD'"}'
        api_call "/api/login" "POST" "$login_data" | jq '.' 2>/dev/null || \
        api_call "/api/login" "POST" "$login_data"
        ;;
    "me")
        echo "=== 👤 用户信息 ==="
        api_call "/api/me" | jq '.' 2>/dev/null || api_call "/api/me"
        ;;
    "test")
        echo "=== 🧪 API连接测试 ==="
        echo "1. 测试公开接口..."
        public_result=$(api_call "/api/public" | head -1)
        if echo "$public_result" | grep -q "^{\|status"; then
            echo "✅ 公开接口正常"
        else
            echo "❌ 公开接口异常"
        fi
        
        echo "2. 测试节点接口..."
        nodes_result=$(api_call "/api/nodes" | head -1)
        if echo "$nodes_result" | grep -q "^{\|status"; then
            echo "✅ 节点接口正常"
        else
            echo "❌ 节点接口异常"
        fi
        ;;
    "help"|"")
        echo "=== 🚀 Komari API管理工具 ==="
        echo ""
        echo "可用命令:"
        echo "  $0 public      # 获取公开信息"
        echo "  $0 nodes       # 获取所有节点信息"
        echo "  $0 version     # 获取版本信息"
        echo "  $0 recent <uuid> # 获取节点最近状态"
        echo "  $0 records <uuid> <hours> # 获取负载历史记录"
        echo "  $0 login       # 用户登录"
        echo "  $0 me          # 获取用户信息"
        echo "  $0 test        # API连接测试"
        echo ""
        echo "示例:"
        echo "  $0 nodes | jq '.data[0]'  # 查看第一个节点信息"
        echo "  $0 public | jq '.data.sitename'  # 查看站点名称"
        ;;
    *)
        echo "未知命令: $1"
        echo "使用 '$0 help' 查看帮助"
        ;;
esac