#!/usr/bin/env bash

auto=$(gsettings get org.gnome.desktop.media-handling automount 2>/dev/null)
# -n checks for gnome installed
[[ -n "$auto" && "$auto" != "false" ]] && exit 1

autOpen=$(gsettings get org.gnome.desktop.media-handling automoun-open 2>/dev/null)
[[ -n "$autOpen" && "$autOpen" != "false" ]] && exit 1

exit 0
