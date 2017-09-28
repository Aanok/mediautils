# mediautils
### Requirements for h265:
* ffmpeg

### Requirements for audio2opus:
* ffmpeg
* bash

### Requirements for cuesplit:
* shntool
* cuetools
* flac
* ffmpeg
* monkeys-audio for ape/cue (from deb-multimedia repository)

These are all Debian packages.

### TODO
* Improve --map-args --metadata-args interface of h265
* Have h265 automatically write/delete tags like BPS or encoder
* h265: add a filter for blackbanding in case of resize
* h265, audio2opus: add a '--misc' argument to pass any argument to ffmpeg.
* Add a makefile with installation and uninstallation.
