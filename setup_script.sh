#!/bin/bash

# Determine the package manager of the system
echo "What package manager is the current environment using?"
read package_manager
echo "You are using $package_manager. Installing your packages..."

# Install packages I need

case "$package_manager" in
# Ubuntu/Debian
"apt")
    sudo apt install neofetch tlp powertop godot3 
    sudo snap install discord
    sudo snap install codium --classic
    ;;
# Arch
"pacman")
    sudo pacman -S neofetch tlp powertop pacmatic discord papirus-icon-theme breeze fcitx fcitx-unikey kcm-fcitx
    sudo pacmatic -Syu
    echo "Choose the Desktop Environment you want to use."
    read DE
    echo "Installing $DE"
    case "$DE" in
    "plasma")
        sudo pacmatic -S plasma-meta kate konsole dolphin
        ;;
    "xfce")
        sudo pacmatic -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
        ;;
    *)
        echo "DE choice unrecognized. Moving on...."
        ;;
    esac
    ;;
# Fedora
"dnf")
    sudo dnf install neofetch tlp powertop godot
    ;;
# openSUSE
"zypper")
    sudo zypper install neofetch tlp powertop
    ;;
*)
    echo "Package manager not recognized. Stopping..."
    ;;
esac
# Install Joplin with their script
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

# Configure stuff
sudo systemctl enable tlp
sudo systemctl start tlp
sudo powertop --auto-tune


# Clone my code projects from GitHub
mkdir ~/Code
cd ~/Code
git clone https://github.com/tghgg/SeekerGame.git
git clone https://github.com/tghgg/AWoO.git
git clone https://github.com/tghgg/music-player.git

# Cleanup and finish
clear
neofetch
