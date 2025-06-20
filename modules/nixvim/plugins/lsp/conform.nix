{
  lib,
  pkgs,
  ...
}:
{
  config = {
    extraConfigLuaPre =
      # lua
      ''
        local slow_format_filetypes = {}
        -- Add this to prevent format loops
        local format_in_progress = false

        vim.api.nvim_create_user_command("FormatDisable", function(args)
           if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end, {
          desc = "Disable autoformat-on-save",
          bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end, {
          desc = "Re-enable autoformat-on-save",
        })
        vim.api.nvim_create_user_command("FormatToggle", function(args)
          if args.bang then
            -- Toggle formatting for current buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
          else
            -- Toggle formatting globally
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end
        end, {
          desc = "Toggle autoformat-on-save",
          bang = true,
        })
      '';
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          html = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true; # Stop after first formatter succeeds
          };
          css = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          python = [
            "black"
            "isort"
          ];
          lua = [ "stylua" ];
          nix = [ "nixfmt-rfc-style" ];
          markdown = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          yaml = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          terraform = [ "terraform_fmt" ];
          kotlin = [ "ktlint" ];
          bicep = [ "bicep" ];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          json = [ "jq" ];
          "_" = [ "trim_whitespace" ];
        };
        format_on_save = ''
          function(bufnr)
            -- Prevent format loops
            if format_in_progress then
              return
            end

            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            local function on_format(err)
              format_in_progress = false
              if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
              end
            end

            format_in_progress = true
            return { timeout_ms = 200, lsp_fallback = "fallback_only" }, on_format
          end
        '';
        format_after_save = ''
          function(bufnr)
            -- Prevent format loops
            if format_in_progress then
              return
            end

            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            format_in_progress = true
            local ret = { lsp_fallback = "fallback_only" }

            -- Reset format_in_progress after format completes
            vim.defer_fn(function()
              format_in_progress = false
            end, 300)

            return ret
          end
        '';
        notify_on_error = true;
        formatters = {
          black = {
            command = "${lib.getExe pkgs.black}";
          };
          isort = {
            command = "${lib.getExe pkgs.isort}";
          };
          nixfmt-rfc-style = {
            command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          };
          alejandra = {
            command = "${lib.getExe pkgs.alejandra}";
          };
          jq = {
            command = "${lib.getExe pkgs.jq}";
          };
          prettierd = {
            command = "${lib.getExe pkgs.prettierd}";
          };
          stylua = {
            command = "${lib.getExe pkgs.stylua}";
          };
          shellcheck = {
            command = "${lib.getExe pkgs.shellcheck}";
          };
          shfmt = {
            command = "${lib.getExe pkgs.shfmt}";
          };
          shellharden = {
            command = "${lib.getExe pkgs.shellharden}";
          };
          bicep = {
            command = "${lib.getExe pkgs.bicep}";
          };
          ktlint = {
            command = "${lib.getExe pkgs.ktlint}";
          };
        };
      };
    };
  };
}
