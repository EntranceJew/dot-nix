
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
        "Dell Inc. DELL U2722D FWG43P3" = {
          pos = "2560 0";
          res = "2560x1440";
        };
        "Dell Inc. DELL U2722D 8VL24P3" = {
          pos = "2560 1440";
          res = "2560x1440";
        };
        "Dell Inc. DELL U2722D 714J7P3" = {
          pos = "0 0";
          res = "2560x1440";
        };
        "Dell Inc. DELL U2722D CGF55P3" = {
          pos = "0 1440";
          res = "2560x1440";
        };
      };
    };
  };

  programs.satty = {
    enable = true;
    settings.general = {
      fullscreen = true;
      initial-tool = "crop";
      early-exit = true;
      copy-command = "wl-copy";
      save-after-copy = true;
      actions-on-enter = ["save-to-clipboard"];
      actions-on-escape = ["exit"];
      output-filename = "${config.home.homeDirectory}/Pictures/Screenshots/satty-%F_%T.png";
    };
  };
  home.packages = with pkgs; [
    wl-clipboard
    sway-contrib.grimshot
    grim
  ];

  wayland.windowManager.sway.config.keybindings."--release Print" = "exec grim - | satty -f -";

  services.clipman.enable = true;

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
