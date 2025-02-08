#!/bin/bash

# Script root yetkisiyle çalışmalı
if [ "$EUID" -ne 0 ]; then
  echo "Lütfen script'i root olarak çalıştırın."
  exit
fi

echo "Sistem güncelleniyor..."
apt update && apt upgrade -y

echo "Distro güncelleniyor..."
apt dist-upgrade -y

# Helper function to check if a command was successful and remove the tool if it failed
function check_installation {
  if [ $? -ne 0 ]; then
    echo "$1 kurulumu başarısız oldu, kaldırılıyor..."
    $2  # This will run the removal command passed as $2
    echo "$1 kaldırıldı, bir sonraki araca geçiliyor..."
  else
    echo "$1 başarıyla kuruldu!"
  fi
}

# Go programlama dili yükleniyor
echo "Go programlama dili yükleniyor..."
wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
tar -xvf go1.17.2.linux-amd64.tar.gz
mv go /usr/local
check_installation "Go" "rm -rf /usr/local/go"

# Go'yu PATH'e eklemek için
echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export GOPATH=$HOME/go" >> ~/.profile
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.profile
source ~/.profile

# /opt dizinine geçiliyor
echo "/opt dizinine geçiliyor ve araçlar buraya indirilecek..."
cd /opt

# LinPEAS yükleniyor
echo "LinPEAS indiriliyor ve kuruluyor..."
git clone https://github.com/carlospolop/PEASS-ng.git
cd PEASS-ng/linPEAS
chmod +x linpeas.sh
cd /opt
check_installation "LinPEAS" "rm -rf /opt/PEASS-ng"

# Sublime Text yükleniyor
echo "Sublime Text yükleniyor..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install sublime-text -y
check_installation "Sublime Text" "apt remove -y sublime-text"

# Evilginx2 yükleniyor
echo "Evilginx2 indiriliyor ve kuruluyor..."
git clone https://github.com/kgretzky/evilginx2.git
cd evilginx2
make
sudo make install
cd /opt
check_installation "Evilginx2" "rm -rf /opt/evilginx2"

# Sn1per yükleniyor
echo "Sn1per indiriliyor ve kuruluyor..."
git clone https://github.com/1N3/Sn1per.git
cd Sn1per
bash install.sh
cd /opt
check_installation "Sn1per" "rm -rf /opt/Sn1per"

# Mobile Security Framework (MobSF) yükleniyor
echo "MobSF indiriliyor ve kuruluyor..."
git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
cd Mobile-Security-Framework-MobSF
./setup.sh
cd /opt
check_installation "MobSF" "rm -rf /opt/Mobile-Security-Framework-MobSF"

# ParamSpider yükleniyor
echo "ParamSpider indiriliyor ve kuruluyor..."
git clone https://github.com/devanshbatham/ParamSpider.git
cd ParamSpider
pip3 install -r requirements.txt
cd /opt
check_installation "ParamSpider" "rm -rf /opt/ParamSpider"

# Arjun yükleniyor
echo "Arjun indiriliyor ve kuruluyor..."
git clone https://github.com/s0md3v/Arjun.git
cd Arjun
pip3 install -r requirements.txt
cd /opt
check_installation "Arjun" "rm -rf /opt/Arjun"

# Sublist3r yükleniyor
echo "Sublist3r indiriliyor ve kuruluyor..."
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip3 install -r requirements.txt
cd /opt
check_installation "Sublist3r" "rm -rf /opt/Sublist3r"

# massdns yükleniyor
echo "massdns indiriliyor ve kuruluyor..."
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
cd /opt
check_installation "massdns" "rm -rf /opt/massdns"

# Knockpy yükleniyor
echo "Knockpy indiriliyor ve kuruluyor..."
git clone https://github.com/guelfoweb/knock.git
cd knock
pip3 install -r requirements.txt
cd /opt
check_installation "Knockpy" "rm -rf /opt/knock"

# masscan yükleniyor
echo "masscan kuruluyor..."
apt install -y masscan
check_installation "masscan" "apt remove -y masscan"

# rustscan yükleniyor
echo "rustscan kuruluyor..."
apt install -y rustscan
check_installation "rustscan" "apt remove -y rustscan"

# dirbuster-ng yükleniyor
echo "dirbuster-ng indiriliyor ve kuruluyor..."
git clone https://github.com/daviddias/node-dirbuster.git
cd node-dirbuster
npm install
cd /opt
check_installation "dirbuster-ng" "rm -rf /opt/node-dirbuster"

# Smuggler yükleniyor
echo "Smuggler indiriliyor ve kuruluyor..."
git clone https://github.com/defparam/smuggler.git
cd smuggler
cd /opt
check_installation "Smuggler" "rm -rf /opt/smuggler"

# Injectus yükleniyor
echo "Injectus indiriliyor ve kuruluyor..."
git clone https://github.com/BountyStrike/Injectus.git
cd Injectus
pip3 install -r requirements.txt
cd /opt
check_installation "Injectus" "rm -rf /opt/Injectus"

