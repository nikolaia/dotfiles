{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    terminal = "tmux-256color";
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

}
