
{
  config,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;
    userDirs.enable = true;

    # yes its the same as the one in the nixos config, lets just be safe so nothing can break :)
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
      config = {
        kde.default = [ "kde" "gtk" "gnome" ];
        kde."org.freedesktop.portal.FileChooser" = [ "kde" ];
      };
    };
  };
}
