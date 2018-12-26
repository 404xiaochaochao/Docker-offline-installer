#!/bin/bash

sudo systemctl stop firewalld.service
sudo setenforce 0


workdir=$(cd $(dirname $0); pwd)


if [[ "$(docker ps | awk 'END{print NR}')" -ge 1 ]]; then

   echo "Docker has been installed on this host. .. "

else
   echo "Installing docker..."

    tar xzvf ./docker.tgz \
     && sudo cp -r docker/* /usr/bin/ \
     && sudo rm -rf docker 
	sudo chmod 777 /usr/bin/docker* 
	
    path=$workdir"/daemon.json"
    t=${path//\//\\\/}
    sed -i 's/\(ExecStart=\/usr\/bin\/dockerd\).*/\1 --config-file '$t'/' docker.service
    cp docker.s* /etc/systemd/system
    sudo systemctl daemon-reload
    sudo systemctl start docker

    sleep 3s
    sudo  systemctl enable docker
    egrep docker /etc/group >& /dev/null
    if [ $? -ne 0 ]; then
      sudo groupadd docker
    fi
    sudo usermod -aG docker ${USER}
	
	echo "Finishing installing docker ..."

fi


