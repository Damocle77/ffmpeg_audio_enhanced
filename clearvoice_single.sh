#!/bin/bash
# Script Bash per Clearvoice 5.1 Enhanced – Singolo file
# Migliora la chiarezza dei dialoghi e la spazialità del surround
# Usa FFmpeg con filtri personalizzati per l'elaborazione audio multicanale

#!/bin/bash
# =============================================================================
# SCRIPT: Super commentato – singolo file per Clearvoice 5.1
# =============================================================================
# ✔️ Audio Enhancement per film/serie TV in ambiente Home Theater
# ✔️ Ottimizzazione di: dialoghi, surround, height e/o subwoofer
# ✔️ Uso ideale dopo encoding con HandBrake o ffmediamaster
# ✔️ Richiede: FFmpeg (con supporto CUDA), input 5.1 canali
# ✔️ Uscita: EAC3 multicanale (384k / 640k / 768k)
# -----------------------------------------------------------------------------

#!/bin/bash
set -e

# ==========================================================================
# CLEARVOICE 5.1 ENHANCED – SINGOLO FILE (AUTO OUTPUT)
# 🔊 Miglioramento dialoghi + surround + subwoofer | Loudnorm ON/OFF
# ==========================================================================

INPUT="MioVideo.mkv"
SUFFIX="-clearvoice0"
EXT="${INPUT##*.}"
NAMEBASE="${INPUT%.*}"
OUTPUT="${NAMEBASE}${SUFFIX}.${EXT}"
BITRATE_AUDIO="384k"
ENABLE_LOUDNORM=1

if [ "$ENABLE_LOUDNORM" -eq 1 ]; then
    LOUDNORM_CHAIN="[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
else
    LOUDNORM_CHAIN="[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
fi

ffmpeg -hwaccel cuda -i "$INPUT" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=250:width_type=o:width=1.2:g=1.5,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,
        acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,
        dynaudnorm=f=90:g=6,volume=2.0,
        highshelf=f=8000:g=-3.5[FC_enhanced];
    [FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,
        acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];
    [FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,
        acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];
    [LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,
        equalizer=f=90:width_type=o:width=1.0:g=3,
        lowpass=f=115,
        acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,
        asubboost=boost=2.5,volume=1.3[LF_adj];
    [BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,
        equalizer=f=1800:width_type=o:width=1.4:g=2,
        equalizer=f=2500:width_type=o:width=2:g=1.8,
        equalizer=f=3500:width_type=o:width=1.2:g=1.5,
        acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,
        asubboost=boost=1.4,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,
        aphaser=type=t:speed=0.3,adelay=15|17,
        aecho=0.4:0.4:20|30:0.2|0.15,dynaudnorm=f=150:g=8[BL_ready];
    [BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,
        equalizer=f=1800:width_type=o:width=1.4:g=2,
        equalizer=f=2500:width_type=o:width=2:g=1.8,
        equalizer=f=3500:width_type=o:width=1.2:g=1.5,
        acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,
        asubboost=boost=1.5,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,
        aphaser=type=t:speed=0.3,adelay=18|15,
        aecho=0.4:0.4:20|30:0.2|0.15,dynaudnorm=f=150:g=8[BR_ready];
    [FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]
        join=inputs=6:channel_layout=5.1[a_out];
    $LOUDNORM_CHAIN
" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" "$OUTPUT"
