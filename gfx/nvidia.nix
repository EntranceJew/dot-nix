{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  # boot = {
  #   # nvidia-uvm is required for CUDA applications
  #   kernelModules = [ "nvidia-uvm" ];
  #   blacklistedKernelModules = [ "nouveau" ];
  # };
  nixpkgs.config = {
    cudaSupport = true;
    allowUnfree = true;
    # nvidia.acceptLicense = true;
  };
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.production.overrideAttrs {
      version = "580.95.05";
      src = pkgs.fetchurl {
        url = "https://us.download.nvidia.com/XFree86/Linux-x86_64/580.95.05/NVIDIA-Linux-x86_64-580.95.05.run";
        sha256 = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
      };
    };
  };
  # boot = {
    # kernelParams = [
      # "nvidia_modeset.hdmi_deepcolor=0"
      # "module_blacklist=i915"
      # "nvidia-drm.fbdev=1"
      # "nvidia-drm.modeset=1"
      # "nvidia.NVreg_UsePageAttributeTable=1" # why this isn't default is beyond me.
      # "nvidia_modeset.disable_vrr_memclk_switch=1" # stop really high memclk when vrr is in use.
    # ];
    # kernelModules = ["nvidia-drm" "nvidia-uvm"];
  # };
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.open = true;  # see the note above
  # hardware.graphics.extraPackages = with pkgs; [
  #   pkgs.nvidia-vaapi-driver
  #   pkgs.libva-utils
  # ];
  
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    KWIN_DRM_ALLOW_NVIDIA_COLORSPACE="1";
    # KWIN_DRM_ALLOW_INTEL_COLORSPACE="1";
    # KWIN_DRM_DEVICES="/dev/dri/by-path/pci-0000:01:00.0-card";
    # KWIN_DRM_DISABLE_TRIPLE_BUFFERING="1";
    # KWIN_DISABLE_TONEMAPPING="1";
  };
  # environment.systemPackages = with pkgs; [
  # ];

  ## display shit in particular
  # boot.kernelParams = [ "nvidia-drm.fbdev=0" "nvidia-drm.modeset=1" ];
  # hardware.nvidia.modesetting.enable = lib.mkForce false;
}