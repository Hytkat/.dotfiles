{ pkgs, ... }:

let
  qt6ct = pkgs.qt6Packages.qt6ct.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ./_patches/qt6ct.patch
    ];
  });
in
{
  programs.niri.config = null;

  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

  programs.dank-material-shell.enable = true;
  programs.dank-material-shell.niri.includes.enable = false;
  programs.dank-material-shell.enableSystemMonitoring = true;
  programs.dank-material-shell.enableVPN = true;
  programs.dank-material-shell.enableDynamicTheming = true;
  programs.dank-material-shell.enableAudioWavelength = true;
  programs.dank-material-shell.enableCalendarEvents = true;

  home.packages = [
    pkgs.dsearch
    pkgs.nautilus
    pkgs.pywal
    pkgs.pywalfox-native
    pkgs.xwayland-satellite
    qt6ct
  ];
}
