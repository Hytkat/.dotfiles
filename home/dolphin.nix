{ lib, ... }:

{
  xdg.configFile."kdeglobals".text = lib.mkForce ''
    [UiSettings]
    ColorScheme=DankMatugen
  '';
}