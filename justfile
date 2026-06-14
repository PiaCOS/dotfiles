default:
    just -l

# Update flake inputs
update:
    nix flake update

# # Build flake
# build:
#     nixos-rebuild build --flake ~/Dev/dotfiles#nixos
#     nvd diff /run/current-system ./result

# # Apply the update
# apply:
#     nixos-rebuild switch --flake ~/Dev/dotfiles#nixos

# Rebuild system flake
build:
    sudo nixos-rebuild switch --flake ~/Dev/dotfiles#nixos
    nvd diff /run/booted-system /run/current-system

# Keymap for vampire survivor
vampire:
    sudo nix-shell -p "python3.withPackages (ps: [ ps.evdev ])" --run "python3 scripts/vampire_mode.py"
