{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    style.url = "github:danth/stylix";
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
    dcachix = {
      url = "github:debarchito/dcachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        xwayland-satellite = inputs.xwayland-satellite.packages.${system}.default;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlay = [
          inputs.niri.overlays.niri
          inputs.dcachix.overlays.default
          overlay
        ];
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.niri.nixosModules.niri
          ./hosts/hytkat
          ./modules/niri
        ];
      };
      homeConfigurations.hytkat = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.niri.homeModules.config
          inputs.dms.homeModules.niri
          inputs.dms.homeModules.dank-material-shell
          nix-flatpak.homeManagerModules.nix-flatpak
          ./home
        ];
      };
    };
}
