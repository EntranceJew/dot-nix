{ config, pkgs, ... }:

{
  # home-manager.users.ej = { pkgs, ... }: {
  # programs.librewolf = {
  #   enable = true;
  #   # Enable WebGL, cookies and history
  #   settings = {
  #     "webgl.disabled" = false;
  #     "privacy.resistFingerprinting" = false;
  #     "privacy.clearOnShutdown.history" = false;
  #     "privacy.clearOnShutdown.cookies" = false;
  #     "privacy.clearOnShutdown.sessions" = false;
  #     "privacy.clearOnShutdown.cache" = false;
  #     # "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.";
  #     "network.cookie.lifetimePolicy" = 0;
  #     "cfg.pipewireSupport" = true;
  #     "network.dns.disableIPv6" = false;
  #   };
  # };
  # }

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
}