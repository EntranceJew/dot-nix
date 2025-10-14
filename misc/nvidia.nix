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
  hardware.graphics.enable = true;
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
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.open = true;  # see the note above
  # hardware.graphics.extraPackages = with pkgs; [
  #   pkgs.nvidia-vaapi-driver
  #   pkgs.libva-utils
  # ];
  
  environment.variables = {
    MOZ_DISABLE_RDD_SANDBOX = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    EGL_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  };
  # environment.systemPackages = with pkgs; [
  # ];
}