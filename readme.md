# KDE Currently Playing

A widget for the Linux Desktop Environment KDE Plasma.

## Features

// TODO

## Installation

// TODO

## Known bug

### Spotify

For some reason, upon the first connection after login, Spotify refuses to send the full track information to `mpris2` data engine, missing out on most info field except for `xesam:url`. This leads to the inability to display info. The problem generally persists until the track changes.

No fix is known to my knowledge as of this moment. The workaround is to switch to previous track and skip back to the following one.