{
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    terminal = "xterm-256color";
    baseIndex = 1;
    escapeTime = 5;
    clock24 = true;
    keyMode = "vi";
    prefix = "C-a";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.catppuccin;
        # TODO: modules "host date_time" etc is slow on WSL2
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_status_modules_right "application user session host date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
        '';
      }
    ];
    extraConfig = ''
      set -g default-command ${pkgs.fish}/bin/fish
      set -g default-shell ${pkgs.fish}/bin/fish
      # This requires OSC 52 support in the terminal, which Alacritty has.
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "tmux load-buffer -w && tmux paste-buffer -p"
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = lib.mkMerge [
    {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
      #
      ".gitignore_global".text = ''
        .DS_Store
        .idea/
      '';
      ".ideavimrc".text = ''
        let mapleader=" "
        vmap <Leader>y "+y
        vmap <Leader>d "+d
        vmap <Leader>p "+p
        vmap <Leader>P "+P
        nmap <Leader>p "+p
        nmap <Leader>P "+P
      '';
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
}
