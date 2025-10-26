{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fira-code
    fira-code-symbols

    # dev
    # utils
    wget
    # package management
    pnpm
    yarn
    # runtimes
    nodejs # cringe
    pkgs.php83
    pkgs.python315
    # what
    gh
    # hex
    helix
    imhex
    # gamedev
    godotPackages_4_3.godot-mono
    # godotPackages_4_3.export-templates-mono-bin
    # godotPackages_4_3.export-templates-bin
    godotPackages_4_3.export-template-mono
    godotPackages_4_3.export-template
    # highlighters
    pastel
    nodePackages.prettier
    marksman
    mw
    pkgs.nixfmt-rfc-style
    vscode-langservers-extracted
    # ides
    pkgs.jetbrains.webstorm
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.rider
    pkgs.jetbrains.clion
    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains-toolbox
    (ungoogled-chromium.override {
      commandLineArgs = [
        # please for the love of god just disable all these stupid flags.
        # you don't need any of them. but I'm leaving them just in case

        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
        # "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecoder,AcceleratedVideoDecode,AcceleratedVideoDecodeLinux,UseChromeOSDirectVideoDecoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,VaapiVideoDecoder,VaapiVideoEncoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
        "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL"
        "--disable-features=UseSkiaRenderer,UseChromeOSDirectVideoDecoder"
        # "--enable-features=,,,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,,,,,,"
      ];
    })
    #google-chrome

    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions;
        [
          jnoortheen.nix-ide
          foxundermoon.shell-format
          # samual.hackmud-color
          esbenp.prettier-vscode
          usernamehw.errorlens
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
}
