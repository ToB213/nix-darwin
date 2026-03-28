{
  description = "nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager}:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "tob";
      
      nixpkgs.config.allowUnfree = true;
      
      environment.systemPackages = with pkgs; [
        vim
        neovim
        git
        git-lfs
        tree
        wget
        fastfetch
        btop
        go
        nodejs
        direnv
        nix-direnv
        python314
        jdk21
        qemu
        ansible
        cloudflared
        jq
        hugo
        rust-analyzer
        cargo
        rustc
        openldap
        perl
        rustfmt 
        clippy
        pkg-config
        openssl
        libiconv
        fish	
        zoxide
        imagemagick
        ripgrep
        fd
        ruff
        go-task
        uv
        obsidian
        gh
        quarto
        (texlive.combine {
          inherit (texlive)
            scheme-medium
            collection-langjapanese
            collection-latexextra
            luatexja
            lualatex-math
            unicode-math
            ;
        })
        ];
        homebrew = {
        enable = true;
        casks = [
          "docker"
          "kitty"
          "slack"
          "rectangle"
          "discord"
          "spotify"
          "battery"
          "visual-studio-code"
          "font-hack-nerd-font"
          "font-fira-code-nerd-font"
          "font-meslo-lg-nerd-font"
        ];
      };

      users.users.tob.home = "/Users/tob";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.tob = import ./home/home.nix;

      nix.settings.experimental-features = "nix-command flakes";
      nix.extraOptions = ''
        keep-outputs = true
        keep-derivations = true
      '';
      programs.direnv.enable = true;
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          direnv hook fish | source
        '';
      };
      users.users.tob.shell = pkgs.fish;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."tob" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager
      ];
    };
  }; 
}
