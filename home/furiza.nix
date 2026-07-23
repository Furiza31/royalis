{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{
  home.username = "furiza";
  home.homeDirectory = "/home/furiza";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    tree
    kitty
    vscode
    codex
    quickshell
    bun
  ];

  xdg.configFile."kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/kitty";

  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/niri";

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/quickshell";

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";

  programs.home-manager.enable = true;
}
