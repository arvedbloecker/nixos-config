{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Shell
    fish
    # Editor
    helix
    vim
    # Nix-Tools
    nil
    nixfmt-rfc-style
    # Network
    dig
    iftop
    inetutils
    lftp
    tcpdump
    whois
    # Connection
    usbutils
    # File and Archive
    bat
    binwalk
    file
    git
    p7zip
    tree
    unzip
    # Documentation
    #man-pages
    #man-pages-posix
    # Terminal
    tmux
    # Status
    btop
    htop
    powertop
    fastfetch
    # Filesystem
    steam-run
    # Operating System
    glibc


    # High Level Programs
    kdePackages.okular # Dokument Viewer
    kdePackages.dolphin # File Manager
    

    # Rust
    rustc
    cargo
    gcc
    rust-analyzer
    rustfmt
    clippy
    lldb
  ];
}