# SSRFmap yükleniyor
echo "SSRFmap indiriliyor ve kuruluyor..."
git clone https://github.com/swisskyrepo/SSRFmap.git
cd SSRFmap
pip3 install -r requirements.txt
cd /opt
check_installation "SSRFmap" "rm -rf /opt/SSRFmap"

# XSStrike yükleniyor
echo "XSStrike indiriliyor ve kuruluyor..."
git clone https://github.com/s0md3v/XSStrike.git
cd XSStrike
pip3 install -r requirements.txt
cd /opt
check_installation "XSStrike" "rm -rf /opt/XSStrike"

# xsscrapy yükleniyor
echo "xsscrapy indiriliyor ve kuruluyor..."
git clone https://github.com/DanMcInerney/xsscrapy.git
cd xsscrapy
pip3 install -r requirements.txt
cd /opt
check_installation "xsscrapy" "rm -rf /opt/xsscrapy"

# xssmap yükleniyor
echo "xssmap indiriliyor ve kuruluyor..."
git clone https://github.com/JesusTheHun/xssmap.git
cd xssmap
pip3 install -r requirements.txt
cd /opt
check_installation "xssmap" "rm -rf /opt/xssmap"

# S3Scanner yükleniyor
echo "S3Scanner indiriliyor ve kuruluyor..."
git clone https://github.com/sa7mon/S3Scanner.git
cd S3Scanner
pip3 install -r requirements.txt
cd /opt
check_installation "S3Scanner" "rm -rf /opt/S3Scanner"

# AWSBucketDump yükleniyor
echo "AWSBucketDump indiriliyor ve kuruluyor..."
git clone https://github.com/jordanpotti/AWSBucketDump.git
cd AWSBucketDump
pip3 install -r requirements.txt
cd /opt
check_installation "AWSBucketDump" "rm -rf /opt/AWSBucketDump"

# jwt_tool yükleniyor
echo "jwt_tool indiriliyor ve kuruluyor..."
git clone https://github.com/ticarpi/jwt_tool.git
cd jwt_tool
pip3 install -r requirements.txt
cd /opt
check_installation "jwt_tool" "rm -rf /opt/jwt_tool"

# subjack yükleniyor
echo "subjack indiriliyor ve kuruluyor..."
git clone https://github.com/haccer/subjack.git
cd subjack
go build
cd /opt
check_installation "subjack" "rm -rf /opt/subjack"

# nuclei yükleniyor
echo "nuclei kuruluyor..."
apt install -y nuclei
check_installation "nuclei" "apt remove -y nuclei"

# arachni yükleniyor
echo "arachni indiriliyor ve kuruluyor..."
git clone https://github.com/Arachni/arachni.git
cd arachni
./arachni_ui_web/bin/arachni
cd /opt
check_installation "arachni" "rm -rf /opt/arachni"

# flan yükleniyor
echo "flan indiriliyor ve kuruluyor..."
git clone https://github.com/cloudflare/flan.git
cd flan
pip3 install -r requirements.txt
cd /opt
check_installation "flan" "rm -rf /opt/flan"

# OWASP ZAP yükleniyor
echo "OWASP ZAP kuruluyor..."
apt install -y zaproxy
check_installation "OWASP ZAP" "apt remove -y zaproxy"

# 4-ZERO-3 bypass yükleniyor
echo "4-ZERO-3 indiriliyor ve kuruluyor..."
git clone https://github.com/0xR00t3r/4-ZERO-3.git
cd 4-ZERO-3
cd /opt
check_installation "4-ZERO-3" "rm -rf /opt/4-ZERO-3"

# GoLinkFinder yükleniyor
echo "GoLinkFinder indiriliyor ve kuruluyor..."
git clone https://github.com/0xsha/GoLinkFinder.git
cd GoLinkFinder
go build
cd /opt
check_installation "GoLinkFinder" "rm -rf /opt/GoLinkFinder"

# XSSHunter yükleniyor
echo "XSSHunter indiriliyor ve kuruluyor..."
git clone https://github.com/mandatoryprogrammer/xsshunter.git
cd xsshunter
pip3 install -r requirements.txt
cd /opt
check_installation "XSSHunter" "rm -rf /opt/xsshunter"

# hcxtools yükleniyor
echo "hcxtools indiriliyor ve kuruluyor..."
apt install -y hcxtools
check_installation "hcxtools" "apt remove -y hcxtools"

# hcxdumptool yükleniyor
echo "hcxdumptool indiriliyor ve kuruluyor..."
apt install -y hcxdumptool
check_installation "hcxdumptool" "apt remove -y hcxdumptool"

echo "Sistem tekrar güncelleniyor..."
apt update && apt upgrade -y

echo "Distro tekrar güncelleniyor..."
apt dist-upgrade -y

echo "Gereksiz paketler kaldırılıyor..."
apt autoremove -y
apt clean

echo "root kullanıcısı aktif ediliyor"
apt install kali-root-login

echo "passwd yazıp şifre belirlemeyi unutma"

echo "Kurulum tamamlandı!"

