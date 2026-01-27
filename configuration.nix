# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # ---------------- Boot ----------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disallow those to run so rtl-sdr can start
  boot.blacklistedKernelModules = [
    "dvb_usb_rtl28xxu"
    "rtl2832"
    "rtl2830"
  ];


  # ---------------- Net ----------------

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;


  # ---------------- Local ----------------

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure console keymap
  console.keyMap = "be-latin1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # ---------------- X11 ----------------

  # Configure i3
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3status
      i3blocks
      i3lock
      dunst
      xclip
      xss-lock
      imagemagickBig
      pulseaudioFull
      xmodmap
    ];
  };

  services.displayManager.ly.enable = true;


  # ---------------- Audio ----------------

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.rtl-sdr.enable = true;


  # ---------------- User ----------------

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pia = {
    isNormalUser = true;
    description = "Pia";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    packages = with pkgs; [
    ];
  };

  fonts.packages = with pkgs; [
    maple-mono.NF
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };


  # ---------------- Nix ----------------

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11"; # Did you read the comment?

}
