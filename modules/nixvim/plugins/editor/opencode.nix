{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.opencode-nvim
  ];
  keymaps = [
    {
      key = "<leader>oA";
      action = "<cmd>lua require('opencode').ask()<CR>";
      options = {
        desc = "Ask opencode";
      };
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask('@cursor: ')<CR>";
      options = {
        desc = "Ask opencode about this";
      };
      mode = "n";
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask('@selection: ')<CR>";
      options = {
        desc = "Ask opencode about selection";
      };
      mode = "v";
    }
    {
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<CR>";
      options = {
        desc = "Toggle embedded opencode";
      };
    }
    {
      key = "<leader>on";
      action = "<cmd>lua require('opencode').command('session_new')<CR>";
      options = {
        desc = "New session";
      };
    }
    {
      key = "<leader>oy";
      action = "<cmd>lua require('opencode').command('messages_copy')<CR>";
      options = {
        desc = "Copy last message";
      };
    }
    {
      key = "<S-C-u>";
      action = "<cmd>lua require('opencode').command('messages_half_page_up')<CR>";
      options = {
        desc = "Scroll messages up";
      };
    }
    {
      key = "<S-C-d>";
      action = "<cmd>lua require('opencode').command('messages_half_page_down')<CR>";
      options = {
        desc = "Scroll messages down";
      };
    }
    {
      key = "<leader>op";
      action = "<cmd>lua require('opencode').select_prompt()<CR>";
      options = {
        desc = "Select prompt";
      };
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>oe";
      action = "<cmd>lua require('opencode').prompt('Explain @cursor and its context')<CR>";
      options = {
        desc = "Explain code near cursor";
      };
    }
  ];
}
