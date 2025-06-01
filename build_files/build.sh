#!/usr/bin/env bash
set -eo pipefail

run_buildscripts_for() {
    WHAT="$1"  # Fixed: removed asterisks
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

copy_systemfiles_for() {
    WHAT="$1"  # Fixed: removed asterisks
    shift
    DISPLAY_NAME=$WHAT
    if [ "${CUSTOM_NAME}" != "" ] ; then
        DISPLAY_NAME=$CUSTOM_NAME
    fi
    printf "::group:: ===%s-file-copying===\n" "${DISPLAY_NAME}"
    # Fixed: use the correct mounted path
    if [ -d "/run/context/$WHAT" ]; then
        cp -avf "/run/context/$WHAT/." /
        echo "Files copied successfully from /run/context/$WHAT"
    else
        echo "Directory /run/context/$WHAT not found"
        ls -la /run/context/ || echo "Context directory not found"
    fi
    printf "::endgroup::\n"
}

# Enable podman socket
systemctl enable podman.socket

CUSTOM_NAME="base"
copy_systemfiles_for files  # This will copy from /run/context/files (which is your system_files)
run_buildscripts_for .
CUSTOM_NAME=