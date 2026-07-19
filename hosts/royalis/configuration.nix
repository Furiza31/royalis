# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "royalis"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "fr";
  };

  # Firmeware and grphics support.
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Laptop power-profile management
  services.power-profiles-daemon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr"; # Active here because Niri can obtain this XKB throught systemd-localed

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Modern audio stack
  security.rtkit.enable = true;

  # Active the polkit service
  security.polkit.enable = true;

  # Active Nautilus functionnality, bin and network location
  services.udisks2.enable = true;

  # Enable pipewire to have audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.furiza = {
    isNormalUser = true;
    extraGroups = [
	    "wheel" # Allows the user to use sudo
	    "networkmanager" # Allow the user to manager Wi-Fi
      "video"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.firefox.enable = true;

  programs.git.enable = true;

  programs.zsh.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
	      user = "furiza";
      };

      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd niri-session";
        user = "greeter";
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    wl-clipboard
    brightnessctl
    playerctl
    nautilus
    xwayland-satellite
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Install and integrate the niri Wayland compositor.
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment

}

