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
          environment.variables.EDITOR = "hx";

          environment.systemPackages = with pkgs; [
            # Essentials
            autorandr
            git
            vim
            rofi
            fish
            acpi
            upower
            lm_sensors
            sysstat
            brightnessctl
            libnotify
            scrot

            # GUI apps
            wezterm
            zen-browser.packages.${system}.default
            thunar
            feh
            picom
            fish

            rustup
            gcc
            binutils
            gnupg1
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

            # Development
            just
            python3
            zellij
            home-manager
            helix-fork.packages.${system}.default
            bottom

            # LSP
            nixd
            nixpkgs-fmt

            # RTL-SDR
            alsa-utils
            gqrx
            rtl-sdr
            # cubicsdr
            # sox
            # multimon-ng
            # direwolf
            # fldigi
            # wsjtx

            # Custom Scripts
            (writeShellScriptBin "brightness-up" ''
              ${brightnessctl}/bin/brightnessctl set 2%+
            '')
            (writeShellScriptBin "brightness-down" ''
              ${brightnessctl}/bin/brightnessctl set 2%-
            '')
          ];

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

          # ---------------- ssh config ----------------

          # programs.ssh = {
          #   enable = true;
          #   startAgent = true;
          # };

          # ---------------- lazygit config ----------------

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

          # ---------------- wezterm config ----------------

          xdg.configFile."wezterm/wezterm.lua".text = ''
            local wezterm = require 'wezterm'
            local config = {}

            -- -------- FONTS --------
            local FONT_FAMILY = "Maple Mono NF"
            local FONT_SIZE = 9.5
            config.font_size = FONT_SIZE
            config.font = wezterm.font(FONT_FAMILY)

            -- -------- THEME --------
            config.window_background_opacity = 0.89
            config.enable_tab_bar = false
            config.color_schemes = {}
            config.color_scheme = 'Seoul256 (Gogh)'
            config.colors = {
              foreground = "#d5cdcd",
              background = "#222222",
            }

            -- -------- SHELL --------
            config.default_prog = { "fish" }

            -- -------- KEYS --------
            config.keys = {
              -- was conflicting with lazygit commit keymap
              {
                key = 'Enter',
                mods = 'ALT',
                action = wezterm.action.DisableDefaultAssignment,
              },
            }

            return config
          '';

          # ---------------- niri config ----------------

          xdg.configFile."niri/config.kdl".text = ''
              input {
                  keyboard {
                      xkb {
                          layout "be"
                      }
                  }
                  touchpad {
                      tap
                      natural-scroll
                  }
              }

              // Keybindings
              binds {
                  Mod+Return { spawn "wezterm"; }
                  Mod+D { spawn "rofi" "-show" "drun"; }
                  Mod+Q { close-window; }

                  Mod+Left  { focus-column-left; }
                  Mod+Right { focus-column-right; }
                  Mod+Shift+Left  { move-column-left; }
                  Mod+Shift+Right { move-column-right; }

                  Mod+WheelScrollDown      coarse-scroll-right;
                  Mod+WheelScrollUp        coarse-scroll-left;

                  Print { screenshot; }

                  // Exit niri
                  Mod+Shift+E { quit; }
              }

              layout {
                  gap 16
                  default-column-width { proportion 0.5; }
              }

              spawn-at-startup "waybar"
          '';
        })
      ];
    };
  };
}
