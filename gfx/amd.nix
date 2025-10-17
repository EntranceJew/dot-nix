{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "modesetting" "amdgpu" ];
  nixpkgs.config = {
    rocmSupport = true;
    allowUnfree = true;
  };
  hardware.amdgpu = {
    initrd.enable = true;
  };
}