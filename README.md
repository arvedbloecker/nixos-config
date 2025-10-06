Welcome to my NixOS-Config. This Config has been inspired by the configuration from [Géza Ahsendorf](https://codeberg.org/DynamicGoose?tab=repositories). Thank you for providing such a solid and good starting-point!

# Creating a Profile

## Step 1 - Create the Profile in flake.nix

Copy in `flake.nix` the following code:

```
configuration-name = {
  username = "username";
  hashedPasswort = "hashedPasswort" # Generate the Password with mkpasswd

  # Optional values

  # Define the name of the User
  # userDescription = "Your Name";

  # Define the hostname
  # hostname = "hostname";

  # Set git setting
  # gitUsername = "gitUsername";
  # gitEmail = "your-git@mail.com";
};
```

## Step 2 - Add the folder and default.nix

Create a new Folder in `hosts/configuration-name`.

This folder needs a `default.nix`, with the following code:

```
{ config, pkgs, username, ...}:
{
  imports = [
    ./hardware-configuration.nix

    # If you want a configuration, import it here
    # ./config.nix
  ];

  users.users.${username}.packages = with pkgs; [

    # The Programs you want to install
    thunderbird
    vscode
  ];
}
```

## Step 3 - Copy hardware-configuration.nix

The last step is to copy the file `hardware-configuration.nix` from `etc/nixos/hardware-configuration` to `nixos-config/hosts/configuration-name/hardware-configuration.nix`. Your system should work from now by running the command `sudo nixos-rebuild switch --flake .#configuration-name`. Make sure that you are in the folder with the `flake.nix` or in a child-folder when executing the command.

When setting your system for the first time up, make sure that you have activated `nix.setting.experimental-features = [ "nix-command" "flakes "]`, so the flake can be used.

## Step 4 (Optional) - Look at options.md

To accomodate different requirements in the usecases and the architecture, there will be options that can be disabled and enabled. Those options are listed in `options.md`. To use them create the file `config.nix` in the folder with `hosts/configuration-name` and import it in `default.nix`, which you created in Step 2.

The `config.nix` should look like this:

```
{
  username, ...
}:
{
  # List here all the configs that you want to set.
  # modules.desktop.plasma.enable = true;
}
```
