{ lib, config, ... }:

{
  options.sunshine.enable = lib.mkEnableOption "enable sunshine module";

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
