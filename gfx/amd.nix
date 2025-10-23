{ config, pkgs, lib, ... }:

{
  boot.kernelParams = [
    "video=DP-4:2560x1440@60"
    "video=DP-5:2560x1440@60"
    "video=DP-8:2560x1440@60"
    "video=DP-9:2560x1440@60"
    "amdgpu.sg_display=0"
    "amdgpu.runpm=0"
    "amdgpu.dcdebugmask=0x12"
    "amdgpu.ppfeaturemask=0xfff7ffff"
    "radeon.cik_support=0"
    "radeon.si_support=0"
    "amdgpu.cik_support=1"
    "amdgpu.si_support=1"
    "amdgpu.dc=1"
  ];
  services.xserver.videoDrivers = [ "modesetting" ];
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.initrd.enable = true;
}