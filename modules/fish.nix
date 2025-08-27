{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "lsd -la";
      dcomp = "docker compose";
      terraform = "tofu";
    };
    interactiveShellInit = ''
      # function fish_greeting
      # end
      # fish_update_completions
      export VISUAL=nvim
      export EDITOR="$VISUAL"
      function fish_user_key_bindings
        fish_vi_key_bindings
      end
      set -g fish_escape_delay_ms 10

      fish_add_path ~/.dotnet/tools

      if test -x /opt/homebrew/bin/brew
          eval "$(/opt/homebrew/bin/brew shellenv)"
      end

      if test -x "~/.nix-profile/bin/colima"
        eval "$(colima completion fish)"
      end
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

}
