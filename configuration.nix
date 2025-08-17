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

      ./misc/audio.nix
      ./misc/games.nix
      ./misc/keyboard.nix
      ./misc/locale.nix
      ./misc/magic-wayland-fixes.nix
      ./misc/network.nix
      ./misc/nvidia.nix
      ./misc/printing.nix
      ./misc/storage.nix
      ./misc/wayland-cope.nix

      ./programs/firefox.nix
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

  # Updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://channels.nixos.org/nixos-25.05";
  };
  # Optimize
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
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
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
        foxundermoon.shell-format
        # samual.hackmud-color
        esbenp.prettier-vscode
        usernamehw.errorlens
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "markwhen";
          publisher = "Markwhen";
          version = "1.4.4";
          sha256 = "r8WqTj+MFTkq34+A4LvinCJN3c6AY0z2RxMT+4rnZvs=";
        }
        {
          name = "hackmud-color";
          publisher = "Samual";
          version = "0.5.0";
          sha256 = "ucSv7KTTXxaf2iYgZ+V69BsjV009vxDzk0BGlh3vGig=";
        }
      ];
    })

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

    # multimedia
    ffmpeg
    gimp
    vlc
    mpvc
    tenacity
    yt-dlp
    kdePackages.kdenlive
    # note: need these for flstudio
    winetricks
    wineWowPackages.stable
    #wineWowPackages.waylandFull
    # note: need this for stage lights
    #qlcplus
  ];

  fonts.packages = with pkgs; [
#     noto-fonts
#     noto-fonts-cjk-sans
#     noto-fonts-emoji
#     liberation_ttf
    fira-code
    fira-code-symbols
#     mplus-outline-fonts.githubRelease
#     dina-font
#     proggyfonts
  ];

  environment.systemPackages = with pkgs; [
    # dev
    gh
    pnpm
    yarn
    nodejs
    nodePackages.prettier
    pastel
    marksman
    pkgs.nixfmt-rfc-style
    pkgs.php83
    wget
    #pkgs.jetbrains.webstorm
    #pkgs.jetbrains.phpstorm
    #pkgs.jetbrains.rider
    #pkgs.jetbrains.clion
    #pkgs.jetbrains-toolbox
    #ungoogled-chromium
    #google-chrome
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
