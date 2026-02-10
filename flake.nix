{
  description = "Example nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable }:
  let
    configuration = { pkgs, ... }: 
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "aarch64-darwin";
      };
    in
    {
      environment.systemPackages = with pkgs; [
        vim
        pkgs-unstable.neovim
        git
        git-lfs
        tree
        wget
        fastfetch
        btop
        go
        nodejs
        pkgs-unstable.python314  # unstable から Python 3.14
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
        (nerdfonts.override { fonts = [ "Hack" "FiraCode" "Meslo" ]; })
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
