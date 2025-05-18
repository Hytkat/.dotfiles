{ pkgs, ... }:

{
  # General home stuff.
  home.username = "hytkat";
  home.homeDirectory = "/home/hytkat";
  home.stateVersion = "24.11"; # DO NOT CHANGE!
  home.packages = [
    pkgs.catppuccin-kde
    pkgs.brave
    pkgs.bibata-cursors
    pkgs.prismlauncher
    pkgs.dunst
    pkgs.fd
    pkgs.erdtree
    pkgs.ffmpeg
    pkgs.fastfetch
    pkgs.gparted
    pkgs.inotify-tools
    pkgs.jq
    pkgs.just
    # pkgs.jetbrains.idea-ultimate
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.kde-gtk-config
    pkgs.kdePackages.partitionmanager
    pkgs.keyleds
    pkgs.legcord
    pkgs.libnotify
    pkgs.lsof
    pkgs.mpv
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.ntfs3g
    pkgs.openrgb
    pkgs.podman-compose
    pkgs.php
    pkgs.ripgrep
    pkgs.rainfrog
    pkgs.rofi-wayland
    pkgs.unzip
    pkgs.unrar
    pkgs.vscode-langservers-extracted
    pkgs.vscode
    pkgs.wget
    pkgs.waybar
    pkgs.librewolf
    pkgs.libreoffice-qt-fresh
    pkgs.wl-clipboard
    pkgs.yaml-language-server
    pkgs.youtube-music
    # fonts
    pkgs.nerd-fonts.jetbrains-mono

  ];

  # Fontconfig stuff.
  fonts.fontconfig.enable = true;

  # Let home-manager update itself.
  programs.home-manager.enable = true;

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # Modules.
  imports = [
    ./eza.nix
    ./ghostty.nix
    ./kdeconnect.nix
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./fish.nix
    ./flatpak.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./yazi.nix
    ./zoxide.nix
  ];

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
}
