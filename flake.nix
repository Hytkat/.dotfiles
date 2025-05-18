{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    style.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos
        ];
      };
      homeConfigurations.hytkat = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nix-flatpak.homeManagerModules.nix-flatpak
          ./home
        ];
      };
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          /home/config.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
}
