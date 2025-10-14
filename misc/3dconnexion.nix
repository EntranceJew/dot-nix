{config, pkgs, lib, ...}:

{
    environment.systemPackages = with pkgs; [
      spacenavd
      libspnav
    ];
}