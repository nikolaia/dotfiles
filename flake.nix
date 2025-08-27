{
  description = "Home Manager Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      darwinConfiguration = import ./darwin-configuration.nix {
        inherit self nixpkgs;
      };
    in
    {
      homeConfigurations = {
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              permittedInsecurePackages = [
                "dotnet-core-combined"
                "dotnet-sdk-6.0.428"
                "dotnet-sdk-7.0.410"
                "dotnet-sdk-wrapped-6.0.428"
              ];
            };
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
          ];
        };
      };

      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          darwinConfiguration
          home-manager.darwinModules.home-manager
          { nixpkgs.overlays = import ./overlays; }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              users.nikolaia = import ./home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
          { users.users.nikolaia.home = "/Users/nikolaia"; }
        ];
      };
      darwinPackages = self.darwinConfigurations.macbook.pkgs;
    };
}
