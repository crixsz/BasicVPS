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
    # DEBIAN_FRONTEND=noninteractive apt-get install neofetch -y >> /dev/null
    wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.21.3/fastfetch-linux-amd64.deb
    dpkg -i fastfetch-linux-amd64.deb
    rm fastfetch-linux-amd64.deb
    clear
    sleep 1
    DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive apt-get install htop -y >> /dev/null
    sleep 1 
    curl https://getmic.ro | bash
    cd /root/
    mv micro /usr/local/bin
    chmod +x micro
    cd
    clear
    echo -e "[ Adding shorcut ..]"
    sleep 2
    if grep -q "fastfetch" /root/.profile; then
        touch /usr/local/bin/ports
        echo "netstat -tulpn | grep LISTEN" > /usr/local/bin/ports
        chmod +x /usr/local/bin/ports
        echo -e "[ First time setup completed ! ]"
        sleep 2
        clear
        source .profile
        echo "Done !"
    else
        echo "fastfetch" >> .profile
        touch /usr/local/bin/ports
        echo "netstat -tulpn | grep LISTEN" > /usr/local/bin/ports
        chmod +x /usr/local/bin/ports
        echo -e "[ First time setup completed ! ]"
        sleep 2
        clear
        source .profile
        echo "Done !"
    fi
   
