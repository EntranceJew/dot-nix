{
  config,
  pkgs,
  ...
}: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;

    # left this commented out cos i dont want to poke holes in your system,
    # but I don't see why this would be off, and think it should be on
    # publish = {
    #   enable = true;
    #   userServices = true;
    # };
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
