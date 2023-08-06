#!/bin/bash

# Source Configs
source $CONFIG

cd /tmp/ci
# Prepare the Build Environment
git clone https://github.com/dblenk-project/kernel_xiaomi_fog_header --depth=1 kernel/xiaomi/fog
source build/envsetup.sh
lunch ${MAKEFILE}-eng
export ALLOW_MISSING_DEPENDENCIES=true
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 20G
ccache -o compression=true
ccache -z
-DLLVM_CCACHE_BUILD=OFF

mka $TARGET

# Exit
exit 0
