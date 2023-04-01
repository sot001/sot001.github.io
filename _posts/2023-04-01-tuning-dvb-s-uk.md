---
title: tuning-dvb-s-uk
date: '2023-04-01 19:37:58 +0000'
categories:
- tuning-dvb-s-uk
tags:
- tuning-dvb-s-uk
---


Satellite: Astra-28.2E

SD

`Freq: 10714000`
`Polarity: Horizontal`
`Symbol rate: 22000000`
`Mod Sys: DVB-S`
`FEC: 5/6`
`Modulation: QPSK`
`Inversion: leave at auto`
`Rolloff: leave at 0.35`

HD

`Freq: 10847000`
`Polarity: Vertical`
`Symbol rate: 23000000`
`Mod Sys: DVB-S2`
`FEC: 2/3`
`Modulation: 8PSK`
`Inversion: leave at auto`
`Rolloff: leave at 0.35`

Alternatively create a conf file and scan using scan-s2, then import
into mythtv-setup (although i haven't had success with this as yet..);

`mysql -e "select case when mod_sys = 'DVB-S' then 'S1' else 'S2' end, frequency, `
`upper(polarity), symbolrate,fec,rolloff * 100, upper(constellation) from dtv_multiplex" > dvb-s/Astra-28.2E_mythtv`

and then;

`scan-s2 -l UNIVERSAL -f 0 -o zap -t 1 -x 0 dvb-s/Astra-28.2E_mythtv > ~/channels.conf`