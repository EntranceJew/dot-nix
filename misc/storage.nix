{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    # files
    cifs-utils
    gparted
    kdePackages.partitionmanager
    kdePackages.filelight
    grsync
    dupeguru
  ];
}