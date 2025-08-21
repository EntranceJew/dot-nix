{ config, pkgs, ... }:

{
  # Controllers
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;

  # Handle mouse polling not matching reported speeds:
  boot.extraModprobeConfig = ''
    options usbhid mousepoll=8
  '';
  # for debugging mouse shit:
  # environment.systemPackages = with pkgs; [
  #   pkgs.evhz
  #   pkgs.usbutils
  #   pkgs.libinput
  #   pkgs.sysfsutils
  # ];

  programs.gamescope = {
    enable = true;
    env = {
      # this was the key to getting oblivion to not be shit:
      # <https://github.com/ValveSoftware/gamescope/issues/1592>
      VKD3D_DISABLE_EXTENSIONS="VK_KHR_present_wait";
    };
  };

  # Supporting Packages
  environment.systemPackages = with pkgs; [
    pkgs.gamemode
    pkgs.prismlauncher
  ];

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      env = {
        # this was the key to getting oblivion to not be shit:
        # <https://github.com/ValveSoftware/gamescope/issues/1592>
        VKD3D_DISABLE_EXTENSIONS="VK_KHR_present_wait";
      };
      args = [
        "-W 2560"
        "-H 1440"
        "-O DP-5"
        "-r 60"
        "-F nis"
        "--expose-wayland"
        "--force-grab-cursor"
        "--rt"
      ];
    };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}