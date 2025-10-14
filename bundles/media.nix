{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # media
    x265
    ffmpeg-full
    vlc
    mpvc
    tenacity
    yt-dlp
    kdePackages.kdenlive
    (mpv.override { scripts = [mpvScripts.mpris];})

    # music
    vcv-rack
    bespokesynth

    # note: need these for flstudio
    winetricks
    wineWowPackages.stable
    #wineWowPackages.waylandFull
    # note: need this for stage lights
    #qlcplus
  ];
}