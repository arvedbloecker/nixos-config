# Ranger.nix - Mit eog als Standard-Bildviewer
{ pkgs, username, ... }:
{
  home-manager.users.${username} = { config, ... }: {
    programs.ranger = {
      enable = true;
      
      # rifle-Konfiguration mit eog als ersten (Standard) Bildviewer
      rifle = [
        # PDF-Dokumente
        {
          condition = "ext pdf, has zathura, X, flag f";
          command = "zathura -- \"$@\"";
        }
        {
          condition = "ext pdf, has evince, X, flag f"; 
          command = "evince -- \"$@\"";
        }

        # Bilder - EOG als ERSTER (Standard) Bildviewer
        {
          condition = "mime ^image, has eog, X, flag f";
          command = "eog -- \"$@\"";  # eog zuerst
        }
        {
          condition = "mime ^image, has imv, X, flag f";
          command = "imv -- \"$@\"";  # imv als Backup
        }
        {
          condition = "mime ^image, has feh, X, flag f";
          command = "feh --auto-rotate -- \"$@\"";
        }
        {
          condition = "mime ^image, has sxiv, X, flag f";
          command = "sxiv -a -- \"$@\"";
        }
        # Fallback ohne X-Bedingung (für Wayland)
        {
          condition = "mime ^image, has eog, flag f";
          command = "eog -- \"$@\"";  # eog auch für Wayland
        }
        {
          condition = "mime ^image, has imv, flag f";
          command = "imv -- \"$@\"";
        }
        {
          condition = "mime ^image, has feh, flag f";
          command = "feh --auto-rotate -- \"$@\"";
        }
        
        # Spezielle Bildformate
        {
          condition = "mime ^image/svg, has inkscape, X, flag f";
          command = "inkscape \"$@\"";
        }

        # Videos
        {
          condition = "mime ^video, has mpv, X, flag f";
          command = "mpv -- \"$@\"";
        }
        {
          condition = "mime ^video, has vlc, X, flag f";
          command = "vlc -- \"$@\"";
        }

        # Audio
        {
          condition = "mime ^audio, has mpv, X, flag f";
          command = "mpv -- \"$@\"";
        }

        # Archive
        {
          condition = "ext 7z|ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz|iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool";
          command = "atool --extract --each -- \"$@\"";
        }

        # Textdateien mit helix
        {
          condition = "mime ^text, label editor";
          command = "hx \"$@\"";
        }
        {
          condition = "ext xml|json|csv|tex|py|pl|rb|js|sh|php|nix|md|yml|yaml|toml, label editor";
          command = "hx \"$@\"";
        }

        # Webseiten/HTML
        {
          condition = "ext x?html?, has firefox, X, flag f";
          command = "firefox -- \"$@\"";
        }
        
        # LibreOffice Dokumente
        {
          condition = "ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f";
          command = "libreoffice \"$@\"";
        }

        # Fallback: xdg-open für alles andere
        {
          condition = "label open, has xdg-open";
          command = "xdg-open -- \"$@\"";
        }
      ];
      
      extraConfig = ''
        set preview_files true
        set use_preview_script true
        set preview_images true
        set preview_images_method ueberzug
        set preview_script ~/.config/ranger/scope.sh
        set mouse_enabled false
      '';
    };
    
    # scope.sh Script bleibt unverändert
    home.file.".config/ranger/scope.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        
        set -o noclobber -o noglob -o nounset -o pipefail
        IFS=$'\n'
        
        ## Script arguments
        FILE_PATH="''${1}"         # Full path of the highlighted file
        PV_WIDTH="''${2}"          # Width of the preview pane
        PV_HEIGHT="''${3}"         # Height of the preview pane
        IMAGE_CACHE_PATH="''${4}"  # Full path for image cache
        PV_IMAGE_ENABLED="''${5}"  # 'True' if image previews are enabled
        
        FILE_EXTENSION="''${FILE_PATH##*.}"
        FILE_EXTENSION_LOWER="$(printf "%s" "''${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
        
        handle_extension() {
            case "''${FILE_EXTENSION_LOWER}" in
                ## Archive
                a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
                rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
                    ${pkgs.atool}/bin/atool --list -- "''${FILE_PATH}" && exit 5
                    ${pkgs.libarchive}/bin/bsdtar --list --file "''${FILE_PATH}" && exit 5
                    exit 1;;
                rar)
                    ${pkgs.unrar}/bin/unrar lt -p- -- "''${FILE_PATH}" && exit 5
                    exit 1;;
                7z)
                    ${pkgs.p7zip}/bin/7z l -p -- "''${FILE_PATH}" && exit 5
                    exit 1;;
                    
                ## PDF
                pdf)
                    ${pkgs.poppler_utils}/bin/pdftotext -l 10 -nopgbrk -q -- "''${FILE_PATH}" - | \
                        fmt -w "''${PV_WIDTH}" && exit 5
                    ${pkgs.exiftool}/bin/exiftool "''${FILE_PATH}" && exit 5
                    exit 1;;
                    
                ## JSON
                json)
                    ${pkgs.jq}/bin/jq --color-output . "''${FILE_PATH}" && exit 5
                    python -m json.tool -- "''${FILE_PATH}" && exit 5
                    ;;
            esac
        }
        
        handle_image() {
            local DEFAULT_SIZE="1920x1080"
            local mimetype="''${1}"
            
            case "''${mimetype}" in
                ## SVG
                image/svg+xml|image/svg)
                    ${pkgs.librsvg}/bin/rsvg-convert --keep-aspect-ratio --width "''${DEFAULT_SIZE%x*}" "''${FILE_PATH}" -o "''${IMAGE_CACHE_PATH}.png" \
                        && mv "''${IMAGE_CACHE_PATH}.png" "''${IMAGE_CACHE_PATH}" \
                        && exit 6
                    exit 1;;
                    
                ## Regular images - VERBESSERTE EXIF-Behandlung
                image/*)
                    local orientation
                    orientation="$( ${pkgs.imagemagick}/bin/identify -format '%[EXIF:Orientation]\n' -- "''${FILE_PATH}" 2>/dev/null )"
                    
                    # Prüfe ob EXIF Orientierung existiert und nicht Standard (1) ist
                    if [[ -n "$orientation" && "$orientation" != "1" && "$orientation" != "" ]]; then
                        # Konvertiere mit Auto-Orient
                        ${pkgs.imagemagick}/bin/convert "''${FILE_PATH}" -auto-orient "''${IMAGE_CACHE_PATH}" && exit 6
                    fi
                    
                    # Fallback: Kopiere Originalbild ohne Konvertierung
                    cp "''${FILE_PATH}" "''${IMAGE_CACHE_PATH}" && exit 6
                    exit 7;;
                    
                ## Video
                video/*)
                    ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "''${FILE_PATH}" -o "''${IMAGE_CACHE_PATH}" -s 0 && exit 6
                    ${pkgs.ffmpeg}/bin/ffmpeg -i "''${FILE_PATH}" -map 0:v -map -0:V -c copy "''${IMAGE_CACHE_PATH}" && exit 6
                    exit 1;;
                    
                ## Audio
                audio/*)
                    ${pkgs.ffmpeg}/bin/ffmpeg -i "''${FILE_PATH}" -map 0:v -map -0:V -c copy "''${IMAGE_CACHE_PATH}" && exit 6;;
                    
                ## PDF
                application/pdf)
                    ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 \
                             -scale-to-x "''${DEFAULT_SIZE%x*}" \
                             -scale-to-y -1 \
                             -singlefile \
                             -jpeg -tiffcompression jpeg \
                             -- "''${FILE_PATH}" "''${IMAGE_CACHE_PATH%.*}" \
                        && exit 6 || exit 1;;
            esac
        }
        
        handle_mime() {
            local mimetype="''${1}"
            case "''${mimetype}" in
                ## Text files
                text/* | */xml)
                    if [[ "$( tput colors )" -ge 256 ]]; then
                        local highlight_format='xterm256'
                    else
                        local highlight_format='ansi'
                    fi
                    ${pkgs.highlight}/bin/highlight --out-format="''${highlight_format}" --force -- "''${FILE_PATH}" && exit 5
                    ${pkgs.bat}/bin/bat --color=always --style=plain -- "''${FILE_PATH}" && exit 5
                    exit 2;;
                    
                ## Images (fallback to exif info)
                image/*)
                    ${pkgs.exiftool}/bin/exiftool "''${FILE_PATH}" && exit 5
                    exit 1;;
                    
                ## Video and audio
                video/* | audio/*)
                    ${pkgs.mediainfo}/bin/mediainfo "''${FILE_PATH}" && exit 5
                    ${pkgs.exiftool}/bin/exiftool "''${FILE_PATH}" && exit 5
                    exit 1;;
            esac
        }
        
        handle_fallback() {
            echo '----- File Type Classification -----' && ${pkgs.file}/bin/file --dereference --brief -- "''${FILE_PATH}" && exit 5
        }
        
        ## Main execution
        MIMETYPE="$( ${pkgs.file}/bin/file --dereference --brief --mime-type -- "''${FILE_PATH}" )"
        
        if [[ "''${PV_IMAGE_ENABLED}" == 'True' ]]; then
            handle_image "''${MIMETYPE}"
        fi
        
        handle_extension
        handle_mime "''${MIMETYPE}"
        handle_fallback
        
        exit 1
      '';
    };
    
    home.sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
    
    # Pakete mit eog als primärem Bildviewer
    home.packages = with pkgs; [
      # Preview-Tools
      file
      highlight          
      ueberzugpp          
      librsvg             
      poppler_utils       
      ffmpegthumbnailer   
      ffmpeg              
      imagemagick         
      exiftool            
      atool               
      libarchive          
      unrar               
      p7zip               
      mediainfo           
      bat                 
      jq                  
      
      # Programme zum Öffnen von Dateien
      zathura             # PDF-Viewer
      evince              # GNOME PDF-Viewer 
      
      # Bildviewer - eog als Standard
      eog                 # GNOME Bildviewer (Eye of GNOME) - STANDARD
      imv                 # Wayland-nativer Bildviewer (Backup)
      feh                 # X11 Bildviewer (Backup)
      sxiv                # Simple X Image Viewer (Backup)
      
      mpv                 # Video/Audio-Player
      libreoffice         # Office-Dokumente
      firefox             # Browser
    ];
  };
}
