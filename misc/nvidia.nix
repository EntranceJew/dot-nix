{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  nixpkgs.config = {
    cudaSupport = true;
    allowUnfree = true;
    # nvidia.acceptLicense = true;
  };
  hardware.graphics.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production.overrideAttrs {
    version = "580.76.05";
    src = pkgs.fetchurl {
      url = "https://us.download.nvidia.com/XFree86/Linux-x86_64/580.76.05/NVIDIA-Linux-x86_64-580.76.05.run";
      sha256 = "1zcpbp859h5whym0r54a3xrkqdl7z3py1hg8n8hv0c89nqvfd6r1";
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
  };
  # environment.systemPackages = with pkgs; [
  # ];
}