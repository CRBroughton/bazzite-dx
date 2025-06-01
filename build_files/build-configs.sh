#!/usr/bin/env bash
set -eo pipefail

copy_systemfiles_for() {
    WHAT="$1"
    shift
    DISPLAY_NAME=$WHAT
    if [ "${CUSTOM_NAME}" != "" ] ; then
        DISPLAY_NAME=$CUSTOM_NAME
    fi
    printf "::group:: ===%s-file-copying===\n" "${DISPLAY_NAME}"
    if [ -d "/run/context/$WHAT" ]; then
        cp -avf "/run/context/$WHAT/." /
        echo "Files copied successfully from /run/context/$WHAT"
    else
        echo "Directory /run/context/$WHAT not found"
        ls -la /run/context/ || echo "Context directory not found"
    fi
    printf "::endgroup::\n"
}

echo "=== Copying system files and configs ==="
CUSTOM_NAME="base"
copy_systemfiles_for files
CUSTOM_NAME=
echo "System files and configs complete!"