{ config, pkgs, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      pkgs.brlaser
      # pkgs.brgenml1lpr
      # pkgs.brgenml1cupswrapper
    ];
  };

  environment.systemPackages = with pkgs; [
    lprint # not actually using this but why not
    ptouch-print
  ];
}