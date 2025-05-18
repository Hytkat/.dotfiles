{ lib, config, ... }:

{
  options.common-settings.enable = lib.mkEnableOption "common settings that can be utilized for multiple hosts";

  config = lib.mkIf config.common-settings.enable {
    services.printing.enable = true;
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
