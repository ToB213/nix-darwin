{ config, pkgs, ... }: {
  home.username = "tob";
  home.homeDirectory = "/Users/tob";
  home.stateVersion = "24.11";

  home.file = {
    ".config/fish/config.fish".source = ./dotfiles/fish/config.fish;
    ".config/fish/conf.d" = {
      source = ./dotfiles/fish/conf.d;
      recursive = true;
    };
    ".config/nvim/init.lua".source = ./dotfiles/nvim/init.lua;
    ".config/nvim/images/logo.png".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix-darwin/home/dotfiles/nvim/images/logo.png";
    ".config/nvim/lua" = {
      source = ./dotfiles/nvim/lua;
      recursive = true;
    };
    ".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
    ".config/btop/btop.conf".source = ./dotfiles/btop/btop.conf;
    ".config/fastfetch/config.jsonc".source = ./dotfiles/fastfetch/config.jsonc;
    ".config/fastfetch/logo".source = ./dotfiles/fastfetch/logo;
    ".gitconfig".source = ./dotfiles/git/gitconfig;
    ".gitcommit".source = ./dotfiles/git/gitcommit;
    ".bashrc".source = ./dotfiles/bash/.bashrc;
  };
}