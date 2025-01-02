_: {

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    imports = [
      # General Configuration
      ./settings.nix
      ./keymaps.nix
      ./auto_cmds.nix
      ./file_types.nix

      # Themes
      ./plugins/themes/default.nix

      # Completion
      ./plugins/cmp/cmp.nix
      ./plugins/cmp/cmp-ai.nix
      ./plugins/cmp/lspkind.nix
      ./plugins/cmp/autopairs.nix

      # Snippets
      ./plugins/snippets/luasnip.nix

      # Editor plugins and configurations
      ./plugins/editor/neo-tree.nix
      ./plugins/editor/treesitter.nix
      ./plugins/editor/undotree.nix
      ./plugins/editor/illuminate.nix
      ./plugins/editor/indent-blankline.nix
      ./plugins/editor/todo-comments.nix
      ./plugins/editor/copilot-chat.nix
      ./plugins/editor/navic.nix
      ./plugins/editor/trouble.nix

      # UI plugins
      ./plugins/ui/webdevicons.nix
      ./plugins/ui/bufferline.nix
      ./plugins/ui/lualine.nix
      ./plugins/ui/startup.nix

      # LSP and formatting
      ./plugins/lsp/lsp.nix
      ./plugins/lsp/conform.nix
      ./plugins/lsp/fidget.nix

      # Git
      ./plugins/git/lazygit.nix
      ./plugins/git/gitsigns.nix

      # Utils
      ./plugins/utils/telescope.nix
      ./plugins/utils/whichkey.nix
      ./plugins/utils/extra_plugins.nix
      ./plugins/utils/mini.nix
      ./plugins/utils/markdown-preview.nix
      ./plugins/utils/obsidian.nix
      ./plugins/utils/tmux-navigator.nix
    ];
  };
}
