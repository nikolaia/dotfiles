{ self, nixpkgs, ... }:
{
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  programs.fish.enable = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (nixpkgs.lib.getName pkg) [
        "terraform"
      ];

    permittedInsecurePackages = [
      "dotnet-core-combined"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-7.0.410"
      "dotnet-sdk-wrapped-6.0.428"
    ];
  };
}
