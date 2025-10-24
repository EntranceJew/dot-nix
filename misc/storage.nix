{
  config,
  pkgs,
  ...
}: let
  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  syno_secret = "/etc/nixos/secrets/smb_synology";
  kunlan_secret = "/etc/nixos/secrets/smb_kunlan";
in {
  boot.supportedFilesystems = ["ntfs"];

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

  # filesystems
  fileSystems."/" = {
    device = "/dev/disk/by-partuuid/aa3aeb96-8c53-49d0-b6f6-98a598390f99";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B44A-9200";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/mnt/PD" = {
    device = "//nas-kunlan.local/Personal-Drive";
    fsType = "cifs";
    options = ["${automount_opts},credentials=${kunlan_secret},rw,uid=1000"];
  };

  fileSystems."/mnt/Share" = {
    device = "//hbdltnasdaq.local/Share";
    fsType = "cifs";
    options = ["${automount_opts},credentials=${syno_secret},rw,uid=1000"];
  };

  fileSystems."/mnt/Zumgo" = {
    device = "//hbdltnasdaq.local/Zumgo";
    fsType = "cifs";
    options = ["${automount_opts},credentials=${syno_secret},rw,uid=1000"];
  };

  fileSystems."/mnt/mintman" = {
    device = "//hbdltnasdaq.local/mintman";
    fsType = "cifs";
    options = ["${automount_opts},credentials=${syno_secret},rw,uid=1000"];
  };

  # fileSystems."/mnt/UNAS" =
  #   { device = "//nas-kunlan.lan/";
  #     fsType = "cifs";
  #     options = ["${automount_opts},credentials=${kunlan_secret},rw,uid=1000"];
  #   };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/01DB8F2FB709A8A0";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  fileSystems."/mnt/dmz" = {
    device = "/dev/disk/by-uuid/413FC4F423B49867";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };
}
