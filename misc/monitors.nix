{
  config,
  pkgs,
  ...
}:
# What the FUCK is any of this shit. I refuse to believe this is needed for ANYTHING
{
  hardware.display = {
    edid = {
      enable = true;
      linuxhw = {
        DELL_U2722D_2021 = ["U2722D" "2021" "0A141DE5419E"];
      };
    };

    # outputs = {
    #   "Dell Inc. DELL U2722D FWG43P3" = {
    #     pos = "2560 0";
    #     mode = "2560x1440-24@60eD";
    #     edid = "DELL_U2722D_2021.bin";
    #   };
    #   "Dell Inc. DELL U2722D 8VL24P3" = {
    #     pos = "2560 1440";
    #     mode = "2560x1440-24@60eD";
    #     edid = "DELL_U2722D_2021.bin";
    #   };
    #   "Dell Inc. DELL U2722D 714J7P3" = {
    #     pos = "0 0";
    #     mode = "2560x1440-24@60eD";
    #     edid = "DELL_U2722D_2021.bin";
    #   };
    #   "Dell Inc. DELL U2722D CGF55P3" = {
    #     pos = "0 1440";
    #     mode = "2560x1440-24@60eD";
    #     edid = "DELL_U2722D_2021.bin";
    #   };
    # };
  };
}
