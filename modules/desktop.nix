{ pkgs, ... }: {
  home.packages = with pkgs; [
    # GUI Apps
    firefox
    google-chrome
    telegram-desktop
    vscodium
    loupe
    gnome-text-editor
    mpv

    # Desktop & Hyprland Environment
    hypridle
    hyprlock
    waybar
    swaynotificationcenter
    rofi
    awww
    xdg-user-dirs
    nwg-look
    kdePackages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    bibata-cursors
    gtk3
    glib
    gsettings-desktop-schemas

    # Thunar File Manager
    thunar
    thunar-archive-plugin
    thunar-volman
    tumbler
    ffmpegthumbnailer
    ffmpeg
    xfconf
  ];
}
