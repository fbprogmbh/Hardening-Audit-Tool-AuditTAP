#!/usr/bin/env bash
# untested - changed settings don't take effect?!

max_lockdelay=5
max_idledelay=900

unit_lockdelay=$(gsettings get org.gnome.desktop.screensaver lock-delay 2>/dev/null)
unit_idledelay=$(gsettings get org.gnome.desktop.session idle-delay 2>/dev/null)

if [[ -n "$unit_lockdelay" && -n "$unit_idledelay"  ]]; then # is gnome installed
    idledelay=$(cut -d ' ' -f 2 <<<"$unit_idledelay")

    [[ $idledelay -gt $max_idledelay || $idledelay -le 0 ]] && exit 1
    [[ $(cut -d ' ' -f 2 <<<"$unit_lockdelay") -gt $max_lockdelay ]] && exit 1
fi

exit 0