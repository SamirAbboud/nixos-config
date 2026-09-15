{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Terminal Utilities
    kitty
    starship
    eza
    zoxide
    fzf
    bat
    duf
    dust
    tree
    jq
    unzip
    yt-dlp
    brightnessctl
    playerctl
    libnotify
    psmisc
    blueman
    networkmanagerapplet
    mission-center
    btop
    powertop
    sassc
    rsync
    trash-cli
    pulseaudio
    peaclock

    # Wayland Screen & Clipboard Tools
    wl-clipboard
    cliphist
    wl-clip-persist
    wtype
    grim
    slurp
    wf-recorder
  ];
}
