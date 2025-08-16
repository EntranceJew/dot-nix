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

    # services.flameshot = {
    #   enable = true;
    #   package = pkgs.flameshot.override { enableWlrSupport = true; };
    #   settings.General.disabledGrimWarning = true;
    # };  

    programs.librewolf = {
      enable = true;
      # Enable WebGL, cookies and history
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.cache" = false;
        # "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.";
        "network.cookie.lifetimePolicy" = 0;
        "cfg.pipewireSupport" = true;
        "network.dns.disableIPv6" = false;
      };
    };
  };
}
