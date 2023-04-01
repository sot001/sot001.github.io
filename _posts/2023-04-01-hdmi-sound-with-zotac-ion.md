---
title: hdmi-sound-with-zotac-ion
date: '2023-04-01 19:37:56 +0000'
categories:
- hdmi-sound-with-zotac-ion
tags:
- hdmi-sound-with-zotac-ion
---


### Kodi update:

System: Xubuntu 16.06

aplay -l showed all the right devices but speaker-test -c wav -D hw:0,3
played nothing. alsamixer showed all volumes at max but pavucontrol only
showed the internal ausio card, not HDMI

[this](https://itsfoss.com/how-to-fix-no-sound-through-hdmi-in-external-monitor-in-ubuntu/)
page gave a hint. On the last page of the volume widget, I could select
the HDMI device. bang. That did it.

Other things I tried along the way; - created /etc/asound.conf file as
shown below (reboot) - added kodi to audio group - removed pulseadio
(reboot) - added pulseaudio in again (reboot)

Finally I killed pulseaudio with

`pulseaudio -k`

Selected the correct device with pavucontrol and then did another reboot
to test....yay\!

### MythTV work

Link: <http://www.gossamer-threads.com/lists/mythtv/users/367050#367050>

This finally did the trick for me, to allow playing of 41,000Hz files
over the HDMI link, which was expecting 44,000Hz

**ENSURE ALL VOLUME IS UNMUTED WITHIN alsamixer\!\!** For HDMI cards run
aplay -l and look for an output like this:

    Subdevices: 1/1
    Subdevice #0: subdevice #0
    card 0: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]

For this case, the key is card o device 3.

This setup has worked:

    Audio output device: ALSA:default
    Passthrough output device: ALSA:default
    Max Audio Channels: Stereo
    Upmix: Passive
    Enabale AC3 to SPDIF passthrough unchecked
    Enable DTS to SPDIF passthrough checked
    Aggressive sound card buffering off
    Use internal volume controls off

For mythmusic:

    Utilities/Setup -> Setup -> Media Settings -> Music Settings ->
    General Settings
    and then set Audio device to ALSA:plughw:0,3
    asound.conf:
    pcm.!default {
    type hw
    card 0
    device 3
    }