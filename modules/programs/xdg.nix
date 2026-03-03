# --> Find File Type
# file --mime-type -b mein_dokument.pdf
# --> Find available Programs
# ls /run/current-system/sw/share/applications/
{ username, ... }:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = "org.gnome.Papers.desktop";
          "text/plain" = "kitty-open.desktop";
          "text/x-c" = "kitty-open.desktop";
        };
      };
    };
}
