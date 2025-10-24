# Virtual Camera
{
  config,
  pkgs,
  ...
}: {
  # seems insanely unlikely that this would not already be on, but explicit is cool i guess
  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
}
