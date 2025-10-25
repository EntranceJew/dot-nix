{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports =
    [
      inputs.stylix.homeModules.stylix
      (import ../stylix.nix true)
    ]
    ++ (lib.nixFilesIn ./programs) ++ (lib.nixFilesIn ./misc) ++ (lib.nixFilesIn ./bundles);

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  home.username = "ej";
  home.homeDirectory = "/home/ej";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    tigervnc

    # auth
    keepassxc

    # comms
    discord

    # general
    kdePackages.kate
    kdePackages.spectacle
    obsidian
    libreoffice

    # phone shit
    scrcpy
    gnirehtet

    # experiment
    # plasma-applet-resources-monitor
  ];
}
