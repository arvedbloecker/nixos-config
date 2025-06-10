{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/gnome.nix # Choose only 1 from desktops
    ../../modules/niri.nix
    ../../modules/tlp.nix
  ];

  networking.hostName = "magpie";

  # Fingerprintreader
  services.fprintd.enable = true;

  environment.etc."pam.d/modules/pam_fprintd.so".source = "${pkgs.fprintd}/lib/security/pam_fprintd.so";

  boot.resumeDevice = "/dev/disk/by-uuid/f846c05e-faa7-4275-8edc-8e8359a526c6";
  boot.kernelParams = [ "resume=/dev/disk/by-uuid/f846c05e-faa7-4275-8edc-8e8359a526c6" ];

  powerManagement.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  systemd.services.hibernate-on-lid = {
    enable = true;
    description = "suspend system on lid close";
    wantedBy = [ "multi-user.target" ];
    script = ''
      while :; do
        grep -q closed /proc/acpi/button/lid/LID/state && systemctl suspend
        sleep 2
      done
    '';
    serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
  };


  users.users.arved = {
    isNormalUser = true;
    description = "Arved Bloecker";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
  };

  # Im Home-Manager oder Shell-Init:
  programs.fish.interactiveShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; and ! pgrep -u $USER niri
      exec niri
    end
  '';

  home-manager.backupFileExtension = "backup";

  environment.systemPackages = with pkgs; [
    # Hier bei bedarf weitere Pakete
  ];
  system.stateVersion = "25.05";
}

