apt命令使用总结：
=============sudo 执行
更新软件源中软件列表：apt update
升级软件： apt upgrade
显示可升级的软件包： apt list --upgradeable
显示已安装的软件包： apt list --installed
安装软件： apt install [软件包名]
卸载软件: apt remove [软件包名]
自动清理： apt autoremove
软件信息： apt show [软件包名]
依赖修复： apt install -f
