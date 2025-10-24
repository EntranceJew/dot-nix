{
  config,
  pkgs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.keepassxc
    ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        # regular human
        # "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.";
        # "general.useragent.compatMode.firefox" = true;
        # "network.dns.disableIPv6" = false;
        # video not shit?
        "gfx.webrender.all" = true;
        # "gfx.webrender.compositor" = true;
        # "gfx.webrender.compositor.force-enabled" = true;
        # "dom.webgpu.enabled" = true;
        # "layers.gpu-process.enabled" = true;
        # "layers.mlgpu.enabled" = true;
        # "layers.acceleration.force-enabled" = true;
        # "layers.offmainthreadcomposition.enabled" = true;
        # "media.gpu-process-decoder" = true;
        # "media.ffmpeg.vaapi.enabled" = true;
        # "media.rrd-ffmpeg.enabled" = true;
        # "media.av1.enabled" = true;
        # "gfx.x11-egl.force-enabled" = true;
        # "widget.dmabuf.force-enabled" = true;
        # "media.hardware-video-decoding.force-enabled" = true;
        # "webgl.disabled" = false;
        # "cfg.pipewireSupport" = true;
        # "dom.media.webcodecs.h265.enabled" = true;
        # "media.hls.enabled" = true;
        # "media.hevc.enabled" = true;
        # disable some privacy
        "privacy.resistFingerprinting" = false;

        "browser.startup.homepage" = "https://zombo.com";

        # # UNCOMMENT THIS TO STOP CLICKING CAPTCHAS AND BE ALLOWED TO SEARCH ON LOWES DOT COM
        # "general.useragent.override" = "Mozilla/5.0 (X11; Linux x86_64; rv:143.0) Gecko/20100101 Firefox/143.0";

        # the rest

        ### setting these is fucking broken despite there being no reasonable reason why
        ## "cookiebanners.service.mode.privateBrowsing" = 2;
        ## "cookiebanners.service.mode" = 2;
        ### this one is especialy broken no matter what value you pick the config explodes
        ## "network.cookie.lifetimePolicy" = 0;

        # nuke annoying shit
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        # re-enable the settings for session keeping
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.siteSettings" = false;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.cache" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.cookies" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.history" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.sessions" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.siteSettings" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.cache" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.siteSettings" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
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
        "fox@replace.fx" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxreplace/latest.xpi";
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
