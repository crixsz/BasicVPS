#/usr/bin/bash

# Function to display a progress bar
progress_bar() {
    local duration=$1
    local steps=$2
    local message=$3
    local width=50
    local progress=0
    local fill
    local empty
    local percentage
    
    echo -ne "\n\033[1;34m$message\033[0m\n"
    
    for ((i=0; i <= steps; i++)); do
        percentage=$((i * 100 / steps))
        fill=$((i * width / steps))
        empty=$((width - fill))
        
        printf "\r["
        printf "%${fill}s" '' | tr ' ' '='
        printf "%${empty}s" '' | tr ' ' ' '
        printf "] %d%%" $percentage
        
        sleep $(echo "scale=4; $duration/$steps" | bc)
    done
    echo -e "\n"
}

# Function to execute command with status
execute_with_status() {
    local command="$1"
    local message="$2"
    local duration="$3"
    
    echo -ne "\033[1;33m➜ $message\033[0m"
    eval "$command" &>/dev/null &
    progress_bar "$duration" 20 "Processing..."
    echo -e "\033[1;32m✓ Done!\033[0m\n"
}

# Clear screen and show welcome message
clear
echo -e "\033[1;36m╔═══════════════════════════════╗"
echo -e "║     Basic VPS Setup Script              ║"
echo -e "╚═════════════════════════════════════════╝\033[0m\n"

# Check if ports command is already installed
if [ -f "/usr/local/bin/ports" ]; then
    echo -e "\033[1;33m⚠️  Notice:\033[0m"
    echo -e "\033[1;31m'ports' command is already installed on this system.\033[0m"
    echo -e "\033[1;34mSkipping installation to prevent conflicts.\033[0m"
    exit 0
fi

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

# Configure system to skip restart prompts
echo -e "\n\033[1;34m📦 Configuring system settings...\033[0m"
echo '* libraries/restart-without-asking boolean true' | $CMD_PREFIX debconf-set-selections

# Update system
execute_with_status "$CMD_PREFIX apt-get update -y" "Updating system packages" 3

# Install necessary packages
echo -e "\n\033[1;34m📦 Installing necessary packages...\033[0m"

packages=(
    "curl"
    "neofetch"
    "net-tools"
    "htop"
    "sed"
    "ncdu"
)

total_packages=${#packages[@]}
current_package=1

for package in "${packages[@]}"; do
    echo -e "\n\033[1;33m[$current_package/$total_packages] Installing $package\033[0m"
    execute_with_status "DEBIAN_FRONTEND=noninteractive $CMD_PREFIX apt-get install $package -y" "Installing $package" 2
    ((current_package++))
    
    # Install micro editor
    echo -e "\n\033[1;34m📝 Installing Micro editor...\033[0m"
    execute_with_status "$CMD_PREFIX wget https://github.com/zyedidia/micro/releases/download/v2.0.12/micro-2.0.12-amd64.deb" "Downloading Micro editor" 3
    execute_with_status "$CMD_PREFIX dpkg -i micro-2.0.12-amd64.deb" "Installing Micro editor" 2
    execute_with_status "$CMD_PREFIX mv /usr/bin/micro /usr/local/bin" "Configuring Micro editor" 1
    rm micro-2.0.12-amd64.deb
    cd
    
    # Configure neofetch
    echo -e "\n\033[1;34m⚙️ Configuring Neofetch...\033[0m"
    execute_with_status "sed -i 's/# info \"Disk\" disk/info \"Disk\" disk/' ~/.config/neofetch/config.conf" "Updating Neofetch configuration" 1

    # Setup SSH access
    echo -e "\n\033[1;34m🔑 Setting up SSH access...\033[0m"
    
    # Setup SSH directory and files
    execute_with_status "mkdir -p /root/.ssh && chmod 700 /root/.ssh" "Creating SSH directory" 1
    execute_with_status "touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys" "Creating authorized_keys file" 1
    
    # Add SSH key
    echo -e "\n\033[1;33m➜ Adding SSH key...\033[0m"
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0xxIhD3Xx7AgGEwe17/TnCnWcH8OYLudCYK1RY92iKnH3u81c3rRZzyiw0zK5W26theTAovy4+yctyeHVFlRXQywRF8ZMbGq3jbCUrhTrwoeIBI420f8iuED4aInwGdKocXpcncXP/2UJU7jRu7Ia2pIV94LeTLEwUhiQiHC5nrNeSVtbRmP9R3eUmADpQpi8AyXgMZW8KVuDiZdxdndSSGVQGTWxXVEIQMLxcC6N4Gi0uezOjK7dtUVVYtREyEhe8MfeutB2L0AWHDeNZeQLsCObxvNSTYIS7gutPCpV8Ij3CyKwjBpE2XVXUgIHzDhq+4GmW7rb9MIXqUV5+ByjbVOA/RhSIK3TnmLdbgXiXcl9p9umkU6OfK5N7xr5fOASyo8goSMdJEXLb6JHKACjb0DOk9tXZqCcWCLUCLQwf+dKpP9JIZxYJqWLSff/sA92cJJpT2e09JuxhGlUXPVyv4O4nDj5e0K5MTSc3v1yRNeofcUtdhK8KNjWbnnHW+M= pikai@DESKTOP-6ADGP1J" >> "$HOME/.ssh/authorized_keys"
    chmod 600 "/root/.ssh/authorized_keys"
    echo -e "\033[1;32m✓ SSH key added successfully!\033[0m\n"

    # Final setup
    echo -e "\n\033[1;34m🎉 Finalizing setup...\033[0m"
    
    if grep -q "neofetch" /root/.profile; then
        execute_with_status "touch /usr/local/bin/ports && echo 'netstat -tulpn | grep LISTEN' > /usr/local/bin/ports && chmod +x /usr/local/bin/ports" "Setting up ports command" 1
    else
        execute_with_status "echo 'neofetch' >> .profile" "Adding neofetch to profile" 1
        execute_with_status "touch /usr/local/bin/ports && echo 'netstat -tulpn | grep LISTEN' > /usr/local/bin/ports && chmod +x /usr/local/bin/ports" "Setting up ports command" 1
    fi

    # Final message
    echo -e "\n\033[1;32m✨ Setup completed successfully! ✨\033[0m"
    echo -e "\033[1;34m• System has been configured"
    echo -e "• All packages have been installed"
    echo -e "• SSH access has been set up"
    echo -e "• Custom commands are ready to use\033[0m\n"
    
    sleep 2
    source .profile
   
