# --> Find File Type
# file --mime-type -b mein_dokument.pdf
# --> Find available Programs
# ls /run/current-system/sw/share/applications/
{ username, ... }:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      # KORREKTUR 1: 'xdg.mimeApps' statt 'xdg.mime'
      xdg.mimeApps = {
        enable = true; # Sicherstellen, dass der Mechanismus aktiv ist
        defaultApplications = {
          "application/pdf" = "zen.desktop";
          "text/plain" = "kitty-open.desktop";
          "text/x-c" = "kitty-open.desktop";
        };
      };
    };
}
