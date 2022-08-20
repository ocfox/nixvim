{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.programs.nixvim.colorschemes.everforest;
  style = types.enum [ "hard" "medium" "soft" ];
  background = types.enum [ "light" "dark" ];
in {
  options = {
    programs.nixvim.colorschemes.everforest = {
      enable = mkEnableOption "Enable everforest";
      style = mkOption {
        type = types.nullOr style;
        default = null;
        description = "The background contrast used in this color scheme";
      };
      background = mkOption {
        type = types.nullOr background;
        default = null;
        description = "The background version (dark or light)";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      colorscheme = "everforest";
      extraPlugins = [ pkgs.vimPlugins.everforest ];
      options = { termguicolors = true; };
      globals = {
        background = mkIf (!isNull cfg.background) cfg.background;
        everforest_background = mkIf (!isNull cfg.style) cfg.style;
      };
    };
  };
}
