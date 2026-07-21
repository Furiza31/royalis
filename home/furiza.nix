{ config, pkgs, ... }:

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
    flavours
    quickshell
  ];

  xdg.configFile."kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/kitty";

  xdg.configFile."flavours".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/flavours";

  xdg.dataFile."flavours/.keep".text = "";

  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/niri";

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";

  home.file."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/quickshell";

  programs.home-manager.enable = true;
}
