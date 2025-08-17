{ config, pkgs, ... }:

{
  # wayland cope
  environment.variables.MOZ_ENABLE_WAYLAND = "1";
  # video?
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
        # regular human
        "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.";
        "network.dns.disableIPv6" = false;
        # video not shit?
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rrd-ffmpeg.enabled" = true;
        "media.av1.enabled" = true;
        "gfx.x11-egl.force-enabled" = true;
        "gfx.wayland-egl.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "webgl.disabled" = false;
        "cfg.pipewireSupport" = true;
        # the rest
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.cache" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "network.cookie.lifetimePolicy" = 0;
        # wayland cope
        "widget.wayland.opaque-region.enabled" = false;
      };
      ExtensionSettings = {
        # blocks all addons except the ones specified below
        "*".installation_mode = "blocked";
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
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
        "firefox@tampermonkey.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
          installation_mode = "force_installed";
        };
        "myallychou@gmail.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          installation_mode = "force_installed";
        };
        # "{38dc25f6-5ed7-4279-a1fb-832b5e90a98b}" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/tbl2csv/latest.xpi";
        #   installation_mode = "force_installed";
        # };
      };
    };
  };
}