{
  config,
  pkgs,
  ...
}: {
  hardware.flipperzero.enable = true;

  # Supporting Packages
  environment.systemPackages = with pkgs; [
    pkgs.qFlipper
  ];
}
