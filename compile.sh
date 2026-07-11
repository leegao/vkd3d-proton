#!/bin/bash

PFX_SYS32="$HOME/.steam/steam/steamapps/compatdata/2787078460/pfx/drive_c/windows/system32"
BUILD_DIR="vkd3d-proton-build/x64"

restore_backups() {
    echo "Restoring original DLLs..."
    for file in d3d12 d3d12core; do
        if [ -f "$PFX_SYS32/${file}.dll.orig" ]; then
            mv "$PFX_SYS32/${file}.dll.orig" "$PFX_SYS32/${file}.dll"
            echo "Restored ${file}.dll"
        else
            echo "No backup found for ${file}.dll"
        fi
    done
}

if [ "$1" == "--restore" ]; then
    restore_backups
    exit 0
fi

bash build_win64.sh

if [ ! -f "$PFX_SYS32/d3d12.dll.orig" ]; then
    if [ -f "$PFX_SYS32/d3d12.dll" ]; then
        cp "$PFX_SYS32/d3d12.dll" "$PFX_SYS32/d3d12.dll.orig"
        echo "Backed up d3d12.dll.orig"
    fi
fi
cp "$BUILD_DIR/d3d12.dll" "$PFX_SYS32/"

if [ ! -f "$PFX_SYS32/d3d12core.dll.orig" ]; then
    if [ -f "$PFX_SYS32/d3d12core.dll" ]; then
        cp "$PFX_SYS32/d3d12core.dll" "$PFX_SYS32/d3d12core.dll.orig"
        echo "Backed up d3d12core.dll.orig"
    fi
fi
cp "$BUILD_DIR/d3d12core.dll" "$PFX_SYS32/"

echo "COMPAT_LOG_LEVEL=info,error ENABLE_DXVK_MALI_COMPAT_LAYER=1 VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation bash wine.sh"
