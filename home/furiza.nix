{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
in
{
  home.username = "furiza";
  home.homeDirectory = "/home/furiza";

  home.stateVersion = "26.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    tree
    kitty
    vscode
    codex
    quickshell
    bun

    (stdenvNoCC.mkDerivation {
      pname = "local-custom-fonts";
      version = "1.0";
      src = ../fonts;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        
        # Copies all TTF files from your fonts folder and subfolders
        find $src -type f -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;
      '';
    })
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
