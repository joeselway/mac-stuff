#!/bin/bash

# Installs ActivDriver assuming that /activdriver-5.12.17-osx-installer-x64 exists in /.
# Requires that previous version has been uninstalled first.

/activdriver-5.12.17-osx-installer-x64.app/Contents/MacOS/installbuilder.sh --mode unattended

if [ -d /Applications/Promethean/ActivDriver/uninstall.app ]; then
    echo "Install appears to have been successful, removing installation files..."
    rm -rf /activdriver-5.12.17-osx-installer-x64.app
    rm -rf /Applications/Promethean/ActivDriver/rollbackBackupDir*
    echo "Finished removing installation files."
    exit 0
else echo "Install appears to have failed, leaving installation files."
    exit 1
fi
