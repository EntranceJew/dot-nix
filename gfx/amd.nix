{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "modesetting" ];
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.initrd.enable = true;
}