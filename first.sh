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
