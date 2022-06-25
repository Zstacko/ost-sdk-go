#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${FRAMEWORKS_FOLDER_PATH+x} ]; then
    # If FRAMEWORKS_FOLDER_PATH is 