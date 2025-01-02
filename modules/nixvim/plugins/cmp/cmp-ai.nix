{
  # Your existing copilot config
  plugins.copilot-cmp = {
    enable = true;
  };
  plugins.copilot-lua = {
    enable = true;
    suggestion = {
      enabled = false;
    };
    panel = {
      enabled = false;
    };
  };

  plugins.ollama = {
    enable = true;
    model = "codellama:13b-code";
    action = "display";
  };

  plugins.cmp-ai = {
    enable = true;
    settings = {
      max_lines = 100;
      provider = "Ollama";
      provider_options = {
        model = "codellama:13b-code";
      };
      notify = true;
      notify_callback = "function(msg) vim.notify(msg) end";
      run_on_every_keystroke = true;
      ignored_file_types = {
        # Empty by default, example of how to ignore:
        # lua = true;
      };
    };
  };
}
