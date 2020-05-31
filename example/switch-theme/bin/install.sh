#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
INSTALLER_PATH="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
INSTALLER_ROOT="$INSTALLER_PATH/../"

printf "Checking if ~/.local/bin/ exists... "
if ! test -d ~/.local/bin; then
    printf "Creating it.\n"
    mkdir -p ~/.local/bin
else
    printf "Ok.\n"
fi

printf "Installing switch-theme.sh into ~/.local/bin/...\n"
cp "$INSTALLER_ROOT"/bin/switch-theme.sh ~/.local/bin/

printf "Installing Konsole profiles into ~/.local/share/konsole/...\n"
mv "$INSTALLER_ROOT"/share/konsole/* ~/.local/share/konsole/

printf "Installing switch-theme-bridge host app"
mkdir -p ~/.mozilla/native-messaging-hosts/
cp "$INSTALLER_ROOT"/share/firefox-extension/native-messaging-app/switch-theme-bridge-host.json
    ~/.mozilla/native-messaging-hosts/switch-theme-bridge-host.json
cp "$INSTALLER_ROOT"/share/firefox-extension/native-messaging-app/switch-theme-bridge-host.py
    ~/.local/bin/

printf "Installing switch-theme-bridge firefox add-on"
firefox ./*.xpi

printf "\nIn the plasmoid settings:\n"
printf " - set On-Script to ~/.local/bin/switch-theme.sh Dark\n"
printf " - set Off-Script to ~/.local/bin/switch-theme.sh Light\n"

printf "\nYou may need to manually set Default.profile as default Konsole profile.\n"