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
    pkgs.bibata-cursors
    pkgs.bottles
    pkgs.brave
    pkgs.catppuccin
    pkgs.code-cursor
    pkgs.distrobox
    pkgs.erdtree
    pkgs.fastfetch
    pkgs.fd
    pkgs.ffmpeg
    pkgs.freerdp
    pkgs.gparted
    pkgs.ghidra
    # pkgs.hdparm
    pkgs.i3-auto-layout
    pkgs.inotify-tools
    pkgs.jetbrains.idea
    pkgs.jq
    pkgs.just
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.kde-gtk-config
    pkgs.legcord
    pkgs.libreoffice-qt-fresh
    pkgs.librewolf
    pkgs.lsof
    pkgs.maple-mono.NF
    pkgs.mpv
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.nix-output-monitor
    pkgs.nix-search-tv
    pkgs.pika-backup
    pkgs.podman-compose
    pkgs.prismlauncher
    pkgs.pear-desktop
    pkgs.ripgrep
    pkgs.signal-desktop
    pkgs.smartmontools
    pkgs.steam
    pkgs.spectrwm
    pkgs.sublime
    pkgs.telegram-desktop
    pkgs.theme-obsidian2
    pkgs.unrar
    pkgs.unzip
    pkgs.vscode
    pkgs.vscode-langservers-extracted
    pkgs.vesktop
    pkgs.wasistlos
    pkgs.wl-clipboard
    pkgs.xfce4-docklike-plugin
    pkgs.xfce4-pulseaudio-plugin
    pkgs.yaml-language-server
    pkgs.youtube-music
    # fonts
    pkgs.nerd-fonts.jetbrains-mono
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
    ./niri.nix
  ];

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
}
