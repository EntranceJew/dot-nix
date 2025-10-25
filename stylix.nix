home: {
  config,
  lib,
  pkgs,
  ...
}: {
  stylix =
    {
      enable = true;
      autoEnable = true;


      overlays.enable = false;
      polarity = "dark";

      image = ./wallpaper.jpg;
      imageScalingMode = "stretch";

      fonts = {
        monospace = {
          # name = "FiraCode Regular Symbol";
          # package = pkgs.fira-code-symbols;
          name = "FiraCode VF";
          package = pkgs.fira-code;
        };

        # sizes = lib.genAttrs ["applications" "desktop" "popups" "terminal"] (_: 11);
      };

      # base16Scheme = {
      #   base00 = "282936";
      #   base01 = "3a3c4e";
      #   base02 = "4d4f68";
      #   base03 = "626483";
      #   base04 = "62d6e8";
      #   base05 = "e9e9f4";
      #   base06 = "f1f2f8";
      #   base07 = "f7f7fb";
      #   base08 = "ea51b2";
      #   base09 = "b45bcf";
      #   base0A = "00f769";
      #   base0B = "ebff87";
      #   base0C = "a1efe4";
      #   base0D = "62d6e8";
      #   base0E = "b45bcf";
      #   base0F = "00f769";
      # };

      icons = {
        enable = true;
        dark = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };

      # opacity = {
      #   terminal = 0.85;
      #   popups = 0.7;
      #   desktop = 0.6;
      #   applications = 0.85;
      # };
    }
    // (
      if home
      then {
        targets.librewolf = {
          # colorTheme.enable = true;
          # firefoxGnomeTheme.enable = true; # its not bad looking, and doesn't need/use gnome. try turning it on some day :)
          profileNames = ["default"];
        };
      }
      else {}
    );
}
