default:
    just -l

# Update flake inputs
update-flake:
    nix flake update

# Rebuild system flake
build:
    sudo nixos-rebuild switch --flake ~/Dev/dotfiles#nixos
    nvd diff /run/booted-system /run/current-system

# Keymap for vampire survivor
vampire:
    sudo nix-shell -p "python3.withPackages (ps: [ ps.evdev ])" --run "python3 scripts/vampire_mode.py"
