#!/bin/bash
set -e

# ==========================================================================
# PHANTOM ATMOS 7.1.2 CINEMATIC – SINGOLO FILE
# Simulazione completa Atmos: altezza + surround posteriori
# Loudnorm opzionale ON/OFF
# ==========================================================================

# === Nome del file di input ===
INPUT="MioVideo.mkv"

# === Suffix che verrà aggiunto all’output ===
SUFFIX="-sideheight712"

# === Bitrate audio EAC3 (alta qualità per Atmos virtuale) ===
BITRATE_AUDIO="768k"

# === Abilita o disabilita loudnorm (1 = ON, 0 = OFF) ===
ENABLE_LOUDNORM=1

# === Costruzione nome file di output dinamicamente ===
BASENAME="${INPUT%.*}"
EXT="${INPUT##*.}"
OUTPUT="${BASENAME}${SUFFIX}.${EXT}"

# === Blocco condizionale per loudnorm o limiter ===
if [ "$ENABLE_LOUDNORM" -eq 1 ]; then
    LOUDNORM_CHAIN="[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
else
    LOUDNORM_CHAIN="[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
fi

# === Esecuzione FFmpeg ===
ffmpeg -hwaccel cuda -i "$INPUT" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,
        dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
    [BL]highpass=f=4800,aphaser=type=t:speed=0.3,
        adelay=20|22,aecho=0.4:0.4:20|30:0.2|0.15[BACK_L];
    [BR]highpass=f=4800,aphaser=type=t:speed=0.3,
        adelay=22|20,aecho=0.4:0.4:20|30:0.2|0.15[BACK_R];
    [FL][FR]amerge=inputs=2,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];
    [stereo]asplit=2[HTL_SRC][HTR_SRC];
    [HTL_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,
        aecho=0.4:0.4:20|30:0.2|0.15[HT_L];
    [HTR_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,
        aecho=0.4:0.4:20|30:0.2|0.15[HT_R];
    [FL][FR][FC_enhanced][LFE][BL][BR][BACK_L][BACK_R][HT_L][HT_R]
        join=inputs=10:channel_layout=7.1.2[a_out];
    $LOUDNORM_CHAIN
" -map 0:v -map "[a_out_limited]" -map 0:s? \
  -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy \
  -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2 Cinematic" "$OUTPUT"
