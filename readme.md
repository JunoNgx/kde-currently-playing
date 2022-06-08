# KDE Currently Playing

A minimal widget for the Linux Desktop Environment KDE Plasma, **Currently Playing** is quiet, undistracting, and straight-forward. It does one thing and one thing alone: display the title and artist of the media currently being played.

The widget was made for personal use following my dissatisfaction with other tools of similar functions for KDE Plasma. A publishing plan is pending.

## Features

- Display of current media using the data engine `mpris2`
- Switch sequence of track title and artist
- Customizable separator string between track title and artist
- Font size settings

## Installation

// TODO

## Known bug

### Spotify

For some reason, upon the first connection after login, Spotify refuses to send the full track information to `mpris2` data engine, missing out on most info field except for `xesam:url`. This leads to the inability to display info. The problem generally persists until the track changes.

No fix is known to my knowledge as of this moment. The workaround is to switch to previous track and skip back to the following one.