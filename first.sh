#/usr/bin/
# Get all updates and upgrade from repos
clear
    echo -e "[ Installing updates and upgrades from repos ..]"
    apt-get update -y >> /dev/null
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
    clear
    echo -e "[ Adding shorcut ..]"
    sleep 2
    if grep -q "neofetch" /root/.profile; then
        touch /usr/local/bin/ports
        echo "netstat -tulpn | grep LISTEN" > /usr/local/bin/ports
        chmod +x /usr/local/bin/ports
        echo -e "[ First time setup completed ! ]"
        sleep 2
        clear
        source .profile
        echo "Done !"
    else
        echo "neofetch" >> .profile
        touch /usr/local/bin/ports
        echo "netstat -tulpn | grep LISTEN" > /usr/local/bin/ports
        chmod +x /usr/local/bin/ports
        echo -e "[ First time setup completed ! ]"
        sleep 2
        clear
        source .profile
        echo "Done !"
    fi
   
