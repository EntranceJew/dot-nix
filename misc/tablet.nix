{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # files
    opentabletdriver
    inkscape
    krita
    gimp
  ];
}