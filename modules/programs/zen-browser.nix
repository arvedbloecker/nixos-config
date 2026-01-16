{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    # ...
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    # ...
  ];

in
{
  environment.systemPackages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "Home Manager Options";
                URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
                IconURL = "https://home-manager-options.extranix.com/favicon.ico";
                Alias = "@nh";
              }
              {
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }
              {
                Name = "Youtube";
                URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                IconURL = "https://youtube.com/favicon.ico";
                Alias = "@yt";
              }
              {
                Name = "GitHub Repo Search";
                URLTemplate = "https://github.com/search?q={searchTerms}&type=repositories";
                IconURL = "https://github.com/favicon.ico";
                Alias = "@gh";
              }
              {
                Name = "Perplexity";
                # URLTemplate = "https://www.perplexity.ai/search/?q={searchTerms}";
                URLTemplate = "https://www.perplexity.ai/search?focus=internet&q=%{searchTerms}";
                IconURL = "https://www.perplexity.ai/favicon.ico";
                Alias = "@pp";
              }
              {
                Name = "Codeberg Repositories";
                # URLTemplate = "https://codeberg.org/search?q={searchTerms}&type=repositories";
                URLTemplate = "https://codeberg.org/explore/repos?q={searchTerms}&only_show_relevant=true&sort=recentupdate";
                IconURL = "https://codeberg.org/favicon.ico";
                Alias = "@cb";
              }
              {
                Name = "Crates IO";
                URLTemplate = "https://crates.io/search?q={searchTerms}";
                IconURL = "https://crates.io/favicon.ico";
                Alias = "@rs";
              }
              {
                Name = "Wikipedia (EN)";
                URLTemplate = "https://en.wikipedia.org/w/index.php?search={searchTerms}";
                IconURL = "https://en.wikipedia.org/favicon.ico";
                Alias = "@we";
              }
              {
                Name = "Wikipedia (DE)";
                URLTemplate = "https://de.wikipedia.org/w/index.php?search={searchTerms}";
                IconURL = "https://de.wikipedia.org/favicon.ico";
                Alias = "@wd";
              }
              {
                Name = "Amazon (DE)";
                URLTemplate = "https://www.amazon.de/s?k={searchTerms}";
                IconURL = "https://www.amazon.de/favicon.ico";
                Alias = "@az";
              }
              {
                Name = "Tagesschau (via DDG)";
                URLTemplate = "https://duckduckgo.com/?q=site:tagesschau.de+{searchTerms}";
                IconURL = "https://www.tagesschau.de/favicon.ico";
                Alias = "@ts";
              }
            ];
          };
        };
      }
    )
  ];
}
