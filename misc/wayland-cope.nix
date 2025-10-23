{ config, pkgs, ... }:

{
  services.displayManager.sddm.wayland.enable = false;
  # services.displayManager.sddm.settings.General.DisplayServer = "wayland";

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

  # home.sessionVariables = {
  #   MOZ_ENABLE_WAYLAND = "1";
  # };

  # # librewolf wayland cope combo
  # programs.librewolf = {
  #   policies = {
  #     Preferences = {
  #       "widget.gtk.global-menu.wayland.enabled" = true;
  #       "widget.wayland.opaque-region.enabled" = true;
  #       "widget.wayland.fractional-scale.enabled" = true;
  #       "widget.wayland.vsync.keep-firing-at-idle" = true;
  #       "gfx.wayland.hdr" = true;
  #       "gfx.wayland-egl.force-enabled" = true;
  #     };
  #   };
  # };

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
    NVD_BACKEND = "direct";
    EGL_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS="1";
  };

  # services.xrdp = {
  #   enable = true;
  #   defaultWindowManager = "startplasma-wayland";
  # };
}
