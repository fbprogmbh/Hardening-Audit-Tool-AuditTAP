#!/usr/bin/env bash
# untested - changed settings don't take effect?!

max_lockdelay=5
max_idledelay=900

unit_lockdelay=$(gsettings get org.gnome.desktop.screensaver lock-delay)
unit_idledelay=$(gsettings get org.gnome.desktop.session idle-delay)

idledelay=$(cut -d ' ' -f 2 <<<"$unit_idledelay")

[[ $idledelay -gt $max_idledelay || $idledelay -le 0 ]] && exit 1
[[ $(cut -d ' ' -f 2 <<<"$unit_lockdelay") -gt $max_lockdelay ]] && exit 1

exit 0