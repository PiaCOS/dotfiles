{
  description = "Unified NixOS + Home Manager flake with scripts";

  inputs = {
    # System packages (Bleeding edge)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-fork.url = "github:PiaCOS/helix/pia-helix-fork";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, helix-fork, zen-browser, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      dotfilesPath = "/home/pia/Dev/dotfiles";
    };
  in {

    # -------------------------------------------------------------------------
    #                            System config
    # -------------------------------------------------------------------------
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            wezterm
            zen-browser.packages.${system}.default
            xfce.thunar
            feh
            picom
            fish
          ];
        })
      ];
    };

    # -------------------------------------------------------------------------
    #                            Home Manager config
    # -------------------------------------------------------------------------
    homeConfigurations.pia = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ({ pkgs, ... }: {
          home.username = "pia";
          home.homeDirectory = "/home/pia";
          home.stateVersion = "24.11";

          # ----------------- packages ------------------

          home.packages = with pkgs; [
            # CLI tools
            fastfetch
            hyfetch
            lazygit
            tldr
            fzf
            eza
            zoxide
            ripgrep
            uv
            brightnessctl

            # Development
            rustup
            gcc
            binutils
            python3
            zellij
            home-manager
            helix-fork.packages.${system}.default

            # LSP
            nixd
            nixpkgs-fmt

            # Custom Scripts
            (writeShellScriptBin "brightness-up" ''
              ${brightnessctl}/bin/brightnessctl set 5%+
            '')
            (writeShellScriptBin "brightness-down" ''
              ${brightnessctl}/bin/brightnessctl set 5%-
            '')
          ];

          # ---------------- SYMLINKS ----------------

          # home.file.".config/helix".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/helix";
          # home.file.".config/zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/zellij/config.kdl";
          # home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/i3/config";

          # ---------------- fish config ----------------

          # programs.fish = {
          #   enable = true;
          #   shellAliases = {
          #     sysup = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
          #     homeup = "nix run home-manager/master -- switch --flake /etc/nixos#pia";
          #     up = "sysup && homeup";
          #   };
          # };

          # ---------------- git config ----------------

           programs.git = {
            enable = true;
            settings = {
              user = {
                name  = "PiaCOS";
                email = "pia.cosneau@gmail.com";
              };
              core = {
                editor = "helix";
              };
              alias = {
                cp = "cherry-pick";
                head5 = "log --oneline -n 5";
                head10 = "log --oneline -n 10";
                head20 = "log --oneline -n 20";
                lograph = "log --oneline --graph --decorate --all";
              };
              init.defaultBranch = "main";
            };
          };

          # ---------------- git config ----------------

          programs.lazygit = {
            enable = true;
              settings = {
                os = {
                  editPreset = "helix";
                };
              };
          };

          # ---------------- rofi config ----------------

          programs.rofi = {
            enable = true;
            theme = "${pkgs.rofi}/share/rofi/themes/gruvbox-dark.rasi";
          };

          # ---------------- i3 config ----------------

          # xdg.configFile."i3blocks/config".text = ''
          #   # Global properties
          #   separator_block_width=15
          #   markup=none

          #   [battery]
          #   label=BAT
          #   # This requires the 'acpi' command
          #   command=acpi -b | awk '{print $4}' | tr -d ','
          #   interval=30
          #   color=#E3E300

          #   [time]
          #   command=date '+%Y-%m-%d %H:%M:%S'
          #   interval=1
          # '';
        })
      ];
    };
  };
}
