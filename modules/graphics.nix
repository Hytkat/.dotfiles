{ lib, config, ... }:

{
  options.graphics = {
    enable = lib.mkEnableOption "enable graphics module";
    nvidia.enable = lib.mkEnableOption "enable nvidia support";
    nvidia.prime.enable = lib.mkEnableOption "enable nvidia prime support";
    nvidia.prime.offload.enable = lib.mkEnableOption "enable nvidia prime offload";
    nvidia.prime.intelBusId = lib.mkOption {
      description = "the intel pci bus id";
    };
    nvidia.prime.nvidiaBusId = lib.mkOption {
      description = "the nvidia pci bus id";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.graphics.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })

    (lib.mkIf (config.graphics.enable && config.graphics.nvidia.enable) {
      services.xserver.videoDrivers = [
        "nvidia"
        "modesetting"
      ];

      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
      hardware.nvidia-container-toolkit.enable = true;
      boot.kernelParams = [
        "nvidia.NVreg_DynamicPowerManagement=0x02"
      ];

      environment.systemPackages = [
        config.hardware.nvidia-container-toolkit.package
      ];
    })

    (lib.mkIf
      (config.graphics.enable && config.graphics.nvidia.enable && config.graphics.nvidia.prime.enable)
      {
        hardware.nvidia.prime = {
          intelBusId = config.graphics.nvidia.prime.intelBusId;
          nvidiaBusId = config.graphics.nvidia.prime.nvidiaBusId;

          offload.enable = true;
          offload.enableOffloadCmd = true;
        };
      }
    )

    # (lib.mkIf
    #   (
    #     config.graphics.enable
    #     && config.graphics.nvidia.enable
    #     && config.graphics.nvidia.prime.enable
    #     && config.graphics.nvidia.prime.offload.enable
    #   )

    # )
  ];
}
