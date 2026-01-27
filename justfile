# Update flake inputs
flake-update:
    nix flake update

# Rebuild system flake
system-build:
    sudo nixos-rebuild switch --flake ~/Dev/dotfiles#nixos
    nvd diff /run/current-system /run/booted-system

# Rebuild home manager
home-build:
    nix run home-manager/master -- switch --flake ~/Dev/dotfiles#pia

# Rebuild Nixos
nixos-build:
    sudo nixos-rebuild switch --flake ~/Dev/dotfiles#nixos
    nix run home-manager/master -- switch --flake ~/Dev/dotfiles#pia
    nvd diff /run/current-system /run/booted-system
