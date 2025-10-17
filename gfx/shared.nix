{ config, pkgs, lib, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables = {
    MOZ_DISABLE_RDD_SANDBOX = "1";
    KWIN_DRM_PREFER_COLOR_DEPTH="24";
    DRM_CAP_DUMB_PREFERRED_DEPTH="24";
  };
}