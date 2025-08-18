{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # media
    ffmpeg
    vlc
    mpvc
    tenacity
    yt-dlp
    kdePackages.kdenlive

    # note: need these for flstudio
    winetricks
    wineWowPackages.stable
    #wineWowPackages.waylandFull
    # note: need this for stage lights
    #qlcplus
  ];
}