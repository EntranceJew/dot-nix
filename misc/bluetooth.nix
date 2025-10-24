{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    settings.General.enable = "Source,Sink,Media,Socket";
  };
}
