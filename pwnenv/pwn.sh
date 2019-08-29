#!/bin/bash

echo "PLEASE ADD 'SUDO' BEFORE RUNNING THIS SCRIPT"

echo "PRESS ENTER TO CONTINUE"
read test

read -r -p "Update your source.list?[yes/No]" response
if [[ "$response" =~ ^([yY][eE][sS]|[yY]|[yY])+$ ]]
then
	echo "---------------------------UPDATING SOURCE.LIST--------------------------------"
	release=$(cat /etc/issue | grep -E '18.04|16.04')

	if [[ $release =~ "18.04" ]]
	then
		echo "VERSION DETECTED: 18.04"
		sudo cat /etc/apt/sources.list > /etc/apt/sources.list.bak
		sudo cat ./18.04 > /etc/apt/sources.list
	elif [[ $release =~ "16.04" ]]
	then
		echo "VERSION DETECTED: 16.04"
		sudo cat /etc/apt/sources.list > /etc/apt/sources.list.bak
		sudo cat ./16.04 > /etc/apt/sources.list
	fi
fi

echo "------------------------------PYTHON RELATED------------------------------------"

echo "SPEED UP ON PIP"

mkdir ~/.pip

echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf

sudo apt-get -y update

sudo apt-get -y upgrade

sudo apt-get -y install python

echo "INSTALLING PIP"
sudo apt-get -y install --fix-missing python-pip

echo "INSTALLING PWNTOOLS"
sudo apt-get -y install python2.7 python-dev git libssl-dev libffi-dev build-essential

pip install --upgrade pip

pip install --upgrade pwntools

echo "INSTALLING LIBCSEARCHER"
git clone https://github.com/lieanu/LibcSearcher.git ~/LibcSearcher
cd ~/LibcSearcher
sudo python setup.py develop

echo "---------------------------------GDB RELATED------------------------------------"

echo "INSTALLING GDB"
sudo apt-get install gdb

echo "INSTALLING PWNDBG"
git clone https://github.com/pwndbg/pwndbg ~/pwndbg

cd ~/pwndbg

./setup.sh

echo "INSTALLING PEDA"
git clone https://github.com/longld/peda.git ~/peda

sudo chmod 666 ~/.gdbinit

echo "source ~/peda/peda.py" >> ~/.gdbinit

echo "-----------------------------------OTHERS---------------------------------------"

echo "INSTALLING ONE_GADGET"
sudo apt -y install ruby

sudo gem install one_gadget