{
  description = "Example nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs }:
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
        python314
        jdk17
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
        discord
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
          "spotify"
          "battery"
          "visual-studio-code"
          "font-hack-nerd-font"
          "font-fira-code-nerd-font"
          "font-meslo-lg-nerd-font"
        ];
      };
      nix.settings.experimental-features = "nix-command flakes";
      programs.fish.enable = true;
      users.users.tob.shell = pkgs.fish;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."tob" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
