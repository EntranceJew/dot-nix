{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
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