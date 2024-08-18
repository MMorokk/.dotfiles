{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "morok";
  home.homeDirectory = "/home/morok";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userEmail = "chelton289@gmail.com";
    userName = "MMorokk";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/waybar" = {
      source = ./configs/waybar;
      recursive = true;
      };
    ".config/hypr/hyprland.conf".source = ./configs/hypr/mixed.conf;
    ".config/kitty" = {
      source = ./configs/kitty;
      recursive = true;
      };
    ".config/nvim" = {
      source = ./configs/nvim;
      recursive = true;
    };
    ".librewolf/librewolf.overrides.cfg".source = ./configs/librewolf.cfg;
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/morok/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    DEFAULT_BROWSER = "librewolf";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      spf = "superfile";
    };
  };

  xdg.mimeApps = {
   	enable =  true;
        defaultApplications = {
            "default-web-browser" = [ "librewolf.desktop" ];
            "text/html" = [ "librewolf.desktop" ];
            "x-scheme-handler/http" = [ "librewolf.desktop" ];
            "x-scheme-handler/https" = [ "librewolf.desktop" ];
            "x-scheme-handler/about" = [ "librewolf.desktop" ];
            "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
        };
  };

  # home.pointerCursor = 
  #   let 
  #     getFrom = url: hash: name: {
  #         gtk.enable = true;
  #         x11.enable = true;
  #         name = name;
  #         size = 48;
  #         package = 
  #           pkgs.runCommand "moveUp" {} ''
  #             mkdir -p $out/share/icons
  #             ln -s ${pkgs.fetchzip {
  #               url = url;
  #               hash = hash;
  #             }} $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       "https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic.tar.xz"
  #       "sha256-d162d694e13bec518636b193fbe84ccea44da9a81a89015c6713f6b258ee36d5"
  #       "Nordic";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
