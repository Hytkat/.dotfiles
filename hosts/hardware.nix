let
  name = "hytkat";
in
{
  flake.modules.nixos."hosts-${name}" =
    { pkgs, ... }:
    {
      # NOTE: Generated files are treated as external dependencies thus are a special case for relative imports.
      imports = [
        ./_generated/hardware-configuration.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_lqx;
      boot.extraModprobeConfig = "options kvm_intel nested=1";
      boot.tmp.cleanOnBoot = true;

      zramSwap.enable = true;
    };
}
