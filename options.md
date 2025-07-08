# Options

Setting these options will change the outcome.

### `modules.desktop.plasma.enable`
type: `boolean`
default: `false`
possible values: `true`, `false`

Enables the Plasma6 Desktop environment.


### `modules.services.hypridle.desktop`
type: `boolean`  
default: `false`  
possible values: `true`, `false`  
  
Sets the desktop config for hypridle (disables brightness changes and suspend). `false` means that hypridle is active and `true` disables the suspend.

### Laptop Power Management

It is recommended to use only one of the three available options, otherwise they will get in conflict with each other.

#### `modules.powerManagement.tlp.enable`

type: boolean
default: false
possible values: true, false

Enables tlp (for laptop power-management).

#### `modules.powerManagement.ppd.enable`

type: boolean
default: false
possible values: true, false

Enables power-profiles-daemon (for laptop power-management)

#### `modules.powerManagment.autoCpuFreq.enable`

type: `boolean`
default: `false`
possible values: `true`, `false`

Enables autoCpuFreq (for laptop power-management).
