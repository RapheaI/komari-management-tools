# 🚀 Komari探针管理工具集

一套用于管理和自动化Komari探针服务器的工具集合。

## 📋 功能特性

- 🔧 **完整的API集成** - 支持所有Komari官方API
- 📊 **实时监控** - 秒级服务器状态监控
- 🔔 **智能告警** - 自动化故障响应
- ⚡ **批量管理** - 多服务器统一运维
- 🛡️ **安全保障** - 企业级安全配置

## 🛠️ 工具列表

### 核心工具
- `komari-api-tool.sh` - 完整的API管理工具
- `probe-management-tool.sh` - 探针管理框架
- `probe-api-config.sh` - API配置脚本

### 文档
- `server-management-plan.md` - 服务器管理计划

## 🚀 快速开始

### 1. 下载工具
```bash
# 克隆仓库
git clone https://github.com/your-username/komari-management-tools.git
cd komari-management-tools

# 或者直接下载脚本
curl -O https://raw.githubusercontent.com/your-username/komari-management-tools/main/komari-api-tool.sh
chmod +x komari-api-tool.sh
```

### 2. 配置API
```bash
# 编辑脚本中的API配置
vim komari-api-tool.sh
# 修改 PROBE_API_ENDPOINT 和 PROBE_API_TOKEN
```

### 3. 开始使用
```bash
# 测试API连接
./komari-api-tool.sh test

# 查看所有节点
./komari-api-tool.sh nodes

# 获取公开信息
./komari-api-tool.sh public
```

## 📊 API功能

- `./komari-api-tool.sh nodes` - 获取所有节点信息
- `./komari-api-tool.sh public` - 获取公开配置
- `./komari-api-tool.sh recent <uuid>` - 获取节点最近状态
- `./komari-api-tool.sh records <uuid> <hours>` - 获取历史记录
- `./komari-api-tool.sh test` - API连接测试

## 🔧 集成示例

### 与OpenClaw集成
```bash
# 在OpenClaw中调用探针工具
./komari-api-tool.sh nodes | jq '.data[] | select(.region == "🇹🇷")'
```

### 自动化监控
```bash
# 定时检查服务器状态
*/5 * * * * /path/to/komari-api-tool.sh test
```

## 📝 许可证

MIT License

## 🤝 贡献

欢迎提交Issue和Pull Request！
