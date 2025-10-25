{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = [
    # you shouldnt need this since nothing should be crashing anymore
    "amdgpu.runpm=0"
  ];
  services.xserver.videoDrivers = ["modesetting"];
  hardware.amdgpu.initrd.enable = true;
}
