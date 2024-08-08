# This is a script to setup the environment of tmux to install it to a operating
# system that does not have it installed. This script will install tmux and its
# dependencies to the system. 

#!/bin/bash

# Detect the operating system

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
else
    OS=$(uname -s)
fi

# Install tmux and its dependencies

if [ "$OS" == "Ubuntu" ]; then
    sudo apt-get update
    sudo apt-get install -y tmux
elif [ "$OS" == "CentOS Linux" ]; then
    sudo yum install -y tmux
elif [ "$OS" == "Fedora" ]; then
    sudo dnf install -y tmux
elif [ "$OS" == "Debian GNU/Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y tmux
elif [ "$OS" == "Arch Linux" ]; then
    sudo pacman -S tmux
elif [ "$OS" == "Gentoo" ]; then
    sudo emerge tmux
elif [ "$OS" == "Alpine Linux" ]; then
    sudo apk add tmux
else
    echo "Operating system not supported"
fi

# Check if tmux is installed

if [ -x "$(command -v tmux)" ]; then
    echo "tmux is installed"
else
    echo "tmux is not installed"
fi

# Install TPM (Tmux Plugin Manager)

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy configuration file to home directory

echo .tmux.conf >> ~/.tmux.conf

# Install plugins

~/.tmux/plugins/tpm/bin/install_plugins

# Source the configuration file

tmux source-file ~/.tmux.conf

echo "tmux is installed and configured"
