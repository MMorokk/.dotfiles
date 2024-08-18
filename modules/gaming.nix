{ config, pkgs, ... }:

{
  
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  hardware.steam-hardware.enable = true;

  programs.gamemode.enable = true;

  programs.gamescope.enable = true;

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    #bottles
    lutris
    winePackages.stagingFull
    # winetricks (all versions)
    winetricks
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];

  environment.variables = rec {
    VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json;
  };
}
