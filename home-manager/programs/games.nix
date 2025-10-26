{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pkgs.gamemode
    pkgs.prismlauncher
    # pkgs.pcsx2
    pkgs.ares
  ];
}
