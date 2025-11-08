{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General.enable = "Source,Sink,Media,Socket";
}
