#!/bin/bash
set -e

# =============================================================================
# 🎧 CLEARVOICE STEREO → 5.1 ENHANCED – Singolo File
# Estende una traccia stereo a un layout 5.1 con:
# - Centro vocale potenziato
# - Surround virtuali (con effetti dolci)
# - LFE opzionale (estrazione bassi)
# - Loudnorm ON/OFF
# =============================================================================

# === File di input (modifica con il tuo file) ===
INPUT="nomefile.mkv"

# === Suffisso per il file di output ===
SUFFIX="-clearvoice51"

# === Costruzione automatica del nome di output ===
BASENAME="${INPUT%.*}"
EXTENSION="${INPUT##*.}"
OUTPUT="${BASENAME}${SUFFIX}.${EXTENSION}"

# === Bitrate audio EAC3 finale ===
BITRATE_AUDIO="640k"

# === Abilita/disabilita il filtro loudnorm ===
ENABLE_LOUDNORM=1

# === Abilita/disabilita l'estrazione dei bassi verso LFE ===
ENABLE_LFE=1

# === Costruzione dinamica della catena loudnorm o limiter ===
if [ "$ENABLE_LOUDNORM" -eq 1 ]; then
  LOUDNORM_CHAIN="[aout]loudnorm=I=-16:TP=-1.5:LRA=11[aout_limited]"
else
  LOUDNORM_CHAIN="[aout]alimiter=limit=0.95:attack=4:release=50[aout_limited]"
fi

# === Costruzione dinamica del blocco LFE (se attivo) ===
if [ "$ENABLE_LFE" -eq 1 ]; then
  LFE_FILTER="[stereo]lowpass=f=100,bass=g=8,volume=1.5[lfe]"
  JOIN_LAYOUT="[fc][fl][fr][bl][br][lfe]join=inputs=6:channel_layout=5.1[aout]"
else
  LFE_FILTER=""
  JOIN_LAYOUT="[fc][fl][fr][bl][br]join=inputs=5:channel_layout=5.0[aout]"
fi

# === Esecuzione di FFmpeg ===
ffmpeg -hide_banner -hwaccel cuda -i "$INPUT" -filter_complex "
  [0:a:0]channelsplit=channel_layout=stereo[left][right];

  # Creazione canale centrale vocale (media di L+R)
  [left][right]amerge=inputs=2,pan=mono|c0=0.5*c0+0.5*c1,
    speechnorm=e=12.5:r=0.00001:l=1,
    equalizer=f=300:width_type=o:width=2:g=3,
    equalizer=f=850:width_type=o:width=1.4:g=3,
    highpass=f=80,lowpass=f=12000,
    dynaudnorm=f=90:g=4,acompressor=threshold=-25dB:ratio=2.5:attack=5:release=100:makeup=4,volume=2.2[fc];

  # Front L e R (leggero miglioramento)
  [left]highpass=f=100,equalizer=f=1000:g=2,volume=1.3[fl];
  [right]highpass=f=100,equalizer=f=1000:g=2,volume=1.3[fr];

  # Surround L e R (leggero echo e spread)
  [left]aecho=0.4:0.4:30|40:0.25|0.2,stereowiden=delay=15:feedback=0.3:crossfeed=0.4[bl];
  [right]aecho=0.4:0.4:30|40:0.25|0.2,stereowiden=delay=15:feedback=0.3:crossfeed=0.4[br];

  # LFE (opzionale)
  $LFE_FILTER;

  # Join canali nel layout finale
  $JOIN_LAYOUT;

  # Loudnorm o limiter finale
  $LOUDNORM_CHAIN
" -map 0:v -map "[aout_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a $BITRATE_AUDIO -c:s copy \
  -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" "$OUTPUT"

echo "✅ File creato: $OUTPUT"
