{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-config/dotfiles";
  tintyData = "${config.xdg.dataHome}/tinted-theming/tinty";
  tintyConfig = "${config.xdg.configHome}/tinted-theming/tinty/config.toml";
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
    tinty
  ];

  xdg.configFile."kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/kitty";

  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/niri";

  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/quickshell";

  xdg.configFile."tinted-theming/tinty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tinted-theming/tinty";

  home.file.".zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshrc";

  home.activation.tintyCatppuccin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tinty_data="${tintyData}"
    tinty_config="${tintyConfig}"
    tinty_repos="$tinty_data/repos"
    tinty_schemes="$tinty_repos/schemes"
    kitty_template="$tinty_repos/kitty"
    niri_template="$tinty_repos/niri"

    mkdir -p "$tinty_schemes/base24" "$tinty_repos"
    cp -f "${pkgs.base24-schemes}/share/themes/catppuccin-latte.yaml" "$tinty_schemes/base24/catppuccin-latte.yaml"
    cp -f "${pkgs.base24-schemes}/share/themes/catppuccin-frappe.yaml" "$tinty_schemes/base24/catppuccin-frappe.yaml"

    rm -rf "$kitty_template" "$niri_template"
    cp -R "${dotfiles}/tinted-theming/tinty/templates/kitty" "$kitty_template"
    cp -R "${dotfiles}/tinted-theming/tinty/templates/niri" "$niri_template"
    chmod -R u+w "$kitty_template" "$niri_template"

    ${pkgs.tinty}/bin/tinty -c "$tinty_config" -d "$tinty_data" build -q "$kitty_template"
    ${pkgs.tinty}/bin/tinty -c "$tinty_config" -d "$tinty_data" build -q "$niri_template"
    ${pkgs.tinty}/bin/tinty -c "$tinty_config" -d "$tinty_data" apply -q base24-catppuccin-latte
  '';

  programs.home-manager.enable = true;
}
