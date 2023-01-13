#/usr/bin/
# Get all updates and upgrade from repos
clear
clear
echo -e "[ Installing updates and upgrades from repos ..]"
apt-get update -y >> /dev/null
apt-get upgrade -y >> /dev/null
sleep 10
# Get all necessary package
clear
echo -e "[ Installing necessary packages ..]"
apt-get install curl -y >> /dev/null
sleep 3
apt-get install neofetch -y >> /dev/null
sleep 3
apt-get install net-tools -y >> /dev/null
sleep 3
apt-get install htop -y >> /dev/null
sleep 3 
apt-get install htop -y >> /dev/null
sleep 3 
curl https://getmic.ro | bash
clear
echo -e "[ Adding shorcut ..]"
sleep 3
echo "neofetch" >> .profile
echo "alias ports='netstat -tulpn | grep LISTEN'" >> .profile
echo -e "[ First time setup completed ! ]"
sleep 5
clear
source .profile 

