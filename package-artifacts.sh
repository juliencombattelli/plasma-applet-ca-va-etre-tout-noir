#!/bin/bash

function get_argument {
    local arg1="$2"
    local arg2="$3"
    if [ -n "$arg2" ] && [ ${arg2:0:1} != "-" ]; then
        eval "$1"="$arg2"
    else
        echo "Error: Argument for $arg1 is missing" >&2
        exit 1
    fi
}

PARAMS=""

while (( "$#" )); do
    case "$1" in
        -i|--amo-issuer=)
            get_argument AMO_ISSUER "$1" "$2"
            shift 2
            ;;
        -s|--amo-secret=)
            get_argument AMO_SECRET "$1" "$2"
            shift 2
            ;;
        -p|--plasmoid-name=)
            get_argument PLASMOID_NAME "$1" "$2"
            shift 2
            ;;
        -a|--artifact-name)
            get_argument ARTIFACT_NAME "$1" "$2"
            shift 2
            ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2
            exit 1
            ;;
        *) # preserve positional arguments
            PARAMS="$PARAMS $1"
            shift
            ;;
    esac
done

# set positional arguments in their proper place
#eval set -- "$PARAMS"

###############################################################################
### Prepare artifact temporary folder
###############################################################################
mkdir -p tmp-artifact/bin
mkdir -p tmp-artifact/share/firefox-extension/native-messaging-app
mkdir -p tmp-artifact/share/konsole
mkdir -p tmp-artifact/share/plasmoid

###############################################################################
### Create firefox extension
###############################################################################
EXTENSION_MANIFEST_FILE=./example/switch-theme/share/firefox-extension/switch-theme-bridge/manifest.json
EXTENSION_FOLDER=./example/switch-theme/share/firefox-extension/switch-theme-bridge/web-ext-artifacts

CURRENT_EXT_VERSION=$(sed -n -e 's/.*"version": "\([0-9]\+\.[0-9]\+\)".*/\1/p' $EXTENSION_MANIFEST_FILE)
EXISTING_EXT_VERSIONS=($(ls $EXTENSION_FOLDER | sed 's/.*\([0-9]\+\.[0-9]\+\).*/\1/g'))

# Package and sign the extension if not existing yet
if [[ ! " ${EXISTING_EXT_VERSIONS[@]} " =~ " $CURRENT_EXT_VERSION " ]]; then      
    cd example/switch-theme/share/firefox-extension/switch-theme-bridge
    web-ext sign --api-key=${AMO_ISSUER} --api-secret=${AMO_SECRET}
    cd -
fi

EXTENSION_FILE=$EXTENSION_FOLDER/switch_theme_bridge-$CURRENT_EXT_VERSION-an+fx.xpi

###############################################################################
### Create plasmoid package
###############################################################################
zip -r -FS ${PLASMOID_NAME} package/

###############################################################################
### Create artifact package
###############################################################################
cp example/switch-theme/bin/* tmp-artifact/bin/
cp example/switch-theme/share/konsole/* tmp-artifact/share/konsole/
cp example/switch-theme/share/firefox-extension/native-messaging-app/* tmp-artifact/share/firefox-extension/native-messaging-app/
cp $EXTENSION_FILE tmp-artifact/share/firefox-extension/
mv ${PLASMOID_NAME} tmp-artifact/share/plasmoid/
cd tmp-artifact
zip -r -FS ../${ARTIFACT_NAME} .
cd -

###############################################################################
### Cleanup
###############################################################################
rm -rf tmp-artifact