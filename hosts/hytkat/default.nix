{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/common-settings.nix
    ../../modules/trusted-substituters.nix
    ../../modules/security.nix
    ../../modules/netmod.nix
    ../../modules/bluetooth.nix
    ../../modules/pipewire.nix
    ../../modules/graphics.nix
    ../../modules/podman.nix
    ../../modules/vm.nix
    ../../modules/sunshine.nix
    ../../modules/steam.nix
  ];

  # Some stuff that should exist independently.
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # Firmware stuff.
  services.fwupd.enable = true;

  # Fine-grained boot stuff.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Fine-grained localization stuff.
  time.timeZone = "Asia/Kolkata";
  i18n.supportedLocales = [
    "en_IN/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_IN";
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_NAME = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
    LC_MESSAGES = "en_IN";
    LC_COLLATE = "en_IN";
    # Use different locale for these
    LC_MONETARY = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
  };

  # Miscellaneous stuff.
  common-settings.enable = true;
  trusted-substituters.enable = true;
  security.enable = true;

  # Networking stuff.
  netmod.enable = true;
  netmod.name = "nixos";

  # Media stuff.
  bluetooth.enable = true;
  pipewire.enable = true;

  # Display Manager stuff.
  services.xserver.videoDrivers = [ "nvidia" ];
  services.displayManager.ly.enable = false;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.discover
    pkgs.kdePackages.elisa
    pkgs.kdePackages.kate
  ];
  environment.systemPackages = [
    pkgs.kitty
    pkgs.protonup-ng
  ];

  # Graphics stuff.
  graphics.enable = true;
  graphics.nvidia.enable = true;
  graphics.nvidia.prime.enable = true;
  graphics.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    offload.enable = true;
  };

  #Asus
  services.asusd.enable = true;
  #RGB
  services.hardware.openrgb.enable = true;
  #Nvidia
  hardware.nvidia.powerManagement.enable = true;
  programs.gamemode.enable = true;

  powerManagement.cpuFreqGovernor = "performance";

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  #MONGODB.
  services.mongodb.enable = false;

  # Virtualization stuff.
  podman.enable = true;
  vm.enable = true;
  vm.kvm.enable = true;
  # virtualisation.vmware.host.enable = true;
  # virtualisation.vmware.guest.enable = true;
  # vm.waydroid.enable = true;

  # Sunshine (and Moonlight) stuff.
  sunshine.enable = true;

  # Flatpak stuff.
  services.flatpak.enable = true;

  # AppImage stuff.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  #NIX-LD
  # programs.nix-ld.enable = true;
  programs.chromium.enable = true;

  #Wireshark
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  # Localsend.
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # OpenSSH
  services.openssh.enable = true;

  # Me!
  users.users.hytkat = {
    isNormalUser = true;
    description = "Hytkat";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "bluetooth"
      "libvirtd"
      "kvm"
      "wireshark"
    ];
  };
  # virtualisation.vmware.guest.package = pkgs.open-vm-tools;
  # Variables stuff.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
