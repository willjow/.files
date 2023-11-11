#!/bin/sh
# DO NOT SYMLINK
# This is intended to be given permission to run withou a password!
# Set keyboard mode to unicode
kbd_mode -fu

# Remove Alt+Left and Alt+Right keymaps for `Incr_Console` and `Decr_Console`
dumpkeys | grep -v -e Incr_Console -e Decr_Console | loadkeys
