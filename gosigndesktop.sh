#!/bin/bash
set -e
export TMPDIR="${XDG_RUNTIME_DIR/app/$FLATPAK_ID}"
exec zypak-wrapper /app/extra/lib/gosigndesktop/GoSignDesktop "$@"
