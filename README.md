# Welcome to my NixOS-Config

This config has been inspired by the configuration from [Géza Ahsendorf](https://codeberg.org/DynamicGoose?tab=repositories). Thank you for providing such a solid and good starting point!

## Creating a Profile - Quickstart

### Step 1 - Create the Profile in flake.nix

Copy the following code into `flake.nix`:

```
configuration-name = {
  username = "username";
  hashedPassword = "hashedPassword"; # Generate the password with mkpasswd

  # Optional values

  # Define the name of the user
  # userDescription = "Your Name";

  # Define the hostname
  # hostname = "hostname";
};
```

### Step 2 - Add the folder and default.nix

Create a new folder in `hosts/configuration-name`.

This folder needs a `default.nix` with the following code:

```
{ config, pkgs, username, ...}:
{
  imports = [
    ./hardware-configuration.nix

    # If you want a configuration, import it here
    # ./config.nix
  ];

  users.users.${username}.packages = with pkgs; [

    # The programs you want to install
    thunderbird
    vscode
  ];
}
```

### Step 3 - Copy hardware-configuration.nix

The last step is to copy the file `hardware-configuration.nix` from `/etc/nixos/hardware-configuration` to `nixos-config/hosts/configuration-name/hardware-configuration.nix`. Your system should work from this point on by running the command `sudo nixos-rebuild switch --flake .#configuration-name`. Make sure that you are in the folder with `flake.nix` or in a child folder when executing the command.

When setting up your system for the first time, make sure that you have activated `nix.settings.experimental-features = [ "nix-command" "flakes" ]`, so that the flake can be used.

### Step 4 (Optional) - Look at options.md

To accommodate different requirements in use cases and architectures, there are options that can be disabled and enabled. These options are listed in `options.md`. To use them, create the file `config.nix` in `hosts/configuration-name` and import it in `default.nix`, which you created in Step 2.

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

## Structure of this Project

```
  .
  ├── default.nix
  ├── flake.nix
  ├── hosts
  │   └── magpie-arved
  ├── lib
  ├── modules
  │   ├── core ──>
  │   ├── default.nix
  │   ├── desktop ──>
  │   ├── home-manager.nix
  │   ├── nix.nix
  │   ├── programs ──>
  │   ├── services ──>
  │   └── users.nix
  ├── options.md
  ├── pkgs
  │   ├── theme
  │   └── wallpaper
  └── secrets.yaml
```

### flake.nix

This is the central file where external inputs are defined and where devices are configured after being added to `hosts/`. Further general configurations are in `lib/` to keep the `flake.nix` minimal and to maintain an easy overview.

### modules/

This is the heart of the configuration. Here, program-specific and core utilities are defined. There are four central subfolders: `core`, `desktop`, `programs`, and `services`.

- `core/` defines the central utilities that should be included from the start on all systems.
- `desktop/` defines the desktop environments. `niri.nix` is the core file and defines how to interact with the system. Take a look at the **hotkeys** defined here.
- `services/` is the folder for many relevant services that we use for a good experience with our system. `Audio.nix`, `printing.nix`, and `waybar.nix` are just some of the relevant services and programs that I don't want to miss.
- `programs/` defines and configures core programs for the system and sets further settings beyond simply installing them in the `hosts/` folder.

Every folder has a `default.nix` that tells the flake which `.nix` files to include. By modifying this file, you can include your own custom files.

### hosts/

When you want to add a new device with this specific config, you can add it to hosts. In theory, it just needs a `default.nix` stored in `hosts/<device-name>/default.nix`. Here you define system-specific settings that can be included in `.nix` files or by using `config.nix`. The hardware configuration should also be stored here.

### pkgs/

Non-Nix files are stored here. Themes and wallpapers are currently stored here.

## Important Keybindings

`Super` + `Key` triggers actions from Niri that are defined in `modules/desktop/niri.nix`. Take a look there to see all Keybindings related to Niri. Important Bindings are:
- `Super + P`: Open Firefox
- `Super + E`: Open Shell
- `Super + H|J|K|L`: Navigation between Tabs and Workspaces
- `Super + Ctrl + H|J|k|L`: Move Windows between Tabs and Workspaces
- `Super + R`: Resize Windows
- `Super + [|]`: Stack Windows onto each other

`Alt` + `Key` INSIDE THE SHELL triggers normally the Zellij-Commands. Take a look at their website, since there are only very few custom bindings. Zellij starts in the locked-mode to not interfere with Helix-Keybindings.
- `Alt + F`: Open Floating Shell
- `Alt + T`: New Tab
- `Alt + N`: New Tab in split Window
- `CTRL + G`: Exit Locked Mode

