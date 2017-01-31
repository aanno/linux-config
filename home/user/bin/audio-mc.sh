# multichannel audio

# http://unix.stackexchange.com/questions/111428/how-do-i-configure-pulseaudio-for-7-1-surround-sound-over-hdmi

# known to work

mpv '--af=format=channels=5.1' '--audio-channels=5.1' --ad-lavc-downmix=no 17-hidden_places.ac3 

# test
speaker-test -D hdmi -c 6

# see card profiles
pactl list cards

[...]
Profile:
                output:hdmi-stereo: Digital Stereo (HDMI) Ausgang (sinks: 1, sources: 0, priority: 400, available: Ja)
                output:hdmi-surround: Digital Surround 5.1 (HDMI) Ausgang (sinks: 1, sources: 0, priority: 3300, available: Ja)
                output:hdmi-surround71: Digital Surround 7.1 (HDMI) Ausgang (sinks: 1, sources: 0, priority: 300, available: Ja


# set profile
pactl set-card-profile 0 "output:hdmi-surround"

# added to /etc/pulse/daemon.conf
; added by tp
default-sample-format = s24le
default-sample-rate = 96000
alternate-sample-rate = 88200
default-sample-channels = 6
; default-channel-map = front-left,front-right
resample-method = src-sinc-best-quality
enable-remixing = no
enable-lfe-remixing = no
