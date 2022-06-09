# KDE Currently Playing

A minimal widget for the Linux Desktop Environment KDE Plasma, **Currently Playing** is quiet, undistracting, and straight-forward. It does one thing and one thing alone: display the title and artist of the media currently being played.

The widget was made for personal use following my dissatisfaction with other tools of similar functions for KDE Plasma. A publishing plan is pending.

## Features

- Display of current media using the data engine `mpris2`
- Switch sequence of track title and artist
- Customizable separator string between track title and artist
- Font size settings

## Installation

### KDE Store

The widget is available directly from [the KDE Store](https://store.kde.org/p/1821551), which is accessible from KDE GUI upon adding new widget.

### Local file

Download [the release](https://github.com/JunoNgx/kde-currently-playing/releases), and choose this file upon choosing to add widget from local file.

### Manual installation

Clone this repository, move it to `/home/<your-username>/.local/share/plasma`, logout, and re-login. `Currently Playing` will now appear in your widget list.

## Known bug

### Spotify

Upon startup, Spotify does not properly send the track information to `mpris2` data engine, missing out on most info field except for `xesam:url`. This leads to the inability to display info until the track is changed. This appears to be a bug from the Spotify Linux client`.