{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
      fira-code
      fira-code-symbols
  ];

  environment.systemPackages = with pkgs; [
    # dev
    gh
    pnpm
    yarn
    nodejs
    nodePackages.prettier
    pastel
    marksman
    pkgs.nixfmt-rfc-style
    pkgs.php83
    wget
    #pkgs.jetbrains.webstorm
    #pkgs.jetbrains.phpstorm
    #pkgs.jetbrains.rider
    #pkgs.jetbrains.clion
    #pkgs.jetbrains-toolbox
    #ungoogled-chromium
    #google-chrome

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
}