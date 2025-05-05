#!/usr/bin/env bash

auto=$(gsettings get org.gnome.desktop.media-handling automount 2>/dev/null)
# -z checks for gnome installed
[[ -z "$auto" || "$auto" = "true" ]] || exit 1

autOpen=$(gsettings get org.gnome.desktop.media-handling automoun-open 2>/dev/null)
[[ -z "$autOpen" || "$autOpen" = "true" ]] || exit 1

exit 0
