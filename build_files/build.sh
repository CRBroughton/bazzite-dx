#!/usr/bin/env bash
set -eo pipefail

run_buildscripts_for() {
    WHAT="$1"
    shift
    find "/run/context/build_files/$WHAT" -maxdepth 1 -iname "*-*.sh" -type f -print0 | sort --zero-terminated --sort=human-numeric | while IFS= read -r -d $'\0' script ; do
        if [ "${CUSTOM_NAME}" != "" ] ; then
            WHAT=$CUSTOM_NAME
        fi
        printf "::group:: ===%s-%s===\n" "$WHAT" "$(basename "$script")"
        "$script"
        printf "::endgroup::\n"
    done
}

echo "=== Installing heavy packages ==="
systemctl enable podman.socket
run_buildscripts_for .
echo "Heavy packages installation complete!"