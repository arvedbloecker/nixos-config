{ pkgs, lib, ... }:

let
  helmRifle = ''
    # Helix für Scripts, Text & Fallback
    ext py,sh,js,rs,ts,java,cpp,txt,md,html = helix -- "{}"
    mime ^text/ = helix -- "{}"
  '';
in
{
  nixpkgs.overlays = [
    (self: super: {
      ranger = super.ranger.overrideAttrs (oldAttrs: rec {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.ed ];
        preConfigure = ''
          # Bildvorschau aktivieren
          substituteInPlace ranger/config/rc.conf \
            --replace "set preview_images false" "set preview_images true" \
            --replace "set preview_images_method w3m" "set preview_images_method ueberzug"

          # Helix-Regeln vorne in rifle.conf einfügen
          ed -s ranger/config/rifle.conf << 'EOF'
0a
${helmRifle}
.
w
EOF
        '';
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    ranger
    ueberzugpp
    librsvg
    poppler
    ffmpegthumbnailer
    helix
  ];

  environment.variables = {
    EDITOR = "helix";
    VISUAL = "helix";
    RANGER_USE_EDIT = "1";
  };
}
