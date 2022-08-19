#!/bin/bash

project_str=$(curl https://raw.githubusercontent.com/Chowdhury-DSP/BYOD/main/CMakeLists.txt | grep "project(")
plugin_version=$(echo $(echo "$project_str" | awk '{print $NF}') | tr -d ')')

# install
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    plugin_url="https://chowdsp.com/nightly_plugins/BYOD-Linux-x64-${plugin_version}.deb"

    mkdir scratch
    curl -o scratch/installer.deb $plugin_url

    (
        cd scratch
        ar x installer.deb data.tar.xz
        tar xvJf data.tar.xz
    )

    rm -Rf ./plugins/BYOD.vst3
    cp -R scratch/usr/lib/vst3/BYOD.vst3 plugins/BYOD.vst3
    rm -Rf scratch

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac
    plugin_url="https://chowdsp.com/nightly_plugins/BYOD-Mac-${plugin_version}.dmg"
    
    curl -o installer.dmg $plugin_url
    hdiutil attach installer.dmg
    sudo installer -pkg "/Volumes/BYOD-Mac-${plugin_version}/BYOD-signed.pkg" -target /

    sudo rm -f installer.dmg

    rm -Rf ./plugins/BYOD.vst3
    cp -R "/Library/Audio/Plug-Ins/VST3/BYOD.vst3" ./plugins/BYOD.vst3

else
    # Windows
    exit 0
fi
