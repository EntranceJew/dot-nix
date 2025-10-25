{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # media
    x265
    ffmpeg-full
    vlc
    mpvc
    tenacity
    yt-dlp
    kdePackages.kdenlive

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

  programs.mpv = {
    config = {
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
    ];
  };
}
