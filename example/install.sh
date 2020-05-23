#!/bin/bash

printf "Checking if ~/.local/bin/ exists... "
if ! test -d ~/.local/bin; then
    printf "Creating it.\n"
    mkdir -p ~/.local/bin
else
    printf "Ok.\n"
fi

printf "Installing switch-theme.sh into ~/.local/bin/...\n"
cp ./switch-theme.sh ~/.local/bin/

printf "Installing Konsole profiles into ~/.local/share/konsole/...\n"
mv ./konsole/* ~/.local/share/konsole/

printf "\nIn the plasmoid settings:\n"
printf " - set On-Script to ~/.local/bin/switch-theme.sh Dark\n"
printf " - set Off-Script to ~/.local/bin/switch-theme.sh Light\n"

printf "\nYou may need to manually set Default.profile as default Konsole profile.\n"