{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    spicetify-nix= {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";

      # All overlays live in exactly one place. Every module (system or home)
      # that takes `pkgs` sees the same, fully-overlaid package set -- there is
      # no second "pkgs prime" floating around specialArgs to keep track of.
      overlays = [
        inputs.niri.overlays.niri
        inputs.nur.overlays.default
        inputs.nix-alien.overlays.default
        (final: prev: {
          xwayland-satellite = inputs.xwayland-satellite.packages.${system}.default;
          prismlauncher-unwrapped = prev.prismlauncher-unwrapped.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or [ ]) ++ [
              ./patches/prismlauncher-unwrapped.patch
            ];
          });
        })
      ];

      pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      impure-setup = pkgs.callPackage ./devshells/impure-setup.nix { };
    in
    {
      nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = overlays; }
          inputs.niri.nixosModules.niri
          ./hosts/hytkat
          ./modules/niri
        ];
      };
      homeConfigurations.hytkat = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          inputs.niri.homeModules.config
          inputs.dms.homeModules.niri
          inputs.dms.homeModules.dank-material-shell
          inputs.nix-flatpak.homeManagerModules.nix-flatpak

          inputs.spicetify-nix.homeManagerModules.spicetify

          ./home
        ];
      };

      packages.${system} = {
        inherit impure-setup;
      };

      # `nix develop` drops you into a shell with impure-setup on $PATH, so you
      # don't have to remember the `nix run .#impure-setup` incantation.
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [ impure-setup ];
      };

      # `nix fmt` formats the whole repo with nixfmt.
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
