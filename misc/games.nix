{ config, pkgs, ... }:

{
  # Controllers
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;

  # Supporting Packages
  environment.systemPackages = with pkgs; [
      pkgs.gamescope
      pkgs.gamemode
  ];

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      args = ["--hdr-enabled"];
    };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  users.users.ej.packages = with pkgs; [
    prismlauncher
  ];
}