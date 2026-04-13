# Options

Setting these options will change the outcome.

### `modules.desktop.enable`
type: `boolean`
default: `false`
possible values: `true`, `false`

Enables the desktop environment suite, including the niri Wayland compositor (with waybar, hypridle, swaync, cliphist, etc.), GNOME (with PaperWM), and KDE Plasma 6.



### `modules.services.hypridle.desktop`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Sets the desktop config for hypridle (disables brightness changes and suspend). `false` means that hypridle is active and `true` disables the suspend.

### Laptop Power Management

#### `modules.powerManagement.profile`

type: `enum [ "tlp" "ppd" "autoCpuFreq" "none" ]`
default: `none`

Selects the power management tool to use. These are mutually exclusive.
- `tlp`: Enables TLP for laptop power management.
- `ppd`: Enables power-profiles-daemon.
- `autoCpuFreq`: Enables auto-cpufreq.
- `none`: Disables custom power management profiles.

### Applications

These applications are non-essential but specifically configured. They can be toggled on or off.

#### `modules.apps.<name>.enable`
type: `boolean`
default: `false`

Available applications:
- `android-studio`: Android Studio IDE with KVM and ADB support.
- `ausweisapp`: Ausweisapp - german identification software.
- `firefox`: Firefox web browser with custom profile and search engines.
- `mullvad`: Mullvad VPN service.
- `swaync`: Sway Notification Center.
- `vscode`: Visual Studio Code.
- `wireshark`: Wireshark network protocol analyzer.
- `zen-browser`: Zen Browser (Firefox-based).

### Secrets

#### `secrets.enable`

type: `boolean`
default: `false`
possible values: `true`, `false`

Enables the secret-management via sops.

#### `sops.gitConfig`

type: `boolean`
default: `false`
possible values: `true`, `false`

Make sure secrets.enable is activated when using this.

Enables managing the git-data via sops.



