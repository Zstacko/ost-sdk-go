#!/bin/sh
set -e
set -u
set -o pipefail

if [ -z ${FRAMEWORKS_FOLDER_PATH+x} ]; then
    # If FRAMEWORKS_FOLDER_PATH is not set, then there's nowhere for us to copy
    # frameworks to, so exit 0 (signalling the script phase was successful).
    exit 0
fi

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

COCOAPODS_PARALLEL_CODE_SIGN="${COCOAPODS_PARALLEL_CODE_SIGN:-false}"
SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

# Used as a return value for each invo