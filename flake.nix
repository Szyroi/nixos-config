{
  description = "NixOS with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "szyroi";

    # Gemeinsame SpecialArgs für beide Konfigurationen
    specialArgs = {inherit inputs system username;};

    # NixOS Defaults
    nixDefaultsModule = {pkgs, ...}: {
      nixpkgs.config.allowUnfree = true;
    };

    homeManagerConfiguration = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = specialArgs;
      modules = [
        # Home-Manager spezifische Module
        inputs.nixvim.homeModules.nixvim
        inputs.stylix.homeModules.stylix
        inputs.sops-nix.homeModules.sops

        ./home/user.nix
      ];
    };
  in {
    # NixOS Konfigurationen
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = [
          nixDefaultsModule
          ./hosts/desktop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.${username} = import ./home/user.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.sharedModules = [
              inputs.nixvim.homeModules.nixvim
              inputs.stylix.homeModules.stylix
              inputs.sops-nix.homeModules.sops
            ];
          }
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = [
          nixDefaultsModule
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.${username} = import ./home/user.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };

    homeConfigurations = {
      ${username} = homeManagerConfiguration;
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
