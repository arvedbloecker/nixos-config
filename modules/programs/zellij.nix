#Zellij is a terminal multiplexer
{ pkgs, username, ... }:

let
  # Vollständige, benutzerdefinierte Zellij-Konfiguration in KDL
  zellijConfig = ''
    theme "ayu-mirage";
    copy_on_select true;
    default_mode "locked"; 

    keybinds {
      shared {
        bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; };
        bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; };
        bind "Alt j" "Alt Down" { MoveFocus "Down"; };
        bind "Alt k" "Alt Up" { MoveFocus "Up"; };
        bind "Alt f" { ToggleFloatingPanes; };
        bind "Alt n" { NewPane; };
        bind "Alt [" { PreviousSwapLayout; };
        bind "Alt ]" { NextSwapLayout; };
      };
    };

    show_release_notes true;
    show_startup_tips false;

    // Platzsparende UI-Optionen
    pane_frames false;
    default_layout "compact";
    simplified_ui true;

    ui {
      pane_frames { hide_session_name true; };
    };
  '';
in
{
  home-manager.users.${username} = { config, pkgs, ... }:
  {
    # Zellij aktivieren mit Fish-Integration
    programs.zellij = {
      enable                = true;
      enableFishIntegration = true;
    };

    # Zellij automatisch starten bei Fish-Login
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        if status is-interactive
          eval (zellij setup --generate-auto-start fish)
        end
      '';
    };

    # Schreibe die komplette KDL-Konfiguration
    home.file.".config/zellij/config.kdl" = {
      text = zellijConfig;
    };
  };
}
