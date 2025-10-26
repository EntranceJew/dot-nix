{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth.settings.General.enable = "Source,Sink,Media,Socket";
}
