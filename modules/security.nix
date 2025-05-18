{ lib, config, ... }:

{
  options.security.enable = lib.mkEnableOption "enable security module";

  config = lib.mkIf config.security.enable {
    security.rtkit.enable = true;
    security.polkit.enable = true;
  };
}
