#!/bin/bash

# Removes ActivDriver versions prior to 5.12.16. 
# This script is pre-requisite for the 5.12.17 install package.

if [ -a /Applications/Promethean/ActivDriver/uninstall ]; then
    echo "Old ActivDriver found, uninstalling..."
    sudo /Applications/Promethean/ActivDriver/uninstall
else
    echo "Old ActivDriver not found, skipping"
fi

if [ -d /Applications/Promethean/ActivDriver/uninstall.app ]; then
    echo "New ActivDriver found, uninstalling..."
    sudo /Applications/Promethean/ActivDriver/uninstall.app/Contents/MacOS/installbuilder.sh --mode unattended
    if [ -d /Applications/Promethean/ActivDriver/uninstall.app ]; then
        echo "New ActivDriver failed to uninstall"
        exit 1
    else
        echo "New ActivDriver successfully uninstalled!"
        exit 0
    fi
else
    echo "New ActivDriver not found, skipping"
    exit 0
fi