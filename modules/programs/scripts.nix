{ pkgs, ... }:
let
  wifi = pkgs.writeShellScriptBin "wifi" ''
    ${pkgs.kitty}/bin/kitty ${pkgs.impala}/bin/impala
  '';

  bluetooth = pkgs.writeShellScriptBin "bluetooth" ''
    ${pkgs.kitty}/bin/kitty ${pkgs.bluetui}/bin/bluetui
  '';

  audio = pkgs.writeShellScriptBin "audio" ''
    ${pkgs.kitty}/bin/kitty ${pkgs.wiremix}/bin/wiremix
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash
    KEY="/org/gnome/desktop/interface/color-scheme"
    CURRENT=$(dconf read "$KEY" 2>/dev/null || echo "")

    KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
    HELIX_CONF="$HOME/.config/helix/config.toml"

    # Zellij Variablen
    ZELLIJ_CONF="$HOME/.config/zellij/config.kdl"
    ZELLIJ_BASE_CONF="$HOME/.config/zellij/config-base.kdl"

    # Umwandeln von Symlink zu absolutem Pfad für Base-Configs
    if [ -L "$ZELLIJ_BASE_CONF" ]; then
      ZELLIJ_BASE_CONF=$(readlink -f "$ZELLIJ_BASE_CONF")
    fi

    if [[ "$CURRENT" == "'prefer-dark'" ]]; then
        # ---------------- LIGHT MODE ----------------
        dconf write "$KEY" "'prefer-light'"
        
        # 1. Kitty
        cp "$HOME/.config/kitty/light-theme.conf" "$KITTY_CONF"

        # 2. Helix
        # Tausche einfach die Theme-Zeile am Anfang der Datei aus!
        sed -i 's/^theme = .*/theme = "ayu_light_transparent"/' "$HELIX_CONF"
        
        # 3. Zellij
        rm -f "$ZELLIJ_CONF"
        echo 'theme "ayu-light"' > "$ZELLIJ_CONF"
        cat "$ZELLIJ_BASE_CONF" >> "$ZELLIJ_CONF"
        
        notify-send "Theme" "Switched to Light mode" 2>/dev/null || echo "Switched to Light"
    else
        # ---------------- DARK MODE ----------------
        dconf write "$KEY" "'prefer-dark'"
        
        # 1. Kitty
        cp "$HOME/.config/kitty/dark-theme.conf" "$KITTY_CONF"

        # 2. Helix
        # Tausche einfach die Theme-Zeile am Anfang der Datei aus!
        sed -i 's/^theme = .*/theme = "ayu_mirage_transparent"/' "$HELIX_CONF"
        
        # 3. Zellij
        rm -f "$ZELLIJ_CONF"
        echo 'theme "ayu-mirage"' > "$ZELLIJ_CONF"
        cat "$ZELLIJ_BASE_CONF" >> "$ZELLIJ_CONF"
        
        notify-send "Theme" "Switched to Dark mode" 2>/dev/null || echo "Switched to Dark"
    fi

    # Kitty Live Reload
    for socket in /tmp/kitty-*; do
      ${pkgs.kitty}/bin/kitty @ --to "unix:$socket" load-config 2>/dev/null || true
    done

    # Helix Live Reload
    pkill -USR1 -x hx || true
  '';

  script-selector = pkgs.writeShellScriptBin "script-selector" ''
    SCRIPTS="wifi\nbluetooth\naudio\ntoggle-theme"

    CHOICE=$(echo -e "$SCRIPTS" | ${pkgs.wofi}/bin/wofi -d -p "Select Script:")

    if [ -n "$CHOICE" ]; then
      exec "$CHOICE"
    fi
  '';
in
{
  environment.systemPackages = [
    wifi
    bluetooth
    audio
    toggle-theme
    script-selector
  ];
}
