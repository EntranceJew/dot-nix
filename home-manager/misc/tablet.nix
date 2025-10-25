{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # files
    opentabletdriver
    inkscape
    krita
    gimp
  ];
}
