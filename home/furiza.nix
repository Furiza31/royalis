{ config, pkgs, ... }:

{
  home.username = "furiza";
  home.homeDirectory = "/home/furiza";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    tree
    kitty
    vscode
  ];

  xdg.configFile."kitty".source = ../dotfiles/kitty;
  xdg.configFile."niri".source = ../dotfiles/niri;
  xdg.configFile.".zshrc".source = ../dotfiles/.zshrc;

  programs.home-manager.enable = true;
}