{ config, pkgs, lib, ... }:

# ----- [ IMPORTS ] ------------------------------
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# ----- [ BOOTLOADER ] ------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# ----- [ KERNEL and FIRMWARE ] ------------------------------
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.firmware = [ pkgs.linux-firmware ];

# ----- [ HOSTNAME ] ------------------------------
  networking.hostName = "nixoslaptop";

# ----- [ NETWORKING AND WIFI ] ------------------------------
  # Set up network manager
  networking.networkmanager.enable = true;

# ----- [ TIME AND INTERNATIONALIZATION ] ------------------------------
  time.timeZone = "America/New_York";
  # "internationalization stuff, you might not need to touch this"
  # "A long time ago, we had alot of standards, this is the fallout..."
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

# ----- [ DISPLAY MANAGER ] ------------------------------
# Note: Your display manager is a fancy login screen
  services.displayManager.gdm.wayland = false;
  services.displayManager.gdm.enable = true;

# ----- [ DESKTOP ] ------------------------------
# Note: With your setup, you have two display server protocols setup. This is not recommended.
# Programs using the display server protocols Wayland: Gnome, hyprland, sway
# Programs using the older display server protocols x11: gdm
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # allow x11 applications (Emulate x11 for programs that have not switched yet. Mostly old flatpaks)
  };

  programs.sway.enable = true;

  # Enable X11 display manager
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.desktopManager.gnome.enable = true;
  # environment.sessionVariables = {
  #  HYPR_PLUGIN_DIR = pkgs.symlinkJoin {
  #   name = "hyprland-plugins";
  #    paths = with pkgs.hyprlandPlugins; [
  #     hyprexpo
        # hyprfocus
        # hyprtrails
        #...plugins
  #    ];
  #  };
  #};

# ----- [ DRIVER CONFIG ] ------------------------------
# While driver config on NixOS is not easy, here is AMD setup. (Setup by rhbollinger1s, who use NIVIDA on linux, so AMD is easy.)
  hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
      amdgpu.opencl.enable = true;
      amdgpu.initrd.enable = true; # sets boot.initrd.kernelModules = ["amdgpu"];
      #amdgpu.legacySupport.enable = true; # Only use for Southern islands or Sea islands GPUs
    };
# ----- [ XDG PORTALS ] ------------------------------
  xdg.portal.enable = true;

# ----- [ SUID WRAPPERS ] ------------------------------
  # "Some programs need SUID wrappers, can be configured further or are
  # started in user sessions. Dont worry about it."
  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

