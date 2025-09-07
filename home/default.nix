{ pkgs, ... }:

{
  # General home stuff.
  home.username = "hytkat";
  home.homeDirectory = "/home/hytkat";
  home.stateVersion = "24.11"; # DO NOT CHANGE!
  home.packages = [
    # themes and icons
    (pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "classic" ];
    })
    pkgs.autokey
    pkgs.catppuccin
    pkgs.brave
    pkgs.bibata-cursors
    pkgs.btrfs-assistant
    pkgs.prismlauncher
    pkgs.code-cursor
    pkgs.distrobox
    pkgs.fd
    pkgs.freerdp
    pkgs.erdtree
    pkgs.ffmpeg
    pkgs.fastfetch
    pkgs.hdparm
    pkgs.gcc
    pkgs.inotify-tools
    pkgs.theme-obsidian2
    pkgs.jq
    pkgs.just
    pkgs.jetbrains.idea-ultimate
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.kde-gtk-config
    pkgs.legcord
    pkgs.lsof
    pkgs.mpv
    pkgs.maple-mono.NF
    pkgs.nixd
    pkgs.niri
    pkgs.nixfmt-rfc-style
    pkgs.nix-search-tv
    pkgs.nix-output-monitor
    pkgs.podman-compose
    pkgs.pnpm
    pkgs.nodePackages.json
    pkgs.nodejs
    pkgs.notion
    pkgs.pika-backup
    pkgs.python312Full
    #pkgs.python311Packages.speechrecognition
    pkgs.php
    pkgs.jetbrains.pycharm-community
    pkgs.ripgrep
    pkgs.rPackages.react
    pkgs.steam
    pkgs.steam-run-free
    pkgs.signal-desktop
    pkgs.smartmontools
    pkgs.spectrwm
    pkgs.sublime
    pkgs.i3-auto-layout
    pkgs.telegram-desktop
    pkgs.torrent7z
    pkgs.torrential
    pkgs.unzip
    pkgs.unrar
    pkgs.vscode-langservers-extracted
    pkgs.vscode
    pkgs.librewolf
    pkgs.libreoffice-qt-fresh
    pkgs.wl-clipboard
    pkgs.whatsapp-for-linux
    pkgs.xfce.xfce4-pulseaudio-plugin
    pkgs.xfce.xfce4-docklike-plugin
    pkgs.yaml-language-server
    pkgs.youtube-music
    # fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.steam
    pkgs.zed-editor

  ];

  # Fontconfig stuff.
  fonts.fontconfig.enable = true;

  # Let home-manager update itself.
  programs.home-manager.enable = true;

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # Catppucin
  # catppuccin.enable = true;
  # catppuccin.flavor = "mocha";

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
