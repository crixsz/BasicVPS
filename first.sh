#/usr/bin/bash
# Get all updates and upgrade from repos
clear

# Check if the system is Ubuntu or Debian
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# Set the command prefix based on the OS
if [ "$OS" = "ubuntu" ]; then
    CMD_PREFIX="sudo"
else
    CMD_PREFIX=""
fi

# make the prompt ask to restart not appear
echo '* libraries/restart-without-asking boolean true' | $CMD_PREFIX debconf-set-selections
echo -e "[ Installing updates and upgrades from repos ..]"
$CMD_PREFIX apt-get update -y >> /dev/null
    # Get all necessary package
    clear
    echo -e "[ Installing necessary packages ..]"
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install curl -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install neofetch -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install net-tools -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install htop -y >> /dev/null
    sleep 1 
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install sed -y >> /dev/null
    sleep 1
    DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install ncdu -y >> /dev/null
    
    ## Install micro
    $CMD_PREFIX wget https://github.com/zyedidia/micro/releases/download/v2.0.12/micro-2.0.12-amd64.deb 
    $CMD_PREFIX dpkg -i micro-2.0.12-amd64.deb
    $CMD_PREFIX mv /usr/bin/micro /usr/local/bin
    rm micro-2.0.12-amd64.deb
    cd
    clear
    #configure neofetch to show disk
    sed -i 's/# info "Disk" disk/info "Disk" disk/' ~/.config/neofetch/config.conf
    clear 
    echo -e "[ Adding authorized key local PC..]"
    # Ensure .ssh directory exists
    if [ ! -d "/root/.ssh" ]; then
      mkdir -p "/root/.ssh"
      chmod 700 "/root/.ssh"
    fi
    # Ensure authorized_keys file exists
    if [ ! -f "/root/.ssh/authorized_keys" ]; then
      touch "/root/.ssh/authorized_keys"
      chmod 600 "/root/.ssh/authorized_keys"
    fi
    # Append the SSH key to authorized_keys
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0xxIhD3Xx7AgGEwe17/TnCnWcH8OYLudCYK1RY92iKnH3u81c3rRZzyiw0zK5W26theTAovy4+yctyeHVFlRXQywRF8ZMbGq3jbCUrhTrwoeIBI420f8iuED4aInwGdKocXpcncXP/2UJU7jRu7Ia2pIV94LeTLEwUhiQiHC5nrNeSVtbRmP9R3eUmADpQpi8AyXgMZW8KVuDiZdxdndSSGVQGTWxXVEIQMLxcC6N4Gi0uezOjK7dtUVVYtREyEhe8MfeutB2L0AWHDeNZeQLsCObxvNSTYIS7gutPCpV8Ij3CyKwjBpE2XVXUgIHzDhq+4GmW7rb9MIXqUV5+ByjbVOA/RhSIK3TnmLdbgXiXcl9p9umkU6OfK5N7xr5fOASyo8goSMdJEXLb6JHKACjb0DOk9tXZqCcWCLUCLQwf+dKpP9JIZxYJqWLSff/sA92cJJpT2e09JuxhGlUXPVyv4O4nDj5e0K5MTSc3v1yRNeofcUtdhK8KNjWbnnHW+M= pikai@DESKTOP-6ADGP1J" >> "$HOME/.ssh/authorized_keys"
    # Ensure the correct permissions on authorized_keys
    chmod 600 "/root/.ssh/authorized_keys"

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
   
