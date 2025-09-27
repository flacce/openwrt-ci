# 🚀 My Custom OpenWrt Builder 🚀

一个基于 GitHub Actions 的 OpenWrt 固件自动编译项目。

## ✨ 固件特性

- 🌐 **默认网关**: `10.0.0.1`
- 👤 **默认用户**: `root`
- 🔑 **默认密码**: 无
- 📦 **精选插件**: 预置了丰富的插件，满足您的日常需求。

---

### 🧩 内置插件类别

| 类别 | 示例 |
| :--- | :--- |
| 科学上网 & 流量工具 ✈️ | Passwall, OpenClash, HomeProxy... |
| 广告过滤 & DNS 🛡️ | AdGuard Home, MosDNS... |
| 系统 & 磁盘工具 🛠️ | DDNS-Go, DiskMan, Tailscale... |
| 精美主题 🎨 | Argon, Edge, Kucat... |
| *...以及更多实用工具!* | |

---

## 📊 构建状态与下载

| 平台 | 构建状态 | 最新固件 |
| :--- | :---: | :---: |
| `IPQ60XX-ALL` | [![IPQ60XX-ALL](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-ALL.yml/badge.svg)](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-ALL.yml) | [下载链接](https://github.com/flacce/openwrt-ci/releases/latest) |
| `IPQ60XX-6.12-WIFI` | [![IPQ60XX-6.12-WIFI](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-6.12-WIFI.yml/badge.svg)](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-6.12-WIFI.yml) | [下载链接](https://github.com/flacce/openwrt-ci/releases/latest) |
| *...更多平台请查看 Actions 页面* | |

---

## 🛠️ 如何使用

### 📥 方法一：下载预编译固件

1.  访问本项目的 [**Releases**](https://github.com/flacce/openwrt-ci/releases) 页面。
2.  找到最新的 Release 版本。
3.  下载对应您设备型号的固件压缩包。

### ⚙️ 方法二：触发一次新构建

1.  Fork 本项目到您自己的仓库。
2.  进入您仓库的 [**Actions**](https://github.com/flacce/openwrt-ci/actions) 页面。
3.  在左侧选择您想运行的工作流 (e.g., `IPQ60XX-6.12-WIFI`)。
4.  点击 `Run workflow` 按钮，即可开始一次全新的编译。

---

## 🎨 如何自定义

本项目的设计哲学是“一个脚本管理所有插件”。

1.  **找到核心脚本**: 📌 `diy-script.sh`
2.  **修改插件列表**:
    - **添加插件**: 在脚本中，使用 `UPDATE_PACKAGE "插件名" "作者/仓库" "分支"` 函数来添加新的插件。
    - **删除插件**: 直接在脚本中删除或注释掉对应的 `UPDATE_PACKAGE` 行。
3.  **调整基础配置**:
    - 每个工作流 `.yml` 文件都关联了一个 `configs/` 目录下的 `.config` 文件。
    - 您可以修改对应的 `.config` 文件来调整 OpenWrt 的基础功能和内置包。
4.  **提交并运行**:
    - 修改完成后，将代码提交到您的仓库。
    - GitHub Actions 会自动（或手动触发）开始编译，生成您专属的固件！

---

## 📜 免责声明

- 本人不对任何人因使用本固件所遭受的任何理论或实际的损失承担责任！
- 本固件禁止用于任何商业用途，请务必严格遵守国家互联网使用相关法律规定！

<a href="#readme">
<img src="https://img.shields.io/badge/-返回顶部-FFFFFF.svg" title="返回顶部" align="right"/>
</a>