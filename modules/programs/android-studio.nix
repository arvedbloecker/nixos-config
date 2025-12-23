{
  lib, pkgs, username, ...
}:
{

  users.users.${username}.programs = [
    pkgs.android-studio
  ];
  
  users.users.${username}.extraGroups = [
    "kvm"
    "adbusers"
  ];

  programs.adb.enable = true;
}
