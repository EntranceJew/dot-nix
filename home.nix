{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.backupFileExtension="backup";

  home-manager.users.ej = { pkgs, ... }: {
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
#     home.file = {
#     ".nv/nvidia-application-profiles-rc".text = ''
# {
#     "rules": [
#         {
#             "pattern": {
#                 "feature": "dso",
#                 "matches": "libGL.so.1"
#             },
#             "profile": "openGL_fix"
#         }
#     ],
#     "profiles": [
#         {
#             "name": "openGL_fix",
#             "settings": [
#                 {
#                     "key": "GLThreadedOptimizations",
#                     "value": false
#                 }
#             ]
#         }
#     ]
# }
#     '';
#   };

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
