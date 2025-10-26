
{
  config,
  pkgs,
  ...
}: {
  # enable and configure sway
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      output = {
        "FWG43P3" = {
          pos = "2560 0";
          res = "2560x1440";
        };
        "8VL24P3" = {
          pos = "2560 1440";
          res = "2560x1440";
        };
        "714J7P3" = {
          pos = "0 0";
          res = "2560x1440";
        };
        "CGF55P3" = {
          pos = "0 1440";
          res = "2560x1440";
        };
      };
      /*
      your config go here
      */
    };
  };

  xdg = {
    enable = true;
    userDirs.enable = true;

    # yes its the same as the one in the nixos config, lets just be safe so nothing can break :)
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
      config = {
        common.default = ["gtk"];
        wlroots.default = ["gtk" "wlr"];
      };
    };
  };
}
