{ config, pkgs, ... }:

{
  hardware.display = {
    edid = {
      enable = true;
      linuxhw = {
        DELL_U2722D_2021 = [ "U2722D" "2021" "0A141DE5419E" ];
      };
    };

    # I don't know where "DP-1" is
    # outputs = {
    #   "DP-2" = {
    #     edid = "DELL_U2722D_2021.bin";
    #     # mode = "2560x1440-24@60eD";
    #     mode = "1920x1080-24@60e";
    #   };
    #   "DP-3" = {
    #     edid = "DELL_U2722D_2021.bin";
    #     # mode = "2560x1440-24@60eD";
    #     mode = "1920x1080-24@60e";
    #   };
    #   "DP-4" = {
    #     edid = "DELL_U2722D_2021.bin";
    #     # mode = "2560x1440-24@60eD";
    #     mode = "1920x1080-24@60e";
    #   };
    #   "DP-5" = {
    #     edid = "DELL_U2722D_2021.bin";
    #     # mode = "2560x1440-24@60eD";
    #     mode = "1920x1080-24@60e";
    #   };
    # };
  };
}