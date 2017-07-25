#INSTALL LINUX DEBIAN  WEBMIN APACHE MYSQL-SERVER PHPMYADMIN NMAP  HEXPARROT MINECRAFT 
#-----------------------------------------------------------------------------------------------------------------
#Original Distro MInecraft file Carlos Coelho 2017 - Zept3P -
#-----------------------------------------------------------------------------------------------------------------

#FIRST DEBIAN-WEB
#----------------------------------------

#Install debian netinstall

#addres to download ------>
#http://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-8.7.1-i386-netinst.iso
#http://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.7.1-amd64-netinst.iso

#
echo install WEBMIN 
#-----------------------------------------

#in terminal server
#----------------------------------------------------------------------
apt-get update
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.850_all.deb
dpkg --install webmin_1.850_all.deb
# on error fault -> libraries -> 
# on port error /etc/init.d/webmin restart
# editing /etc/webmin/miniserv.conf port 10000 to 10222
apt-get install -f


echo THIRDY PHP MYSQL APACHE NMAP SAMBA
#----------------------------------------------------------------------

apt-get update install
apt-get install apache2 -y
apt-get install php7.0 -y
apt-get install mysql-server
apt-get install phpmyadmin
apt-get install nmap -y
apt-get install samba -y
#  monitor lan
apt-get install iptraf-ng -y 
# case fault ifconfig
apt-get install install net-tools -y 
#  recover images
apt-get install testdisk  -y 
#monitor your Server ---  Start $glances
apt-get install glances -y 
#-----------------------------------------------------------------------
echo START  VAR/WWW modify to your user
#-----------------------------------------------------------------------
cd /var/www
chown www-data:www-data -R *
chown root:root -R *
chown zombie:zombie -R *
/etc/init.d/apache2 restart
#-----------------------------------------------------------------------
echo INSTALL  DNS NO-IP START
#----------------------------------------------------------------------

cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
cd noip-2.1.9-1
make
#configure 
make install
#
#----------------------------------------------------------------------
#----------------------------------------------------------------------
#http://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(apt-get)
#-----------------------------------------
apt-get update
# update repositories

apt-get install curl
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get update

# download the necessary prerequisite components for mineos
apt-get -y install nodejs supervisor git rdiff-backup screen build-essential openjdk-8-jre-headless

# download the most recent mineos web-ui files from github
mkdir -p /usr/games
cd /usr/games
git clone https://github.com/hexparrot/mineos-node.git minecraft
cd minecraft
git config core.filemode false
chmod +x service.js mineos_console.js generate-sslcert.sh webui.js
ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos
cp mineos.conf /etc/mineos.conf
npm install

# distribute service related files
cp init/supervisor_conf /etc/supervisor/conf.d/mineos.conf

# generate self-signed certificate
./generate-sslcert.sh

# start the background service
supervisorctl reload

echo START INSTALL UTORRENT
#-------------------------------
apt-get update
mkdir downloads
cd downloads
wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
mv linux-x64-debian-7-0 linux-x64-debian-7-0.tar.gz
tar -zxvf linux-x64-debian-7-0.tar.gz -C /opt/
chown root:root -R /opt/utorrent-server-alpha-v3_3/
ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
# apt-get install libssl1.0.0 libssl-dev original squeze
# for debian stretch
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
#--------------------------
echo INIT AS SERVICE UTORRENT
#--------------------

wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/utorrent
chmod 755 utorrent
cp utorrent /etc/init.d/
cd /etc/init.d/
update-rc.d utorrent defaults
service utorrent start
#systemctl status utorrent.service
service utorrent restart

#--------------------------
echo END INSTALl UTORRENT
#--------------------
# service utorrent stop
#---
#need remove 
#update-rc.d utorrent remove
#---
#------------------------
echo  IPTABLES RULES
#------------------------


echo  Teamspeak iptables
iptables -A INPUT -p udp --dport 9987 -j ACCEPT
iptables -A INPUT -p udp --sport 9987 -j ACCEPT

iptables -A INPUT -p tcp --dport 30033 -j ACCEPT
iptables -A INPUT -p tcp --sport 30033 -j ACCEPT

iptables -A INPUT -p tcp --dport 10011 -j ACCEPT
iptables -A INPUT -p tcp --sport 10011 -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT

iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --sport 8080 -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT

echo  SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -j ACCEPT

echo DNS
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

echo MINECRAFT
iptables -A INPUT -p udp --dport 25565 -j ACCEPT
iptables -A INPUT -p udp --sport 25565 -j ACCEPT
iptables -A INPUT -p udp --dport 25567 -j ACCEPT
iptables -A INPUT -p udp --sport 25567 -j ACCEPT

echo CONA SERVER
iptables -A INPUT -p udp --dport 7787 -j ACCEPT
iptables -A INPUT -p udp --sport 7787 -j ACCEPT
iptables -A INPUT -p udp --dport 8888 -j ACCEPT
iptables -A INPUT -p udp --sport 8888 -j ACCEPT

    
echo SAVE
iptables-save > /etc/iptables.up.rules
echo RESTORE
iptables-restore < /etc/iptables.up.rules

echo  flush
iptables -L


#--------------------------
   echo TEAMSPEAK3 SERVER
#--------------------------
	
wget http://ftp.4players.de/pub/hosted/ts3/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
tar xzf teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
adduser --disabled-login teamspeak3
mv teamspeak3-server_linux-amd64 /usr/local/teamspeak3
chown -R teamspeak3 /usr/local/teamspeak3
ln -s /usr/local/teamspeak3/ts3server_startscript.sh /etc/init.d/teamspeak3
update-rc.d teamspeak3 defaults
service teamspeak3 start

#---------------------------
   echo END TEAMSPEAK
#--------------------------

#----------------------------------------------
echo INSTALL CONAN EXILES SERVER
#----------------------------------------------

apt-get install libfreetype6-dev libX11-dev libxml2-dev libxslt1-dev make flex bison lib32gcc1 curl screen ca-certificates -y
screen
wget http://dl.winehq.org/wine/source/2.0/wine-2.0.tar.bz2
tar -xvf wine-2.0.tar.bz2 -C /usr/src/
apt-get install q4wine
apt-get install mono-complete
cd /usr/src/wine-2.0/
./configure --with-png --enable-win64
make -j X 
cat /proc/cpuinfo | grep processor | wc -l
make install 
cd ~
mkdir Conan
cd Conan
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
./steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir ~/Conan/Serverfiles +login anonymous +app_update 443030 validate +quit 

#---------------------------
   echo Netdata INSTALL
#--------------------------
apt-get install uuid-dev
curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh -i netdata-all
apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata
./netdata-installer.sh
# stop netdata
killall netdata
# copy netdata.service to systemd
cp system/netdata.service /etc/systemd/system/
# let systemd know there is a new service
systemctl daemon-reload
# enable netdata at boot
systemctl enable netdata
# start netdata
systemctl start netdata
#---------------------------
   echo Netdata END
#--------------------------
#Reboot to make sure it all works
## FINISH ALL INSTALED ##


