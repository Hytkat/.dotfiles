{ lib, config, ... }:

{
  options.pipewire.enable = lib.mkEnableOption "enable pipewire module";

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
