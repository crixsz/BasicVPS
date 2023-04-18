#/usr/bin/
# Get all updates and upgrade from repos
clear
echo -e "[ Installing updates and upgrades from repos ..]"
apt-get update -y >> /dev/null
apt-get upgrade -y >> /dev/null
# Get all necessary package
clear
echo -e "[ Installing necessary packages ..]"
apt-get install curl -y >> /dev/null
sleep 1
apt-get install neofetch -y >> /dev/null
sleep 1
apt-get install net-tools -y >> /dev/null
sleep 1
apt-get install htop -y >> /dev/null
sleep 1 
curl https://getmic.ro | bash
sleep 1 
curl -fsSL https://code-server.dev/install.sh | sh
sleep 2
mkdir .config/code-server/
touch .config/code-server/config.yaml
echo "
bind-addr: 0.0.0.0:8118
auth: password
password: zoxxenon
cert: false
" >> .config/code-server/config.yaml
touch /etc/systemd/system/code-server.service
echo "
[Unit]
Description=Code-Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/code-server
Restart=always
TimeoutSec=30

[Install]
WantedBy=multi-user.target

" >> /etc/systemd/system/code-server.service
systemctl daemon-reload
systemctl enable code-server
systemctl restart code-server
clear
echo -e "[ Adding shorcut ..]"
sleep 2
echo "neofetch" >> .profile
echo "alias ports='netstat -tulpn | grep LISTEN'" >> .profile
echo -e "[ First time setup completed ! ]"
sleep 5
clear
source .profile
echo -e "[ Rebooting in 5 seconds .. ]"
sleep 5 
reboot
rm -rf first.sh
