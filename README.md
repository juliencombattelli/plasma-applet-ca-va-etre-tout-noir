# Ça va être tout noir

## A configurable On/Off switch plasmoid

A configurable On/Off switch plasmoid for KDE Plasma 5 written in QML.
It is based on [com.github.configurable_button](https://github.com/pmarki/plasmoid-button) and [com.github.intika.on-off-switch-commands](https://github.com/Intika-KDE-Plasmoids/plasmoid-on-off-switch-commands) but uses [plasmacomponents3.Switch](https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents3/Switch.qml) for a better integration with KDE Plasma themes.

It was originally designed to switch between Light and Dark theme, hence its name "ça va être tout noir" (french for it is going to be dark), a famous phrase from the film "RRRrrrr!!!".

## Installation

Install this plasmoid using `plasmapkg2 --install .` in the repository directory.

## Features

Only a few features are implemented for now:
* Custom scripts when turned On and Off
* Persistent switch state (uses the plasmoid configuration to save and restore the state)

## Configuration

The plasmoid can be configured in its Settings menu:
* On-Script: Script or code snippets called when turned on
* Off-Script: Script or code snippets called when turned off

## Images

An in-panel switch On and Off with Breeze Light theme:

![](https://raw.githubusercontent.com/juliencombattelli/plasma-applet-ca-va-etre-tout-noir/master/images/in-panel_breeze-light_on.png) ![](https://raw.githubusercontent.com/juliencombattelli/plasma-applet-ca-va-etre-tout-noir/master/images/in-panel_breeze-light_off.png)

An in-panel switch On and Off with Breeze Dark theme:

![](https://raw.githubusercontent.com/juliencombattelli/plasma-applet-ca-va-etre-tout-noir/master/images/in-panel_breeze-dark_on.png) ![](https://raw.githubusercontent.com/juliencombattelli/plasma-applet-ca-va-etre-tout-noir/master/images/in-panel_breeze-dark_off.png)

The Settings window:

![](https://raw.githubusercontent.com/juliencombattelli/plasma-applet-ca-va-etre-tout-noir/master/images/settings.png)

## Example

An example application is provided in example/ folder. It implements a switch between a Dark and a Light theme working on Plasma, Konsole and Visual Studio Code. Before testing it, be sure to backup your personal data in case of trouble (~/.local/share/konsole/ and ~/.config/Code/User/ folders).

To install the example application, go into example/, run `./install.sh` and follow the instructions.

## Todo

* Publish firefox extension
* Install nativeMessaging python app, theme-switcher.sh in .local/bin
* Install theme watcher file in a persistent directory (.cache/org.github.julien.../theme)

## Credit

* https://github.com/pmarki/plasmoid-button
* https://github.com/Intika-KDE-Plasmoids/plasmoid-on-off-switch-commands
