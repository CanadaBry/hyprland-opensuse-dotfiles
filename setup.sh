#!/bin/sh

########################
### Package Installs ###
########################

# Install NVidia Drivers G06 (Maxwell or newer)
sudo zypper install openSUSE-repos-Tumbleweed-NVIDIA
sudo zypper install nvidia-video-G06 nvidia-gl-G06 nvidia-compute-utils-G06

# Install greeter
sudo zypper install greetd

# Install hyprland
sudo zypper install hyprland kitty qt6-wayland libqt5-qtwayland

# Install "Must Haves"
sudo zypper install pipewire pipewire-alsa pipewire-pulseaudio wireplumber # Audio
sudo zypper install polkit-gnome # Polkit
sudo zypper install SwayNotificationCenter # Notification daemon
sudo zypper install xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-utils # Desktop portals

# Install desktop tools
sudo zypper install awk brightnessctl grim hypridle hyprlock hyprpaper nautilus slurp waybar wl-clipboard wofi

# Install Audio, Bluetooth and Network Utilities
sudo zypper install pavucontrol bluez blueman NetworkManager NetworkManager-applet

# Install additional fonts
sudo zypper install adobe-sourcesanspro-fonts jetbrains-mono-fonts fontawesome-fonts

# Install my specific apps
sudo zypper install git docker neovim steam gamescope tree

# Install flatpaks (Using flathub)
sudo zypper install flatpak
flatpak install com.spotify.Client # Spotify
flatpak install dev.vencord.Vesktop # 3rd party Discord client with screenshare+audio
flatpak install io.gitlab.librewolf-community # Privacy focused Firefox browser

#####################
### Configuration ###
#####################

# Copy wallpaper
mkdir -p ~/Pictures/Wallpapers/
cp ./wallpaper/opensuse-uw.jpg ~/Pictures/Wallpapers/

# Copy configs
cp -r ./config ~/.config

# Copy greetd config and start script
sudo sed "s/YOUR_USER/$USER/g" ./root/etc/greetd/config.toml > /etc/greetd/config.toml # Specify current user as auto-login target
sudo cp ./root/usr/local/bin/start-hyprland /usr/local/bin/start-hyprland
sudo chmod +x /usr/local/bin/start-hyprland # Just in case

# Set boot to GUI
sudo systemctl set-default graphical.target

# Enable services
sudo systemctl enable --now greetd # Login Manager
systemctl enable --user --now pipewire pipewire-pulse wireplumber # Audio services

# Set LibreWolf as default browser
xdg-mime default io.gitlab.librewolf-community.desktop x-scheme-handler/http
xdg-mime default io.gitlab.librewolf-community.desktop x-scheme-handler/https
xdg-mime default io.gitlab.librewolf-community.desktop text/html
gio mime x-scheme-handler/https io.gitlab.librewolf-community.desktop
gio mime x-scheme-handler/http io.gitlab.librewolf-community.desktop
gio mime text/html io.gitlab.librewolf-community.desktop

# Set to dark mode
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark

# Done
echo 'Please reboot now'
