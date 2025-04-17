#!/bin/bash
# Script Bash per Virtual Height 5.1.2 – Batch (multi-file)
# Aggiunge height virtuali a ogni file MKV nella directory

#!/bin/bash
# =============================================================================
# SCRIPT: Super commentato – batch file per Virtual Height 5.1.2
# =============================================================================
# ✔️ Audio Enhancement per film/serie TV in ambiente Home Theater
# ✔️ Ottimizzazione di: dialoghi, surround, height e/o subwoofer
# ✔️ Uso ideale dopo encoding con HandBrake o ffmediamaster
# ✔️ Richiede: FFmpeg (con supporto CUDA), input 5.1 canali
# ✔️ Uscita: EAC3 multicanale (384k / 640k / 768k)
# -----------------------------------------------------------------------------

#!/bin/bash
set -e

@echo off
setlocal enabledelayedexpansion

# ==========================================================================
# VIRTUAL HEIGHT 5.1.2 CINEMATIC – MULTIFILE
# Applica height L/R a più file MKV nella cartella. Loudnorm ON/OFF
# ==========================================================================

# === BITRATE AUDIO ===
set BITRATE_AUDIO=640k

# === LOUDNORM ON/OFF ===
set ENABLE_LOUDNORM=1

for $F in (*.mkv) do (
    echo ► Processing: $F
    set "INPUT=$F"
    set "OUTPUT=$~nF-height512-cinematic.mkv"

    if $ENABLE_LOUDNORM$ EQU 1 (
        set "LOUDNORM_CHAIN=[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    ) else (
        set "LOUDNORM_CHAIN=[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    )

    ffmpeg -hwaccel cuda -i "$INPUT$" -filter_complex ^
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^
        [FC]speechnorm=e=12.5:r=0.00001:l=1,^
            equalizer=f=850:width_type=o:width=1.4:g=3,^
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,^
            equalizer=f=3400:width_type=o:width=1.5:g=3,^
            highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];^
        [FL][FR]amerge=inputs=2,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];^
        [stereo]asplit=2[st_left][st_right];^
        [st_left]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_L];^
        [st_right]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_R];^
        [FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]^
            join=inputs=8:channel_layout=5.1.2[a_out];^
        $LOUDNORM_CHAIN$
    " -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a $BITRATE_AUDIO$ -c:s copy ^
      -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 (Cinematic)" "$OUTPUT$"

    echo ► Done: $OUTPUT$
)

endlocal
