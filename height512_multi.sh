#!/bin/bash
set -e

# ==========================================================================
# 🌌 VIRTUAL HEIGHT 5.1.2 CINEMATIC – MULTI FILE
# Simula altezza con stereo widen + echo + phaser. Loudnorm opzionale.
# ==========================================================================

BITRATE_AUDIO="640k"
ENABLE_LOUDNORM=1
SUFFIX="-height512.mkv"

for f in *.mkv; do
    echo "🎬 Elaborazione: $f"
    name="${f%.*}"
    out="${name}${SUFFIX}"

    if [[ $ENABLE_LOUDNORM -eq 1 ]]; then
        LOUDNORM_CHAIN="[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    else
        LOUDNORM_CHAIN="[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    fi

    ffmpeg -hwaccel cuda -i "$f" -filter_complex "
        [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
        [FC]speechnorm=e=12.5:r=0.00001:l=1,
            equalizer=f=850:width_type=o:width=1.4:g=3,
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,
            equalizer=f=3400:width_type=o:width=1.5:g=3,
            highpass=f=70,lowpass=f=11500,
            dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
        [FL][FR]amerge=inputs=2,
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];
        [stereo]asplit=2[st_left][st_right];
        [st_left]highpass=f=4800,
            aecho=0.45:0.45:35|42:0.28|0.25,
            aphaser=type=t:speed=0.3[HT_L];
        [st_right]highpass=f=4800,
            aecho=0.45:0.45:35|42:0.28|0.25,
            aphaser=type=t:speed=0.3[HT_R];
        [FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]
            join=inputs=8:channel_layout=5.1.2[a_out];
        $LOUDNORM_CHAIN
    " -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy       -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 Cinematic" "$out"

    echo "✅ Output: $out"
done
