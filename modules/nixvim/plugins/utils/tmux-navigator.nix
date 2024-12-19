_: {
  plugins.tmux-navigator = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<c-h>";
      action = "<cmd><C-U>TmuxNavigateLeft<cr>";
      options = {
        desc = "Navigate Left";
      };
    }
    {
      mode = "n";
      key = "<c-j>";
      action = "<cmd><C-U>TmuxNavigateDown<cr>";
      options = {
        desc = "Navigate Down";
      };
    }
    {
      mode = "n";
      key = "<c-k>";
      action = "<cmd><C-U>TmuxNavigateUp<cr>";
      options = {
        desc = "Navigate Up";
      };
    }
    {
      mode = "n";
      key = "<c-l>";
      action = "<cmd><C-U>TmuxNavigateRight<cr>";
      options = {
        desc = "Navigate Right";
      };
    }
    {
      mode = "n";
      key = "<c-\\>";
      action = "<cmd><C-U>TmuxNavigatePrevious<cr>";
      options = {
        desc = "Navigate Previous";
      };
    }
  ];
}
