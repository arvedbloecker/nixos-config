# A minimal system config that forms the base for all other systems.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = "download-buffer-size = 1073741824"; # 1 GiB
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.fish.enable = true;
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
    man-pages
    man-pages-posix
    # Terminal
    tmux
  ];

  environment.variables.EDITOR = "hx";
}
