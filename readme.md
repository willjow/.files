## Installation

1. Install homebrew packages with `brew bundle --file brew/Brewfile`

    * `yabai` requires some additional installation steps. See
        - https://github.com/koekeishiya/yabai/wiki
        - https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
        - https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)

    * `skhd` requires accessibility access
        - https://github.com/koekeishiya/skhd

2. Create relevant symlinks with `stow`. (e.g., `stow --no-folding vim`)

### Notes

For `kitty` windows to open in new windows instead of tabs, set "System
Preferences->Dock->Prefer tabs when opening documents" to "Manually."