# ----- [ USER ACCOUNTS ] ------------------------------
  users.users.Paul = {
    isNormalUser = true;
    description = "The Evangelist";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

# ----- [ PROGRAMS ] ------------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; # For non FOSS software to be allowed

  # Here, we add fonts... yay.
fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.droid-sans-mono
  nerd-fonts.noto
  nerd-fonts.hack
  nerd-fonts.ubuntu
    # nerd-fonts.mplu
  nerd-fonts.symbols-only
  nerd-fonts.hurmit
  nerd-fonts.iosevka-term
  nerd-fonts.jetbrains-mono
  ];

  # "Programs that are not fonts are below. There are two kinds"
  # "There are installed packages, that work as you would think"
  # "Then we have enabled packages, these have other things they need, so enabling it does more that just installing it."

  # Installed Packages
  environment.systemPackages = with pkgs; [

  # CLI
  wev
  vim
  wl-clipboard
  xclip
  pciutils
  neovim-gtk
  wget
  gotop
  radeontop
  fastfetch
  curl
  starship
  oh-my-posh
  btop
  cmatrix
  nix-output-monitor
  stow
  lynx
  atuin
  lsd
  openssh
  ranger
  pipes
  pipes-rs
  mlocate
  inxi
  killall
  gawk
  mc
  appimage-run
  steam-run

  # Terminals
  gnome-terminal
  foot
  alacritty
  kitty

  # Web / Gaming / Graphics
  google-chrome
  steam
  gimp
  mangohud

  # Development
  neovim
  vscode
  git
  tig
  meld
  libgcc
  libgccjit
  binutils
  musl
  gcc
  gedit
  ngrok
  jq
  bc

  # Python-Django dev
  python3
  heroku
  postgresql
  python312Packages.pip
  python312Packages.psycopg2
  python312Packages.eggUnpackHook
  python312Packages.eggBuildHook
  python312Packages.eggInstallHook


  # Social Butterfly
  element-desktop
  irssi
  discord
  signal-desktop
  betterdiscordctl


  # Hyprland + Sway
  sway
  waybar     # status bar
  mako       # notification daemon
  libnotify  # for mako
  swww       # wallpaper daemon
  rofi # wl equiv of rofi app launcher, window switcher ...
  wofi
  wofi-emoji
  wofi-power-menu
  networkmanagerapplet # tray applet for network manager -- nm-applet
  grim        # screenshot utility
  grimblast   # grim helper
  udiskie     # automount removable media
  wlogout
  networkmanagerapplet
  mako
  swaybg
  pywal
  swaylock
  hyprlock
  swayidle
  hypridle
  nerdfix
  soteria
  hyprpicker
  hyprshot
  hyprdim

  # Build enviornmentals
  cpio
  cmake

  # Audio
  pavucontrol
  mpd
  cava

  # Sundry
  recoll
  clamav
    # kapitano
  # thunar
  libreoffice-qt6-fresh
    # More fonts
  jetbrains-mono
  iosevka
  nerd-fonts.symbols-only
  babelstone-han
  unetbootin
  _1password-gui

  # gdm rescue 27 July 2025
  gnome-session
  gnome-shell
  gdm
  gnome-control-center
  gnome-shell-extensions
  xterm
];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # X11 & xcb
      xorg.libxshmfence
      xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXrender xorg.libXcursor xorg.libXi
      xorg.libXfixes xorg.libXdamage xorg.libXcomposite xorg.libXinerama
      xorg.libxcb xorg.xcbutil xorg.xcbutilimage xorg.xcbutilkeysyms xorg.xcbutilwm xorg.xcbutilrenderutil

      # Wayland / input
      wayland libxkbcommon

      # GL / GPU
      mesa libdrm
      # (Optionally) vulkan-loader

      # GTK & common deps
      glib gtk3
      zlib expat nspr nss pcre2 libffi
    ];
  };

  # Enabled Packages

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Topbar for WMs
  programs.waybar.enable = true;  # Topbar

  # zsh shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  #Firefox
  programs.firefox.enable = true;

# ----- [ AUTO UPDATES ] ------------------------------
  #system.autoUpgrade.enable = true;
  #system.autoUpgrade.allowReboot = false;

# ----- [ SERVICES and STUFF ] ------------------------------
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  security.rtkit.enable = true;
  services.avahi.enable = false;
  services.printing.enable = true;
  # audio setup
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  swapDevices = [{
    device = "/swapfile";
    size = 48 * 1024; # 48GB
  }];
   # For overclocking AMD GPUs
  #services.lact.enable = true;
  services.openssh.enable = true;
  # "Firmware updating software"
  services.fwupd.enable = true;
  # "Power profiles"
  services.power-profiles-daemon.enable = true;
  # Bluetooth
  # "So, bluetooth is very hackable, but people use it. Not enabled, but you can take the risk. Most people do on their phones, but we are Linux people, and dont like things like that."
  # hardware.bluetooth.enable = true;

# ----- [ FLAKES ] ------------------------------
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# ----- [ FIREWALL ] ------------------------------
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];  # SSH, HTTP, HTTPS
  networking.firewall.allowPing = true;
  networking.firewall.enable = true;
  services.fail2ban.enable = true;

# ----- [ STATE VERSION ] ------------------------------
  system.stateVersion = "24.11" ; # Even if you update, do not change this. You need not understand why, just now that NixOS will kill itself if you do.
  # Did you read this comment? Lol
}
