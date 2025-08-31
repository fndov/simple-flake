{
  description = "non-complex flake with home-manager";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ ... }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.home = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./hardware.nix
        ./configuration.nix
        ./home.nix
      ];
    };
  };
}
