{config, pkgs, lib, ...}:

{
  hardware.sane.enable = true;
  users.users.ej.extraGroups = [ "scanner" "lp" ];
  services.ipp-usb.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.skanlite
    (pkgs.xsane.override { gimpSupport = true; })
  ];
}