#!/bin/bash

echo "What do you want to do?"
echo 
echo "install-base-packages"
echo "install-joplin"
echo "install-unity-godot"
echo "install-fish"
echo "download-github-projects"
echo "download-configs"
echo "configure-tlp-powertop"
echo "all"
echo
read action

case "$action" in
"install-base-packages")
    echo "What package manager is the current environment using?"
    read package_manager
    echo "You are using $package_manager. Installing your packages..."

    # Install packages I need

    case "$package_manager" in
    # Ubuntu/Debian
    "apt")
        sudo apt install neofetch tlp powertop papirus-icon-theme fcitx fcitx-unikey krita lmms snapd godot3 peek
        #sudo snap install discord
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
        sudo flatpak install lmms godot com.visualstudio.code.oss com.obsproject.Studio zoom
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
"install-joplin")
    echo "Installing Joplin..."
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
    ;;
"install-unity-godot")
    echo "Downloading Unity and Godot..."
    cd ~/Desktop
    wget -O UnityHub.AppImage https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage
    wget -O GodotEngine.zip https://downloads.tuxfamily.org/godotengine/3.2.1/Godot_v3.2.1-stable_x11.64.zip
    chmod +x UnityHub.AppImage
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
*)
    echo "Action unrecognized. It should be added in the future."
    ;;
esac

# Cleanup and finish
cd
echo
echo "Done!"
