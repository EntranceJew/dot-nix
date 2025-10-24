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
