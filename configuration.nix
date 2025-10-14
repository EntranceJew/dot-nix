# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix

      ./misc/3dconnexion.nix
      ./misc/scanner.nix
      ./misc/bluetooth.nix
      ./misc/audio.nix
      ./misc/flipper.nix
      ./misc/games.nix
      ./misc/keyboard.nix
      ./misc/locale.nix
      ./misc/network.nix
      ./misc/nvidia.nix
      ./misc/printing.nix
      ./misc/storage.nix
      ./misc/tablet.nix
      ./misc/wayland-cope.nix

      ./bundles/dev.nix
      ./bundles/media.nix

      ./programs/git.nix
      ./programs/mullvad.nix
      ./programs/obs.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Wake The Fuck Up
  powerManagement.enable = false;
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # Enforce Desktop Environment
  environment.variables = {
    KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  };
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://channels.nixos.org/nixos-25.05";
  };

  # Prevent Infinite Garbage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };
  nix.settings.auto-optimise-store = true;

  # why are these here? idk.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.java.enable = true;

  # The User
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ej";
  users.users.ej = {
    isNormalUser = true;
    description = "ej";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.ej.packages = with pkgs; [
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
    
  ];

  # fonts.packages = with pkgs; [
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-emoji
    # liberation_ttf
    # mplus-outline-fonts.githubRelease
    # dina-font
    # proggyfonts
  # ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
