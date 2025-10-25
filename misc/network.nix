{
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "COIN";
    networkmanager.enable = true;
  };

  services = {
    # just makes dns like a lot better lol
    resolved.enable = true;
  };
}
