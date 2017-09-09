# mediautils
### Requirements for h265:
* ffmpeg

### Requirements for audio2opus:
* ffmpeg
* bash

### Requirements for cuesplit:
* shntools
* cuetools
* flac
* ffmpeg
* monkeys-audio for ape/cue (from deb-multimedia repository)

These are all Debian packages.

### TODO
* Improve --map-args --metadata-args interface of h265
* Have h265 automatically write/delete tags like BPS or encoder
* h265, audio2opus: add a '--misc' argument to preefly pass any argument to ffmpeg.
