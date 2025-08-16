# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://channels.nixos.org/nixos-25.05";
  };

  # Virtual Camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  networking.hostName = "COIN"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  powerManagement.enable = false;

  # magic:
  environment.variables = {
    QT_QPA_PLATFORM = "wayland-egl;xcb";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    ENCORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # nixpkgs.config.cudaSupport = true;

  # *** nvidia ***
  # Wayland
  hardware.graphics.extraPackages = [
    pkgs.nvidia-vaapi-driver
  ];

  environment.variables = {
    NVD_BACKEND = "direct";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";

    # NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };
  # Other
  services.xserver.videoDrivers = [ "nvidia" ];
  boot = {
    initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    kernelParams = [ "nvidia-drm.fbdev=1" ];
  };
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # extraPackages = with pkgs; [
    #   # nvidia-vaapi-driver
    # ];
  };
  # *** /nvidia ***

  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.keyboard.zsa.enable = true;

  # Enable the KDE Plasma Desktop Environment.


  # Configure keymap in X11


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;


  # Horrible
  # services.printing.enable = true;


  # Enable touchpadc support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ej = {
    isNormalUser = true;
    description = "ej";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      libva-utils
      # music:
      # wineWowPackages.stable
      # support both 32-bit and 64-bit applications
      wineWowPackages.stable

      # winetricks (all versions)
      winetricks
      kdePackages.kdenlive
      # native wayland support (unstable)
      # wineWowPackages.waylandFull
      # wineWowPackages.waylandFull
      # google-chrome
      pkgs.php83
      # pkgs.jetbrains.webstorm
      # pkgs.jetbrains.phpstorm
      # pkgs.jetbrains.rider
      # pkgs.jetbrains.clion
      # pkgs.jetbrains-toolbox
      kdePackages.filelight
      # ungoogled-chromium
      kdePackages.kate
      kdePackages.krdp
      freerdp
      pkgs.nixfmt-rfc-style
      freerdp3
      pkgs.librewolf
      keymapp
      wlrctl
      dotool
      xdotool
      ydotool
      kdotool
      wmctrl
      keepassxc
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      tigervnc
      discord
      kdePackages.spectacle
      gimp
      vlc
      mpvc
      ffmpeg
      tenacity
      yt-dlp
      obsidian
      libreoffice
      qlcplus
      aircrack-ng
      airgorah
      grsync
      pastel
      dupeguru
      scrcpy
      gnirehtet
      prismlauncher
      amarok
      marksman
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
          foxundermoon.shell-format
          # samual.hackmud-color
          esbenp.prettier-vscode
          usernamehw.errorlens
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "markwhen";
            publisher = "Markwhen";
            version = "1.4.4";
            sha256 = "r8WqTj+MFTkq34+A4LvinCJN3c6AY0z2RxMT+4rnZvs=";
          }
          {
           name = "hackmud-color";
           publisher = "Samual";
           version = "0.5.0";
           sha256 = "ucSv7KTTXxaf2iYgZ+V69BsjV009vxDzk0BGlh3vGig=";
          }
        ];
      })
    ];
  };

  programs.obs-studio = {
    enable = true;
    
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  ## what
  # xdg.portal = {
  #   enable = true;
  #   wlr = {
  #     enable = true;
  #     settings = {
  #       screencast = {
  #         max_fps = 55;
  #         chooser_type = "simple";
  #         chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #       };
  #     };
  #   };
  #   config = {
  #     wlroots.default = ["wlr" "gtk"];
  #     common.default = ["gtk"];
  #   };
  # };

  # Enable automatic login for the user.
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Install firefox.
  environment.variables.MOZ_DISABLE_RDD_SANDBOX = "1";
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf.override {
      cfg.pipewireSupport = true;
      cfg.ffmpegSupport = true;
    };
    nativeMessagingHosts.packages = [
      pkgs.keepassxc
    ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        # video not shit?
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rrd-ffmpeg.enabled" = true;
        "media.av1.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        # the rest
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "widget.wayland.opaque-region.enabled" = false;
        "media.hardware-video-decoding.force-enabled" = true;
      };
      ExtensionSettings = {
        # blocks all addons except the ones specified below
        "*".installation_mode = "blocked";
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "keepassxc-browser@keepassxc.org" = {/*  */
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
        };
        "myallychou@gmail.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "tab-stash@condordes.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-stash/latest.xpi";
          installation_mode = "force_installed";
        };
        "{38dc25f6-5ed7-4279-a1fb-832b5e90a98b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tbl2csv/latest.xpi";
          installation_mode = "force_installed";
        };
        "firefox@tampermonkey.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.java.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  fonts.packages = with pkgs; [
#     noto-fonts
#     noto-fonts-cjk-sans
#     noto-fonts-emoji
#     liberation_ttf
    fira-code
    fira-code-symbols
#     mplus-outline-fonts.githubRelease
#     dina-font
#     proggyfonts
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.gamescope
    pkgs.gamemode
    cifs-utils
    gparted
    kdePackages.partitionmanager
    pnpm
    yarn
    nodejs
    nodePackages.prettier
    gh
    git
    git-lfs
    git-filter-repo
    wget
    alsa-scarlett-gui
  ];

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   spectacle
  # ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.xrdp = {
    enable = true;
    defaultWindowManager = "startplasma-wayland";
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ej";
    services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.xserver = {
    enable = false;
    xkb = {
      layout = "us";
      variant = "";
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
