{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
    home-manager,
    nixos-hardware,
    flake-utils,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (_: l: import ./lib.nix l);

    nixpkgsArgs = {
      config = {
        allowUnfree = true;
        pulseaudio = true;
        rocmSupport = true;
        cudaSupport = true;
      };
      overlays = builtins.attrValues self.overlays;
    };
    pkgsFor = system: import nixpkgs ({inherit system;} // nixpkgsArgs);
  in
    {
      overlays = {
        deploy-rs = deploy-rs.overlays.default;
        stuff = final: prev: {
          plasma-applet-resources-monitor = final.callPackage ./packages/plasma-applet-resources-monitor.nix {};

          mpv-unwrapped = prev.mpv-unwrapped.override {
            ffmpeg = final.ffmpeg-full;
          };

          xsane = prev.xsane.override {gimpSupport = true;};
        };
      };

      nixosConfigurations.COIN = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs lib;
          # pkgs = pkgsFor "x86_64-linux";
        };
        modules = [
          nixpkgs.nixosModules.readOnlyPkgs
          {nixpkgs.pkgs = pkgsFor "x86_64-linux";}
          ./configuration.nix
        ];
      };

      homeManagerConfigurations.COIN.ej = home-manager.lib.homeManagerConfiguration rec {
        pkgs = pkgsFor "x86_64-linux";
        extraSpecialArgs = {
          inherit inputs pkgs;
          lib = lib.extend (_: _: {hm = home-manager.lib.hm;});
        };
        modules = [
          ./home-manager/configuration.nix
        ];
      };

      deploy.nodes.COIN = {
        hostname = "localhost";
        fastConnection = true;
        magicRollback = false;
        autoRollback = false;
        profiles = {
          system = {
            user = "root";
            path =
              (pkgsFor "x86_64-linux").deploy-rs.lib.activate.nixos
              self.nixosConfigurations.COIN;
          };
          home-manager-ej = {
            user = "ej";
            profilePath = "/home/ej/.local/state/nix/profiles/home-manager";
            path =
              (pkgsFor "x86_64-linux").deploy-rs.lib.activate.home-manager
              self.homeManagerConfigurations.COIN.ej;
          };
        };
      };

      checks =
        builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy)
        deploy-rs.lib;
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = pkgsFor system;
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [pkgs.deploy-rs.deploy-rs];
      };
    });
}
