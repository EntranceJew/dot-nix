{config,pkgs,lib, ...}:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
  };
  hardware.enableAllFirmware = true;
}