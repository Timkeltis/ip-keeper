# 知产管家 · IP Keeper

本地部署的知识产权管理系统，支持专利、商标、软著的全流程管理。

## 功能

- **专利管理** — 申请/授权/年费全流程，自动计算年费（支持中国、美国、日本、韩国、欧盟等）
- **商标管理** — 注册/续展管理，图形商标 logo 上传，使用证据管理
- **软著管理** — 登记信息管理
- **文书识别** — PDF 上传后自动识别文书类型（授权通知书、驳回决定书等 22 类）
- **到期预警** — 专利年费、商标续展、专利有效期到期提醒
- **批量导入** — Excel 批量导入，智能字段映射，提供标准模板
- **批量导出** — Excel 导出、网上缴费模板导出、附件打包下载
- **附件管理** — 批量上传，ZIP 解压，从文件名自动匹配关联

## 快速开始

### macOS

```bash
# 安装依赖
pip3 install -r requirements.txt

# 启动服务
python3 server.py
```

或直接双击 `launch_ipkeeper.sh` / `启动知产管家.command`。

### Windows

```cmd
# 安装依赖
pip install -r requirements.txt

# 启动服务
python server.py
```

或直接双击 `start.bat`（自动安装依赖并打开浏览器）。

### 访问

浏览器打开 http://localhost:5678

## 技术栈

- 后端：Python + Flask + SQLite
- 前端：React（单文件内联）
- 无外部数据库依赖，开箱即用

## License

MIT
