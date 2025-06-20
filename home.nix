{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/alacritty.nix
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/k9s.nix
    ./modules/keychain.nix
    ./modules/tmux.nix
    ./modules/nixvim
  ];

  home.username = "nikolaia";
  home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/nikolaia";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gcc13
    grc
    curl
    jq
    lazydocker
    lazygit
    azure-cli
    azure-functions-core-tools
    mkcert
    docker
    kubectl
    kubectx
    kubecm
    ffmpeg
    gnupg
    nodejs_20
    terraform
    s3cmd
    mob
    gh
    git-extras
    htop
    html-tidy
    sops
    lsd
    neofetch
    colima
    kind
    ripgrep
    fzf
    nssTools
    yarn
    kompose
    google-cloud-sdk

    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
    fsautocomplete
    fantomas

    kind
    cocogitto
    oci-cli
    ollama
    fd

    jdk
    gradle
    kotlin
    ktlint

    # TODO: Move to WSL-specific configuration
    #wsl-open

    # TODO: Move to GNOME specific configuration
    #evolution
    #evolution-ews
    #gnomeExtensions.tiling-assistant

    nerd-fonts.jetbrains-mono
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 0;
  };

  # TODO: Move to GNOME specific configuration
  dconf.enable = false;
  dconf.settings = {
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = lib.mkMerge [
    {
      ".gitignore_global".text = ''
        .DS_Store
        .idea/
      '';
      ".ideavimrc".source = dotfiles/.ideavimrc;
    }

    (lib.mkIf isDarwin {
      "Library/KeyBindings/DefaultKeyBinding.dict".text = ''
        {
            /* Remap Home key to move to beginning of line */
            "\UF729" = "moveToBeginningOfLine:";

            /* Remap End key to move to end of line */
            "\UF72B" = "moveToEndOfLine:";
        }
      '';
      ".testcontainers.properties".text = ''
        docker.socket.override=/var/run/docker.sock
        docker.host=unix:///${config.home.homeDirectory}/.colima/default/docker.sock
      '';
    })
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
