{ username, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit
  ];

  home-manager.users.${username} =
    { config, pkgs, ... }:
    {

      programs.helix = {
        enable = true;

        settings = {
          theme = "ayu_mirage_transparent";

          editor = {
            soft-wrap = {
              enable = true;
              max-wrap = 25;
            };
            bufferline = "always";
            whitespace = {
              render = "all";
              characters = {
                tab = "→";
                space = "·";
              };
            };
          };

          # Open Website with Git
          keys.normal."C-n" =
            ":sh ${config.home.homeDirectory}/.config/helix/open-blame-github %{buffer_name}";
          # Small git blame
          keys.normal."C-b" =
            ":sh git log -n 5 --format='format:%%h (%%an: %%ar) %%s' --no-patch -L%{cursor_line},+1:%{buffer_name}";
          # Open Lazygit
          keys.normal."C-m" = [
            ":write-all"
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
            ":reload-all"
          ];
        };

        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "nixfmt";
              };
              auto-format = true;
            }
          ];
        };

        themes = {
          ayu_mirage_transparent = {
            "inherits" = "ayu_mirage";
            "ui.background" = { };
            "ui.linenr" = "gray";
            "ui.linenr.selected" = "foreground";
            "ui.whitespace" = {
              fg = "gray";
            };
            "ui.selection" = {
              bg = "#264563";
            };
          };
        };
      };

      home.file.".config/helix/open-blame-github" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          FILE="$1"

          # Git Remote URL auslesen
          REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null)

          if [ -z "$REMOTE_URL" ]; then
            echo "Kein Git-Repository gefunden"
            exit 1
          fi

          # URL normalisieren (ssh zu https konvertieren)
          if [[ $REMOTE_URL == git@* ]]; then
            HOST=$(echo "$REMOTE_URL" | grep -oP '(?<=@)[^:]+')
            REPO=$(echo "$REMOTE_URL" | grep -oP '(?<=:).*')
            REPO="''${REPO%.git}"

            case "$HOST" in
              codeberg-*) HOST="codeberg.org" ;;
              github-*) HOST="github.com" ;;
              gitlab-*) HOST="gitlab.com" ;;
            esac

            REMOTE_URL="https://$HOST/$REPO"
          else
            REMOTE_URL="''${REMOTE_URL%.git}"
          fi

          COMMIT=$(git blame -L 1,+1 -- "$FILE" 2>/dev/null | awk '{print $1}' | sed 's/\^//' | head -c 7)

          if [ -n "$COMMIT" ] && [ "$COMMIT" != "00000000" ]; then
            URL="''${REMOTE_URL}/commit/$COMMIT"
            xdg-open "$URL"
          else
            echo "Kein Commit gefunden"
          fi
        '';
      };

      home.sessionPath = [
        "$HOME/.local/bin"
      ];
    };
}
