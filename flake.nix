{
  description = "rainyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixago = {
      url = "github:jmgilman/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    proton-cachyos.url = "github:powerofthe69/proton-cachyos-nix";

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-rocksmith = {
      url = "github:re1n0/nixos-rocksmith";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-gaming.follows = "nix-gaming";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      makeConfiguration =
        host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              inputs
              host
              system
              ;
          };
          modules = [
            ./hosts/${host}

            inputs.disko.nixosModules.disko
            inputs.nixos-facter-modules.nixosModules.facter
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-rocksmith.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.lanzaboote.nixosModules.lanzaboote
          ];
        };
    in
    {
      packages.x86_64-linux.default = self.nixosConfigurations.thome.config.system.build.isoImage;
      nixosConfigurations = {
        sedna = makeConfiguration "sedna" "x86_64-linux";
        iris = makeConfiguration "iris" "x86_64-linux";
        thome = makeConfiguration "thome" "x86_64-linux";
      };
    };
}
