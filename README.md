# Docker-offline-installer
A shell script to install docker on Centos-7 host offline and make it a system service 

1. 从官网“https://download.docker.com/mac/static/stable/x86_64/” 中获取到你想到安装的docker版本的离线安装包。


2. 将安装包和其余文件一起放置在Centos 7的某一个目录下。


3. 手动更改“deamon.json”文件中的“graph”，这里需填入一个绝对路径，该路径会作为各类docker资源的默认路径，且必须存在且用户有写入权限。daemon.json中还可以自行根据官网说明加入所需的配置。


4. sudo chmod +x docker_install.sh;  ./docker_install.sh

（docker_install.sh 会自动将docker配置成系统服务，并添加docker用户组，将当前用户加入到docker用户组。 执行docker相关命令时无需带上“sudo”）


5. 如需重启docker服务可执行 “sudo sytemctl restart docker”， 若脚本执行完后docker无法正确执行，可以尝试退出当前用户的终端，再重新login。
