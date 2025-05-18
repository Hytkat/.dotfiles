{ lib, config, ... }:

{
  options.podman.enable = lib.mkEnableOption "enable podman module";

  config = lib.mkIf config.podman.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
