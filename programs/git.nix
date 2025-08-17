{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   git
  #   git-lfs
  #   git-filter-repo
  # ];
}