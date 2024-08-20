#/usr/bin/
# Get all updates and upgrade from repos
clear
    # make the prompt ask to restart not appear
    echo '* libraries/restart-without-asking boolean true' | sudo debconf-set-selections
    echo -e "[ Installing updates and upgrades from repos ..]"
    apt-get update -y >> /dev/null
    # Get all necessary package
    clear
    echo -e "[ Installing necessary packages ..]"
    DEBIAN_FRONTEND=noninteractive apt-get install curl -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive apt-get install neofetch -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive apt-get install htop -y >> /dev/null
    sleep 1 
    DEBIAN_FRONTEND=noninteractive apt-get install sed -y >> /dev/null

    curl https://getmic.ro | bash
    cd /root/
    mv micro /usr/local/bin
    chmod +x micro
    cd
    clear
    #configure neofetch to show disk
    sed -i 's/# info "Disk" disk/info "Disk" disk/' ~/.config/neofetch/config.conf
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
   
