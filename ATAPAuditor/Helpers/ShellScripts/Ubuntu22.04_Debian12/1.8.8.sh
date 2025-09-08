#!/usr/bin/env bash

auto=$(gsettings get org.gnome.desktop.media-handling autorun-never 2>/dev/null)
# -n checks for gnome installed
[[ -n "$auto" && "$auto" != "true" ]] && exit 1

exit 0
