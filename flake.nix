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
        fish	
        zoxide
        imagemagick
        ripgrep
        fd
        ruff
        go-task
        uv
        obsidian
        nerd-fonts.hack
        nerd-fonts.fira-code
        nerd-fonts.meslo-lg
      ];
      homebrew = {
        enable = true;
        brews = [];
        casks = [
          "docker"
          "kitty"
          "slack"
          "rectangle"
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
