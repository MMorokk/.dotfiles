# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/gaming.nix
      ./modules/nvidia.nix
      ./modules/keyboard.nix
      #./modules/monero.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];

  networking.hostName = "NixDesktop"; # Define your hostname.
  services.mullvad-vpn.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  fonts = {
    packages = [ pkgs.nerdfonts ];
    fontDir.enable = true;
    };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  services.displayManager ={ 
    sddm.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      cinnamon.enable = true;
      xterm.enable = false;
      xfce.enable = false;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    };
  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, pl, ua";
#    xkbVariant = "";
    options = "grp:alt_shift_toggle";
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-experimental;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
	      Name = "NixDesktop";
        ControllerMode = "dual";
	      FastConnectable = "true";
	      Experimental = "true";
	      KernelExperimental = "true";
      };
      Policy.AutoEnable = "true";
    };
    input = {
      General = {
      ClassicBondedOnly = true;
      IdleTimeout = 30;
      UserspaceHID=true;
        };
      };
  };
  services.blueman.enable = true;
  hardware.enableAllFirmware = true;

  services.udev = {
    enable = true;
    extraRules = 
    ''
    # PS5 DualSense controller over USB hidraw 
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess" 
    # PS5 DualSense controller over bluetooth hidraw 
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess" 
    # Cheapino Keyboard / Vial settings
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    # Backligth
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="nvidia_0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morok = {
    isNormalUser = true;
    description = "Morok";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gh
    nixd
    alejandra
    lua-language-server
    stylua
    units
    telegram-desktop
    signal-desktop
    pwvucontrol
    linuxKernel.packages.linux_zen.lenovo-legion-module
    lenovo-legion
    polkit_gnome
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    mullvad-vpn
    jstest-gtk
    kitty
    bashmount
    wofi
    waybar
    mpvpaper
    gammastep
    librewolf
    killall
    btop
    dualsensectl
    vesktop
    superfile
    qbittorrent
    mpv
    mpvc
    prusa-slicer
    protonup-ng
    freecad
    ungoogled-chromium
    brillo
    playerctl
    git
    gnumake
    keepassxc
    monero-cli
    monero-gui
    tor-browser
    prismlauncher
    orca-slicer
    super-slicer-latest
    bitwarden-desktop
    kicad
    ghidra
    libreoffice
    anki
    plasticity
    grim
    slurp
    wl-clipboard-rs
    ripgrep
    fd
    gcc
    ];

  services.displayManager = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable OpenGL (Alredy in nvidia.nix)
  # hardware.graphics = {
  #   enable = true;
  # };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
