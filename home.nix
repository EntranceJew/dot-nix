{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.backupFileExtension=".hm-ej.backup";

  imports = [
    (import "${home-manager}/nixos")
  ];

  
  

  home-manager.users.ej = { config, pkgs, ... }: {
    imports = [
          ./programs/firefox.nix
    ];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
      };
    };
    home.file = {
    ".nv/nvidia-application-profiles-rc".text = ''
{
    "rules": [
        {
            "pattern": {
                "feature": "true",
                "matches": ""
            },
            "profile": "openGL_fix"
        }
    ],
    "profiles": [
        {
            "name": "openGL_fix",
            "settings": [
                {
                    "key": "GLThreadedOptimizations",
                    "value": false
                }
            ]
        }
    ]
}
    '';
  
  };



    programs.home-manager = {
      enable = true;
    };

    home.username = "ej";
    home.homeDirectory = "/home/ej";

    home.stateVersion = "24.11";

    /*
    home.packages = [
      
    ];
    */

    
  };

}
