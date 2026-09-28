{ lib, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };

  xdg.configFile."yazi/yazi.toml".source =
    lib.mkForce ./yazi/yazi.toml;

  

  xdg.configFile."yazi/catppuccin-mocha.tmTheme".source =
    lib.mkForce ./yazi/catppuccin-mocha.tmTheme;
}