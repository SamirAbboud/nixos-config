{...}: {
  imports = [
    ./modules/desktop.nix
    ./modules/dev.nix
    ./modules/system.nix
  ];
  home.username = "samir";
  home.homeDirectory = "/home/samir";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = false;
}
