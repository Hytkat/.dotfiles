{ lib, ... }:

{
  programs.ghostty.enable = true;
  xdg.configFile."ghostty/config".source = lib.mkForce ./ghostty/config;
}
