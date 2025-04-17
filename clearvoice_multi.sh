#!/bin/bash
set -e

# ==========================================================================
# 🎛️ CLEARVOICE 5.1 ENHANCED – MULTI FILE
# Miglioramento dialoghi, surround e subwoofer con loudnorm opzionale.
# Compatibile con tracce 5.1 in input.
# ==========================================================================

BITRATE_AUDIO="384k"              # Bitrate consigliato (384k o 640k)
ENABLE_LOUDNORM=1                 # 1 = Applica loudnorm, 0 = Usa solo limiter
SUFFIX="-clearvoice51.mkv"        # Suffisso automatico nel nome finale

for f in *.mkv; do
    echo "🎬 Elaborazione: $f"
    name="${f%.*}"
    out="${name}${SUFFIX}"

    if [[ $ENABLE_LOUDNORM -eq 1 ]]; then
        LOUDNORM_CHAIN="[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    else
        LOUDNORM_CHAIN="[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    fi

    ffmpeg -hwaccel cuda -i "$f" -filter_complex "
        [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
        [FC]speechnorm=e=12.5:r=0.00001:l=1,
            equalizer=f=850:width_type=o:width=1.4:g=3,
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,
            equalizer=f=3400:width_type=o:width=1.5:g=3,
            highpass=f=70,lowpass=f=11500,
            dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
        [FL][FR][FC_enhanced][LFE][BL][BR]join=inputs=6:channel_layout=5.1[a_out];
        $LOUDNORM_CHAIN
    " -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy       -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" "$out"

    echo "✅ Output: $out"
done
