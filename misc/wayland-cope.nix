{ config, pkgs, ... }:

{
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";
  services.xserver.enable = true;

  users.users.ej.packages = with pkgs; [
    # look at all this bullshit just to do what xdotool can do
    dotool
    xdotool
    ydotool
    kdotool
    wlrctl
    wmctrl
    # more bullshit
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde
  ];

  # maybe fixes some bullshit with color banding?
  environment.variables = {
    DXVK_HDR="1";
    ENABLE_HDR_WSI="1";
    SDL_VIDEODRIVER="wayland";
    PROTON_ENABLE_WAYLAND="1";
    PROTON_ENABLE_HDR="1";
  };

  # all these environment things for some reason don't come stock with the combination of other packages
  # they are, for all intents and purposes, magic
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.variables = {
    QT_QPA_PLATFORM = "wayland;wayland-egl;xcb";
    # what the fuck: https://www.reddit.com/r/NixOS/comments/1l7zo0f/sddm_weird_problem_with_the_picture_quality/
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    ENCORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
  };

  # services.xrdp = {
  #   enable = true;
  #   defaultWindowManager = "startplasma-wayland";
  # };

  ## what
  # xdg.portal = {
  #   enable = true;
  #   wlr = {
  #     enable = true;
  #     settings = {
  #       screencast = {
  #         max_fps = 55;
  #         chooser_type = "simple";
  #         chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #       };
  #     };
  #   };
  #   config = {
  #     wlroots.default = ["wlr" "gtk"];
  #     common.default = ["gtk"];
  #   };
  # };
}