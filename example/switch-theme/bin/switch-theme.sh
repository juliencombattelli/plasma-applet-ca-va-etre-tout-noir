#!/bin/bash

THEME=$1

if [ "$THEME" = "Light" ]; then
    LAF=org.kde.breeze.desktop
    KONSOLE_PROFILE=Light
    VSCODE_THEME="Default Light+"
elif [ "$THEME" = "Dark" ]; then
    LAF=org.kde.breezedark.desktop
    KONSOLE_PROFILE=Dark
    VSCODE_THEME="Default Dark+"
else
    echo "Error: Theme must be 'Light' or 'Dark'"
    exit 1
fi

# Set lookandfeel
lookandfeeltool -a $LAF

# Set Konsole profile for new instances
sed -i "s/Parent=.*/Parent=$KONSOLE_PROFILE/" ~/.local/share/konsole/Default.profile

# Set Konsole profile for all sessions in all existing konsole instances
for konsole_instance in $(pidof konsole); do
    session_list=$(qdbus org.kde.konsole-$konsole_instance /Windows/1 org.kde.konsole.Window.sessionList)
    for konsole_session in $session_list; do
        qdbus org.kde.konsole-$konsole_instance /Sessions/$konsole_session setProfile $KONSOLE_PROFILE
    done
done

# Set Konsole profile for all sessions in all existing dolphin instances
for dolphin_instance in $(pidof dolphin); do
    session_list=$(qdbus org.kde.dolphin-$dolphin_instance /Windows/1 org.kde.konsole.Window.sessionList)
    for konsole_session in $session_list; do
        qdbus org.kde.dolphin-$dolphin_instance /Sessions/$konsole_session setProfile $KONSOLE_PROFILE
    done
done

# Update VSCode theme
VSCODE_SETTINGS_FILE=~/.config/Code/User/settings.json
if ! test -f $VSCODE_SETTINGS_FILE; then # If setting file does not exist
    printf "{\n    \"workbench.colorTheme\": \"$VSCODE_THEME\"\n}\n" > $VSCODE_SETTINGS_FILE
elif ! grep "workbench\.colorTheme" $VSCODE_SETTINGS_FILE &>/dev/null; then # If theme setting is not set
    fileLength=$(wc -l $VSCODE_SETTINGS_FILE | cut -d' ' -f1); \
    sed -i "$((fileLength-1))s/$/,/; ${fileLength}i \ \ \ \ \"workbench.colorTheme\": \"$VSCODE_THEME\"" $VSCODE_SETTINGS_FILE
else # If theme setting already sets
    sed -i "s/\(workbench.colorTheme.*\"\).*\(\".*\)/\1$VSCODE_THEME\2/" $VSCODE_SETTINGS_FILE
fi

# Update setting file for watchers
mkdir -p ~/.cache/com.github.juliencombattelli.caVaEtreToutNoir/theme
echo $THEME > ~/.cache/com.github.juliencombattelli.caVaEtreToutNoir/theme/setting
