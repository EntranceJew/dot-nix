{ config, pkgs, ... }:

{
  nixpkgs.config.cudaSupport = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  nixpkgs.config.allowUnfree = true;
  # services.xserver.videoDrivers = [ "nvidia" ];

  # users.users.ej.packages = with pkgs; [
  #   libva-utils
  # ];

  # hardware.graphics.extraPackages = [
  #   pkgs.nvidia-vaapi-driver
  # ];

  # environment.variables = {
  #   NVD_BACKEND = "direct";
  #   GBM_BACKEND = "nvidia-drm";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #   WLR_NO_HARDWARE_CURSORS = "1";

  #   # NVD_BACKEND = "direct";
  #   LIBVA_DRIVER_NAME = "nvidia";
  # };
  # # Other
  # services.xserver.videoDrivers = [ "nvidia" ];
  # boot = {
  #   initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  #   kernelParams = [ "nvidia-drm.fbdev=1" ];
  # };
  # nixpkgs.config = {
  #   allowUnfree = true;
  #   nvidia.acceptLicense = true;
  # };

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = false;
  #   powerManagement.finegrained = false;

  #   open = true;

  #   nvidiaSettings = true;

  #   package = config.boot.kernelPackages.nvidiaPackages.stable;

  #   prime = {
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };

  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;

  #   # extraPackages = with pkgs; [
  #   #   # nvidia-vaapi-driver
  #   # ];
  # };
}