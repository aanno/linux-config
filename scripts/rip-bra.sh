#!/bin/bash

# BD general
# http://negativo17.org/bluray-playback-and-ripping-on-fedora-aacs-bd-bd-j/
# http://askubuntu.com/questions/755323/blu-ray-vlc-problem
# https://wiki.archlinux.org/index.php/Blu-ray
# http://vlc-aacs.whoknowsmy.name/

# vlc rip
# https://wiki.videolan.org/VLC_HowTo/Extract_audio

# hd multi-channel
# http://forum.kodi.tv/showthread.php?tid=59877

# hd music
# http://www.24bit96.com/24bit96khz-download-sites/hd-music-download.html
# http://findhdmusic.com/

vlc --no-sout-video --no-bluray-menu bluray:///dev/sr0#1  :sout='#std{access=file,mux=raw,dst=./file.ac3}'

vlc --no-sout-video --no-bluray-menu bluray:///dev/sr0#1:1-1:1  :sout='#std{access=file,mux=raw,dst=./gliere-1.ac3}'
