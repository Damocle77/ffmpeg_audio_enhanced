#!/bin/bash
set -e

# ==========================================================================
# 🎧 REPAIR SURROUND ADAPTIVE – MULTI FILE (SUPER COMMENTATO)
# Analizza tutti i file MKV nella cartella e applica miglioramenti audio
# adattivi: Clearvoice, surround enhancement, loudnorm o limiter.
# ==========================================================================

BITRATE_AUDIO="384k"                       # 🎧 Bitrate EAC3 finale
ENABLE_LOUDNORM=1                          # ✅ Loudnorm attivo (1) o disattivo (0)
SUFFIX="-repairadaptive"                  # 🔤 Suffisso automatico per ogni file elaborato

# === Ciclo su tutti i file .mkv ===
for INPUT in *.mkv; do
    EXT="${INPUT##*.}"
    NAMEBASE="${INPUT%.*}"
    OUTPUT="${NAMEBASE}${SUFFIX}.${EXT}"

    echo "🎧 File in elaborazione: $INPUT"
    CHANNEL_LAYOUT=$(ffprobe -v error -select_streams a:0 -show_entries stream=channel_layout \
      -of default=noprint_wrappers=1:nokey=1 "$INPUT")
    echo "📊 Layout rilevato: $CHANNEL_LAYOUT"

    # === Generazione filtro in base al layout ===
    if [[ "$CHANNEL_LAYOUT" == "stereo" ]]; then
        echo "🔁 Converti da stereo a 5.1 con surround + clearvoice"
        FILTER="
            [0:a:0]channelsplit=channel_layout=stereo[FL][FR];
            [FL]highpass=f=100,lowpass=f=12000,equalizer=f=900:g=3[FLb];
            [FR]highpass=f=100,lowpass=f=12000,equalizer=f=900:g=3[FRb];
            [FLb][FRb]amerge=inputs=2[a_stereo];
            [a_stereo]asplit=3[a_main][a_bl][a_br];
            [a_main]volume=1.8[a_fc];
            [a_bl]highpass=f=800,stereowiden=delay=15:feedback=0.3:crossfeed=0.6,adelay=20|22[a_bl_rich];
            [a_br]highpass=f=800,stereowiden=delay=15:feedback=0.3:crossfeed=0.6,adelay=25|20[a_br_rich];
            [a_fc][a_bl_rich][a_br_rich]join=inputs=5:channel_layout=5.1[a_out]"
    elif [[ "$CHANNEL_LAYOUT" == "5.1" ]]; then
        echo "✨ Migliora dialoghi e surround di una traccia 5.1"
        FILTER="
            [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
            [FC]speechnorm=e=12.5:r=0.00001:l=1,volume=1.8[FC_boost];
            [BL]highpass=f=600,aecho=0.4:0.4:30|40:0.3|0.2[BL_soft];
            [BR]highpass=f=600,aecho=0.4:0.4:30|40:0.3|0.2[BR_soft];
            [FL][FR][FC_boost][LFE][BL_soft][BR_soft]join=inputs=6:channel_layout=5.1[a_out]"
    else
        echo "⚠️ Layout non gestito: $CHANNEL_LAYOUT"
        continue
    fi

    # === Loudnorm o limiter finale ===
    if [[ "$ENABLE_LOUDNORM" -eq 1 ]]; then
        FINAL="[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_final]"
    else
        FINAL="[a_out]alimiter=limit=0.95:attack=4:release=50[a_final]"
    fi

    # === Comando FFmpeg ===
    ffmpeg -hwaccel cuda -i "$INPUT" -filter_complex "$FILTER;$FINAL" -map 0:v -map "[a_final]" -map 0:s? \
      -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy \
      -metadata:s:a:0 language=ita -metadata:s:a:0 title="Repair Surround Adaptive" "$OUTPUT"

    echo "✅ Completato: $OUTPUT"
done