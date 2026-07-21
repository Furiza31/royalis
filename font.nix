{ pkgs, ... }:

let
  mkLocalFont =
    {
      pname,
      src,
    }:
    pkgs.stdenvNoCC.mkDerivation {
      inherit pname src;
      version = "local";

      dontUnpack = true;
      dontConfigure = true;
      dontBuild = true;

      installPhase = ''
        runHook preInstall

        fontDirectory="$out/share/fonts/truetype/${pname}"
        mkdir -p "$fontDirectory"

        if ! find "$src" -type f \
          \( -iname '*.ttf' -o -iname '*.otf' \) \
          -print -quit | grep -q .; then
          echo "No TTF or OTF fonts found in $src"
          exit 1
        fi

        find "$src" -type f \
          \( -iname '*.ttf' -o -iname '*.otf' \) \
          -exec install -Dm644 {} "$fontDirectory/" \;

        runHook postInstall
      '';
    };

  googleSans = mkLocalFont {
    pname = "google-sans";
    src = ./fonts/google-sans;
  };

  googleSansCode = mkLocalFont {
    pname = "google-sans-code";
    src = ./fonts/google-sans-code;
  };
in
{
  fonts = {
    enableDefaultPackages = true;

    packages = [
      googleSans
      googleSansCode

      # Icon glyphs without replacing your main text fonts.
      pkgs.nerd-fonts.symbols-only

      # General Unicode and emoji fallback.
      pkgs.noto-fonts
      pkgs.noto-fonts-color-emoji
    ];

    # Improves compatibility with applications expecting a system font path.
    fontDir.enable = true;

    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [
          "Google Sans"
          "Noto Sans"
          "Symbols Nerd Font"
        ];

        monospace = [
          "Google Sans Code"
          "Noto Sans Mono"
          "Symbols Nerd Font Mono"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}