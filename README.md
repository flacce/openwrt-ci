# OpenWrt CI

<p align="center">
  <img width="500" src="https://github.com/openwrt/openwrt/blob/main/include/logo.png"/>
</p>

<p align="center">
这是一个基于 GitHub Actions 的 OpenWrt 固件自动编译项目。
</p>

---

## ✨ 固件特性

- **默认管理地址**: `10.0.0.1`
- **默认用户名**: `root`
- **默认密码**: 无
- **固件源码**: 基于 [LiBwrt/openwrt-6.x](https://github.com/LiBwrt/openwrt-6.x) (k6.17-dev 分支)

---

## 🚀 固件下载

下表中的链接指向最新的构建状态和固件下载页面。请点击对应的徽章查看。

| 目标平台 | 编译状态 | 固件下载 |
| :---: | :---: | :---: |
| **IPQ60XX (WIFI)** | [![IPQ60XX-6.12-WIFI](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-6.12-WIFI.yml/badge.svg)](https://github.com/flacce/openwrt-ci/actions/workflows/IPQ60XX-6.12-WIFI.yml) | [Releases](https://github.com/flacce/openwrt-ci/releases) |

*（您可以根据需要，按照以上格式添加更多平台的固件信息。）*

---

## 🛠️ 自定义构建

您可以轻松地 Fork 本项目，并根据自己的需求定制固件。

1.  **Fork 项目**  
    点击本项目页面右上角的 `Fork` 按钮，将项目复制到您自己的 GitHub 仓库。

2.  **修改固件配置**  
    在 `configs` 目录下，找到您目标平台对应的 `.config` 文件（例如 `ipq60xx-6.12-wifi.config`），根据您的需求修改其中的插件和功能选项。
    - 如需添加或删除 LuCI 插件，请搜索 `CONFIG_PACKAGE_luci-app-` 开头的行。
    - 如需上传自己的配置文件，请直接替换 `configs` 目录下的同名文件。

3.  **修改自定义脚本 (可选)**  
    如果您需要进行更高级的自定义，例如修改默认 IP 地址、添加额外的软件包源或执行特殊命令，请编辑 `diy-script.sh` 文件。

4.  **运行编译**  
    进入您 Fork 后的仓库，点击 `Actions` 选项卡，选择您想要构建的工作流（例如 `IPQ60XX-6.12-WIFI`），然后点击 `Run workflow` 按钮手动触发编译。

5.  **下载固件**  
    等待编译完成（通常需要1-2小时），完成后在仓库主页的 `Releases` 页面即可找到您新鲜出炉的固件。

---

## ⚠️ 免责声明

- 本人不对任何人因使用本固件所遭受的任何理论或实际的损失承担责任。
- 本固件禁止用于任何商业用途，请务- 务必严格遵守国家互联网使用相关法律规定。

---

## 🙏 致谢

- [OpenWrt](https://github.com/openwrt/openwrt)
- [LiBwrt](https://github.com/LiBwrt-op/openwrt-6.x)
- [immortalwrt](https://github.com/immortalwrt/immortalwrt)
- 以及所有为 OpenWrt 社区做出贡献的人们。