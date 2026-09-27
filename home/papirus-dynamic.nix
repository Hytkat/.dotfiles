{ config, ... }:

{
  programs.papirus-dynamic = {
    enable = true;

    colors = {
      primary = config.lib.stylix.colors.base0D;
      secondary = config.lib.stylix.colors.base0D;
      glyph = config.lib.stylix.colors.base00;
      paper = config.lib.stylix.colors.base00;
      monochrome = config.lib.stylix.colors.base0D;
      accent = config.lib.stylix.colors.base0E;
    };
  };
}
