{ pkgs, ... }:

{
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
    '';
    preferAbbrs = true;
    shellAbbrs = {
      cd = "z";
      tree = "erd";
      rp = "kwin_wayland --replace & plasmashell --replace &";
    };
    functions = {
      run = ''
        if test (count $argv) -eq 0
          echo "Usage: run <package> [<args>...]"
          return 1
        end
        nix run nixpkgs#$argv[1] -- $argv[2..-1]
      '';
      run_unfree = ''
        if test (count $argv) -eq 0
          echo "Usage: run_unfree <package> [<args>...]"
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
        nix shell $pkgs --command fish
      '';
    };
  };
}
