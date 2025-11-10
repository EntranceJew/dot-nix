{
  config,
  pkgs,
  ...
}: {
  # yes its the same as the one in the nixos config, lets just be safe so nothing can break :)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
    config = {
      common.default = ["gtk"];
      wlroots.default = ["gtk" "wlr"];
    };
  };

  # programs.sway.enable = true;

  # Having a login screen is nice
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --user-menu --user-menu-max-uid 30000 --cmd sway";
      };
    };
  };

  # Many packages use this for configuration, and it is normally enabled by a DE if you have one (we dont)
  programs.dconf.enable = true;
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf];
  };

  # fonts stuff that DEs normally set up
  fonts.fontconfig.enable = true;
  fonts.enableDefaultPackages = true;

  # input stuff DEs normally set up
  services.libinput.enable = true;

  # power management stuff DEs normally set up
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = false;
  services.system76-scheduler.enable = true;
  services.tuned = {
    enable = true;
    # settings.dynamic_tuning = true;
  };
}
