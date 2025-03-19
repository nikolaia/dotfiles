{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    tsc-nvim
  ];

  extraConfigLua = ''
    require("tsc").setup({
         auto_open_trouble = true, 
         -- Your other tsc.nvim settings
       })'';
}
