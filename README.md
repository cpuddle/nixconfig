# cpuddle's Nixos Configuration


## Directory Structure
```
├── assets
│   ├── shodan-grub-theme
│   │   └── Shodan.zip
│   └── wallpapers
│       └── outer-wilds-4k.png
├── bin
│   ├── default.nix
│   ├── dwl-start.nix
│   ├── email.nix
│   ├── music-restart.nix
│   ├── powermenu.nix
│   ├── rmpc-launch.nix
│   ├── screenshot.nix
│   ├── volume.nix
│   └── waybar-reload.nix
├── core
│   ├── coding
│   │   └── default.nix
│   ├── default.nix
│   ├── dwl
│   │   ├── default.nix
│   │   └── src
│   ├── firefox
│   │   └── default.nix
│   ├── fonts
│   │   ├── default.nix
│   │   ├── monospace
│   │   │   ├── default.nix
│   │   │   ├── iosevka.nix
│   │   │   ├── iosevka-term-slab.nix
│   │   │   └── jetbrains-mono.nix
│   │   ├── sans
│   │   │   ├── default.nix
│   │   │   └── ibm-plex-sans-condensed.nix
│   │   └── serif
│   │       ├── default.nix
│   │       └── libre-baskerville.nix
│   ├── foot
│   │   └── default.nix
│   ├── greetd
│   │   └── default.nix
│   ├── grub
│   │   └── default.nix
│   ├── pipewire
│   │   └── default.nix
│   ├── polkit
│   │   └── default.nix
│   ├── sh
│   │   └── default.nix
│   ├── ssh
│   │   └── default.nix
│   ├── stylix
│   │   └── default.nix
│   └── xdg
│       └── default.nix
├── flake.lock
├── flake.nix
├── home
│   ├── aerc
│   │   ├── config
│   │   │   ├── accounts.conf
│   │   │   ├── aerc.conf
│   │   │   └── binds.conf
│   │   └── default.nix
│   ├── core
│   │   └── default.nix
│   ├── default.nix
│   ├── discord
│   │   └── default.nix
│   ├── fonts
│   │   └── default.nix
│   ├── foot
│   │   ├── config
│   │   │   ├── foot.ini
│   │   └── default.nix
│   ├── git
│   │   └── default.nix
│   ├── goimapnotify
│   │   ├── config
│   │   │   └── goimapnotify.yaml
│   │   └── default.nix
│   ├── gtk
│   │   └── default.nix
│   ├── mako
│   │   ├── config
│   │   │   └── config
│   │   └── default.nix
│   ├── mpd
│   │   ├── config
│   │   │   └── config.ron
│   │   └── default.nix
│   ├── nvim
│   │   ├── config
│   │   │   ├── init.lua
│   │   │   ├── lazy-lock.json
│   │   │   └── lua
│   │   │       ├── options.lua
│   │   │       ├── plugins
│   │   │       │   ├── autopairs.lua
│   │   │       │   ├── comments.lua
│   │   │       │   ├── gruvbox.lua
│   │   │       │   ├── lualine.lua
│   │   │       │   ├── markdown.lua
│   │   │       │   ├── neo-tree.lua
│   │   │       │   └── treesitter.lua
│   │   │       └── plugins.lua
│   │   └── default.nix
│   ├── qt
│   │   └── default.nix
│   ├── rofi
│   │   ├── config
│   │   │   ├── config.rasi
│   │   │   └── gruvbox-dark.rasi
│   │   └── default.nix
│   ├── sh
│   │   └── default.nix
│   ├── waybar
│   │   ├── config
│   │   │   ├── config.jsonc
│   │   │   ├── scripts
│   │   │   │   └── wireplumber_label.sh
│   │   │   └── style.css
│   │   └── default.nix
│   └── zathura
│       ├── config
│       │   └── zathurarc
│       └── default.nix
├── hosts
│   └── proxima
│       ├── default.nix
│       ├── hardware.nix
│       └── networking.nix
├── lib
│   └── auto-import.nix
├── overlays
│   └── default.nix
├── pkgs
│   └── shodan-grub-theme.nix
└── secrets.yaml

```
