{
  description = "Pure NixOS flake with unified system packages and scripts";

  inputs = {
    # System packages (Bleeding edge)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    helix-fork.url = "github:PiaCOS/helix/pia-helix-fork";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, helix-fork, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {

    # -------------------------------------------------------------------------
    #                            System Config
    # -------------------------------------------------------------------------
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        ({ pkgs, ... }: {
          environment.variables.EDITOR = "hx";

          # User definition (Packages removed, managed globally now)
          users.users.pia = {
            isNormalUser = true;
            description = "Pia";
            extraGroups = [ "networkmanager" "wheel" ];
          };

          # Unified System-wide packages
          environment.systemPackages = with pkgs; [
            # Essentials
            acpi
            autorandr
            brightnessctl
            fish
            git
            libnotify
            lm_sensors
            nvd
            rofi
            scrot
            sysstat
            tree
            vim

            # CLI tools
            bottom
            direnv
            eza
            fastfetch
            fzf
            htop
            hyfetch
            ripgrep
            senpai
            tldr
            uv
            zoxide

            # Development
            binutils
            gcc
            gnupg1
            inputs.helix-fork.packages.${system}.default
            just
            python3
            rustup
            steel
            zellij

            # LSP
            nixd
            nixpkgs-fmt
            perlnavigator
            uwu-colors

            # GUI apps
            blender
            calibre
            feh
            gimp
            picom
            thunar
            wezterm
            inputs.zen-browser.packages.${system}.default

            # RTL-SDR
            alsa-utils
            rtl-sdr

            # Game
            rogue

            # Custom Scripts
            (writeShellScriptBin "brightness-up" ''
              ${brightnessctl}/bin/brightnessctl set 2%+
            '')
            (writeShellScriptBin "brightness-down" ''
              ${brightnessctl}/bin/brightnessctl set 2%-
            '')
            (pkgs.writeTextFile {
              name = "scry";
              executable = true;
              destination = "/bin/scry";
              text = builtins.readFile ./scripts/scry;
            })
          ];
        })
      ];
    };
  };
}
