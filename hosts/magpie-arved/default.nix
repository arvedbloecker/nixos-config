# Custom Settings for each user/pc that might be very individual. It only needs the import of ./hardware-configuration.nix as a bare minimum.
{
  inputs,
  pkgs,
  username,
  nixos-hardware,
  ...
}:

{
  imports = [
    ./config.nix
    ./hardware-configuration.nix
    ./kanshi.nix

    nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
  ];

  secrets.enable = true;

  users.users.${username}.packages = with pkgs; [
    discord

    android-studio
    ausweisapp
    bitwarden-desktop
    brave
    element-desktop
    fwupd
    nextcloud-client
    obsidian
    onlyoffice-desktopeditors
    qemu
    signal-desktop
    simple-scan
    spotify
    # texliveFull
    thunderbird
    vscode
    zotero

    eog
    evince
    gnome-sound-recorder
    gnome-text-editor

    cargo
  ];

  programs.nix-ld.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.ausweisapp.enable = true;
  programs.ausweisapp.openFirewall = true;

  # Thinkpad Specific Power Management Features
  services.thermald.enable = true;

  # AMD GPU Power Management
  hardware.amdgpu.opencl.enable = true;

  # Fingerprintreader
  #services.fprintd.enable = true;

  # Pin on Linux Version 6.12
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
