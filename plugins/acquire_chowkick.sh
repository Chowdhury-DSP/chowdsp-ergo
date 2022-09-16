#!/bin/bash

project_str=$(curl https://raw.githubusercontent.com/Chowdhury-DSP/ChowKick/main/CMakeLists.txt | grep "project(")
plugin_version=$(echo $(echo "$project_str" | awk '{print $NF}') | tr -d ')')

# install
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    plugin_url="https://chowdsp.com/nightly_plugins/ChowKick-Linux-x64-${plugin_version}.deb"

    mkdir scratch
    curl -o scratch/installer.deb $plugin_url

    (
        cd scratch
        ar x installer.deb data.tar.xz
        tar xvJf data.tar.xz
    )

    rm -Rf ./plugins/ChowKick.vst3
    cp -R scratch/usr/lib/vst3/ChowKick.vst3 plugins/ChowKick.vst3
    rm -Rf scratch

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac
    plugin_url="https://chowdsp.com/nightly_plugins/ChowKick-Mac-${plugin_version}.dmg"
    
    curl -o installer.dmg $plugin_url
    hdiutil attach installer.dmg
    sudo installer -pkg "/Volumes/ChowKick-Mac-${plugin_version}/ChowKick-signed.pkg" -target /

    sudo rm -f installer.dmg

    rm -Rf ./plugins/ChowKick.vst3
    cp -R "/Library/Audio/Plug-Ins/VST3/ChowKick.vst3" ./plugins/ChowKick.vst3

else
    # Windows
    exit 0
fi
