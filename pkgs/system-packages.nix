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
    # File and Archive
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
    fastfetch
    # Filesystem
    steam-run
    # Operating System
    glibc
  ];
}
