# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports =
    [
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      inputs.nixos-hardware.nixosModules.common-cpu-intel # ew

      inputs.stylix.nixosModules.stylix
      (import ./stylix.nix false)

      ./gfx/shared.nix
      ./gfx/amd.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]
    ++ (lib.nixFilesIn ./programs) ++ (lib.nixFilesIn ./misc);

  users.users.ej = {
    isNormalUser = true;
    description = "ej";
    extraGroups = ["networkmanager" "wheel" "adbusers" "audio" "video" "libvirtd" "kvm" "lxd" "sway" "docker" "podman" "input" "uinput" "scanner" "lp" "plugdev"];
  };

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

  security.sudo.wheelNeedsPassword = false;

  hardware.enableRedistributableFirmware = true;

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
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Neither of these are needed _for_ anything, because that's not how Nix works.
  # You have them because you must want them for something
  programs.java.enable = true;
  programs.appimage = {
    # Allow running appimages with `appimage-run`
    enable = true;
    # Allow running appimages by just executing the file
    binfmt = true;
  };

  # swag initialized
  programs.sway.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
