{ lib, config, ... }:

{
  options.netmod = {
    enable = lib.mkEnableOption "enable networking module";
    name = lib.mkOption {
      description = "the networking hostName";
    };
  };

  config = lib.mkIf config.netmod.enable {
    networking = {
      hostName = config.netmod.name;
      networkmanager.enable = true;
      firewall = rec {
        # KDE Connect
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };
    };
  };
}
