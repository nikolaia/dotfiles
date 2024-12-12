# Dotfiles

## nix and home-manager

After installing nix, remember to put the following in ~/.config/nix/nix.conf: `experimental-features = nix-command flakes`

```bash
# First time to install nix-darwin:
nix run nix-darwin -- switch --flake .#macbook
# Then use
darwin-rebuild build --flake .#macbook

# First time to install home-manager:
nix run .#homeConfigurations.<configuration>.activationPackage
# Then use
home-manager switch --flake .#wsl
```

After this home-manager is installed and I can use `home-manager switch --flake ~/dev/dotfiles/nix/#default` (or darwin-rebuild).

If it complains about cache when testing new stuff you can add `--option eval-cache false`.

Cleanup: `nix-collect-garbage -d` or `nix-collect-garbage --delete-older-than 7d`

Update: `nix flake update` - prepare for things to fix...

for csharp ls: `dotnet tool install --global csharp-ls fsautocomplete`

## Ubuntu

TODO: Move dconf and some packages from home.nix to its own configuration. They are disabled/commented out for now.

## Windows and WSL

I use [Scoop](https://scoop.sh) as my package manager outside WSL and just install the same packages as in home.nix. Remember to add .wslconfig to home folder for WSL.

TODO: Add /etc/wsl.conf to the setup:

```toml
[boot]
systemd=true

[interop]
appendWindowsPath=false # If not fish will be super slow
```
