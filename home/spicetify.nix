{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      simpleBeautifulLyrics
      beautifulLyrics
      spicyLyrics
      coverAmbience
      powerBar
    ];

     enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
    ];
    # theme = spicePkgs.themes.default;
    # colorScheme = "default";
  };
}