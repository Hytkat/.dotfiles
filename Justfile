default:
    @just --list

alias hs := home-switch
home-switch:
    nix run home-manager/master -- switch --flake .

alias ssn := system-switch-nixos
system-switch-nixos:
    sudo nixos-rebuild switch --flake .#nixos
