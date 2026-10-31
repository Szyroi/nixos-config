{
  description = "NixOS with Home Manager & Multi-Device Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qylock = {
      url = "github:Darkkal44/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixland = {
      url = "github:Szyroi/nixland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "szyroi";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    nixDefaultsModule = {
      nixpkgs.config.allowUnfree = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    mkHost = {
      host,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs username;
          hostname = host;
        };

        modules =
          [
            nixDefaultsModule
            inputs.qylock.nixosModules.default
            inputs.stylix.nixosModules.stylix
            ./hosts/${host}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";

                users.${username} = import ./users/${username};

                extraSpecialArgs = {
                  inherit inputs username;
                  hostname = host;
                };

                sharedModules = [
                  inputs.sops-nix.homeModules.sops
                  inputs.nixland.homeManagerModules.default
                ];
              };
            }
          ]
          ++ extraModules;
      };
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system} = {
      default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nixd
          alejandra
          statix
          deadnix
        ];
      };

      latex = import ./devshells/latex.nix {
        inherit pkgs;
      };

      python = import ./devshells/python.nix {
        inherit pkgs;
      };
    };

    templates = {
      default = self.templates.latex;

      latex = {
        path = ./templates/latex;
        description = "LaTeX project with Zed, texlab and Zathura";
      };

      python = {
        path = ./templates/python;
        description = "Python project with uv, Ruff and ty";
      };
    };

    nixosConfigurations = {
      desktop = mkHost {
        host = "desktop";
      };

      hp-laptop = mkHost {
        host = "hp-laptop";
      };

      framework-laptop = mkHost {
        host = "framework-laptop";
        extraModules = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };
  };
}
