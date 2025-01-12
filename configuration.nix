#  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Next seven lines courtesy of vbox demo appliance 4 Jan 2025 get basic Hyprland working
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # allow x11 applications
  };
  programs.sway.enable = true;
  programs.waybar.enable = true; 
  console.useXkbConfig = true;
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixoslaptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = false;
  # services.displayManager.ly.enable = true;
  
  services.xserver = {
      displayManager = {
        startx.enable = true;
      };
  };

  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evangelist = {
    isNormalUser = true;
    description = "Paul";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Install firefox.
  programs.firefox.enable = true; 
  
  nix.settings.experimental-features = [ "nix-command"]; # "flakes" ];
   
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  neovim
  wl-clipboard
  # wayclip
  # waypaste # Unnecessary, included in wayclip
  xclip
  neovim-gtk
  wget
  google-chrome
  gotop
  foot
  radeontop
  git  
  gnome-terminal
  # locate
  python3
  curl
  vscode
  fastfetch
  signal-desktop
  openssh
  gedit
  # alacritty
  starship
  element-desktop
  gotop 
  irssi 
  sway
  oh-my-posh
  libgcc
  libgccjit
  binutils
  musl
  gcc
  btop
  meld
  #inputs.helix.packages."${pkgs.system}".helix # in flake
  inputs.helix.packages."${pkgs.system}".helix
  nix-output-monitor
  alacritty 
  discord  
    # Next ten lines courtest of vbox demo appliance 4 Jan 2025 to get basic Hyprland working
    waybar # status bar
    mako # notification daemon
    libnotify # for mako
    swww # wallpaper daemon
    kitty # terminal
    rofi-wayland # wl equiv of rofi app launcher, window switcher ...
    networkmanagerapplet # tray applet for network manager -- nm-applet
    grim # screenshot utility
    grimblast # grim helper
    udiskie # automount removable media

  stow
  lynx
  # www-browser
  atuin
];


fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.noto
  nerd-fonts.hack
  nerd-fonts.ubuntu
  nerd-fonts.mplus
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
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
