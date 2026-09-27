{ pkgs, ... }:

{
  # Declarative, not fish-specific -- applies to any program home-manager
  # launches for you, not just interactive fish sessions.
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "foreign-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
      {
        name = "transient-fish";
        src = pkgs.fishPlugins.transient-fish.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
    ];
    interactiveShellInit = ''
      set fish_greeting
      # `shellAbbrs` can't place the cursor mid-expansion, so this one stays
      # as a raw `abbr` call instead of living in the attrset below.
      abbr -a --set-cursor="%" -- gcm 'git commit -S -m "%"';
    '';
    preferAbbrs = true;
    shellAbbrs = {
      cd = "z";
      gc = "git commit -S";
      gcl = "git clone";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };
    functions = {
      run = ''
        if test (count $argv) -eq 0
          echo "Usage: run <package> [<args>...]"
          return 1
        end
        nix run nixpkgs#$argv[1] -- $argv[2..-1]
      '';
      runu = ''
        if test (count $argv) -eq 0
          echo "Usage: runu <package> [<args>...]"
          return 1
        end
        NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$argv[1] -- $argv[2..-1]
      '';
      shell = ''
        if test (count $argv) -eq 0
          echo "Usage: shell <package> [<package>...]"
          return 1
        end
        set pkgs
        for pkg in $argv
          set -a pkgs nixpkgs#$pkg
        end
        nom shell $pkgs --command fish
      '';
      treep = ''
        tree -L 4 -d -I "node_modules|dist|build|coverage|.git|.next|target"
      '';
    };
  };
}
