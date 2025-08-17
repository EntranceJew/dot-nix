{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.variables = {
    # QT_QPA_PLATFORM = "wayland-egl;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ENCORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
  };
}