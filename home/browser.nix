{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  parfait = pkgs.fetchFromGitHub {
    owner = "debarchito";
    repo = "parfait";
    rev = "1c936f9365fe076a33d9305a40279144834cfe13";
    sha256 = "sha256-UUOqX0bfsSj3ibH4enGyaEblI1cYCqnPn1Lh+VsmZnk=";
  };
in
{
  options.browsers.librewolf.enable = lib.mkEnableOption "Enable my LibreWolf configuration";

  config = lib.mkIf config.browsers.librewolf.enable {

    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];

    programs.librewolf = {
      enable = true;

      nativeMessagingHosts = [
        pkgs.pywalfox-native
        pkgs.tridactyl-native
      ];

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "places.history.enabled" = false;
          "general.autoScroll" = true;
          "middlemouse.paste" = false;
        };
      };
    };
  };
}
