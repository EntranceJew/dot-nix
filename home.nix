{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.ej = { pkgs, ... }: {
    home.username = "ej";
    home.homeDirectory = "/home/ej";

    home.stateVersion = "24.11";

    programs.home-manager.enable = true;

    /*
    home.packages = [
      
    ];
    */

    
  };
}
