# Update flake inputs
update-flake:
    nix flake update

# Rebuild system flake
build-system:
    sudo nixos-rebuild switch --flake ~/Dev/dotfiles#nixos

# Rebuild home manager
build-home:
    nix run home-manager/master -- switch --flake ~/Dev/dotfiles#pia
