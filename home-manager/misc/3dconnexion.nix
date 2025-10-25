{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    spacenavd
    libspnav
  ];
}
