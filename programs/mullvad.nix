{
  config,
  pkgs,
  ...
}: {
  # If there's no reason to use this over home-manager's `programs.mullvad-vpn` maybe switch to that??
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
