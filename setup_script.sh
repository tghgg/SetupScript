#!/bin/bash

case "$1" in
"install-base-packages")
    echo "What package manager is the current environment using?"
    read package_manager
    echo "You are using $package_manager. Installing your packages..."

    # Install packages I need

    case "$package_manager" in
    # Ubuntu/Debian
    "apt")
        sudo apt install neofetch tlp powertop papirus-icon-theme fcitx fcitx-unikey krita lmms snapd godot3 peek
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
        # Base packages
        sudo dnf install neofetch tlp powertop papirus-icon-theme fcitx fcitx-unikey kcm-fcitx krita peek
        # Enable Flatpak and install the newest packages
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        sudo flatpak install lmms godot com.visualstudio.code.oss com.obsproject.Studio zoom vlc
        ;;
    # openSUSE
    "zypper")
        sudo zypper install neofetch tlp powertop
        ;;
    *)
        echo "Package manager not recognized. Stopping..."
        ;;
    esac
    ;;
"download-configs")
    echo "Downloading .configs files from GitHub..."
    ;;
"enable-flathub")
    echo "Enabling FlatHub for Flatpak..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    ;;
"install-joplin")
    echo "Installing Joplin..."
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
    ;;
"install-unity")
    echo "Downloading Unity"
    cd ~/Desktop
    wget -O UnityHub.AppImage https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage
    chmod +x UnityHub.AppImage
    ;;
"update-grub")
    echo "Updating GRUB"
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    ;;
"configure-tlp-powertop")
    echo "Enabling TLP and auto-tuning Powertop..."
    sudo systemctl enable tlp
    sudo systemctl start tlp
    sudo powertop --auto-tune
    ;;
"download-github-projects")
    echo "Cloning your projects from GitHub..."
    mkdir ~/Code
    cd ~/Code
    git clone https://github.com/tghgg/SeekerGame.git
    git clone https://github.com/tghgg/AWoO.git
    git clone https://github.com/tghgg/music-player.git
    ;;
"install-flatpak-base")
    echo "Installing flatpaks for base packages"
    flatpak install discord lmms krita godot firefox com.visualstudio.code.oss com.obsproject.Studio Peek zoom vlc
    ;;
"smolfetch")
    if [ "$2" = "small" ] 
    then
        neofetch --ascii_distro "$3"_small --disable theme icons gpu resolution wmtheme cpu wm uptime --color_blocks off
    else
        neofetch --disable theme icons gpu resolution wmtheme cpu wm uptime --color_blocks off
    fi
    ;;
"help")
    echo "Commands:"
    echo "install-base-packages"
    echo "install-flatpak-base"
    echo "install-joplin"
    echo "install-unity"
    echo "install-fish"
    echo "download-github-projects"
    echo "download-configs"
    echo "enable-flathub"
    echo "update-grub"
    echo "configure-tlp-powertop"
    echo "smolfetch"
    ;;
*)
    echo "Action unrecognized."
    ;;
esac
