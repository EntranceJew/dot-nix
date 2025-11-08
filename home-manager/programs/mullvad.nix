{
  config,
  pkgs,
  ...
}: {
  programs.mullvad-vpn = {
    enable = true;
  };
}
