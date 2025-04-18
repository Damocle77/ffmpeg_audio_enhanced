#!/bin/bash
# ==============================================================================
# AUTO SURROUND ENHANCEMENT PIPELINE
# - Rileva automaticamente se una traccia è stereo, surround reale o fake 5.1
# - Applica l'elaborazione appropriata:
#     - Stereo ➜ Clearvoice 5.1
#     - Fake 5.1 ➜ Repair Surround Adaptive
#     - Reale 5.1 ➜ Clearvoice + notifica
# Autore: D@mocle77
# ==============================================================================

INPUT="$1"

if [[ -z "$INPUT" ]]; then
  echo "❌ Utilizzo: $0 <file_input.mkv>"
  exit 1
fi

echo "🔍 Analisi del file: $INPUT"
CHANNELS=$(ffprobe -v error -select_streams a:0 -show_entries stream=channels   -of default=noprint_wrappers=1:nokey=1 "$INPUT")

LAYOUT=$(ffprobe -v error -select_streams a:0 -show_entries stream=channel_layout   -of default=noprint_wrappers=1:nokey=1 "$INPUT")

echo "🎧 Canali rilevati: $CHANNELS ($LAYOUT)"

# Funzione per invocare stereo_to_clearvoice_5.1
apply_stereo_conversion() {
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
SUFFIX="-repairauto51"

# === Costruzione automatica del nome di output ===
BASENAME="${INPUT%.*}"
EXTENSION="${INPUT##*.}"
OUTPUT="${BASENAME}${SUFFIX}.${EXTENSION}"

# === Bitrate audio EAC3 finale ===
BITRATE_AUDIO="320k"

# === Abilita/disabilita il filtro loudnorm ===
ENABLE_LOUDNORM=1

# === Abilita/disabilita l'estrazione dei bassi verso LFE per un effetto subwoofer reale===
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

}

# Funzione per invocare repair_surround_adaptive
apply_repair_surround() {
#!/bin/bash
# ============================================================================================
# 🎧 REPAIR SURROUND ADAPTIVE – Analizza e migliora l'audio automaticamente
# Supporta input stereo o surround: decide se convertire in 5.1 oppure migliorare la traccia
# Dialoghi più chiari, surround più immersivo e subwoofer gestito con "intelligenza"
# ============================================================================================

# === CONFIGURAZIONE PRINCIPALE =============================================================

INPUT="$1"                                     # File video/audio di input
SUFFIX="-repairauto51"                         # Suffisso da aggiungere all'output
BITRATE_AUDIO="320k"                           # Bitrate finale per l'EAC3

# Controllo parametri
if [[ ! -f "$INPUT" ]]; then
  echo "❌ File non trovato: $INPUT"
  exit 1
fi

# Estrazione nome base ed estensione
NAMEBASE="${INPUT%.*}"
EXT="${INPUT##*.}"
OUTPUT="${NAMEBASE}${SUFFIX}.${EXT}"

echo "🔍 Analisi canali..."
CHANNEL_LAYOUT=$(ffprobe -v error -select_streams a:0 -show_entries stream=channel_layout -of default=noprint_wrappers=1:nokey=1 "$INPUT")

echo "📣 Layout rilevato: $CHANNEL_LAYOUT"

# === LOGICA ADATTIVA =========================================================================
# Se stereo  => converte in 5.1 + enhance voce + surround
# Se 5.1     => applica solo clearvoice e surround enhancer
# Altri      => avvisa in caso di anomalie e copia l'audio invariato

if [[ "$CHANNEL_LAYOUT" == "stereo" ]]; then
  echo "🎧 Input stereo: attivo upmix + voice boost + surround soft"
  FILTER="
    [0:a:0]channelsplit=channel_layout=stereo[FL][FR];
    [FL]highpass=f=100,lowpass=f=12000,equalizer=f=900:g=3,width_type=o:width=1.4[FL_boost];
    [FR]highpass=f=100,lowpass=f=12000,equalizer=f=900:g=3,width_type=o:width=1.4[FR_boost];
    [FL_boost][FR_boost]amerge=inputs=2[a_stereo];
    [a_stereo]asplit=3[a_main][a_bl][a_br];
    [a_main]volume=1.8[a_fc];
    [a_bl]highpass=f=800,stereowiden=delay=15:feedback=0.3:crossfeed=0.6,adelay=20|22[a_bl_rich];
    [a_br]highpass=f=800,stereowiden=delay=15:feedback=0.3:crossfeed=0.6,adelay=25|20[a_br_rich];
    [a_fc][a_bl_rich][a_br_rich]join=inputs=5:channel_layout=5.1[a_out];
    [a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]
  "

elif [[ "$CHANNEL_LAYOUT" == "5.1" ]]; then
  echo "🎧 Input 5.1: applico solo miglioramento dialoghi e surround"
  FILTER="
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,volume=1.8[FC_boost];
    [BL]highpass=f=600,aecho=0.4:0.4:30|40:0.3|0.2[BL_soft];
    [BR]highpass=f=600,aecho=0.4:0.4:30|40:0.3|0.2[BR_soft];
    [FL][FR][FC_boost][LFE][BL_soft][BR_soft]join=inputs=6:channel_layout=5.1[a_out];
    [a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]
  "
else
  echo "⚠️  Layout non gestito ($CHANNEL_LAYOUT), l'audio verrà copiato senza modifiche"
  ffmpeg -i "$INPUT" -c copy "$OUTPUT"
  exit 0
fi

# === ESECUZIONE FINALE =======================================================================

ffmpeg -hwaccel cuda -i "$INPUT" -filter_complex "$FILTER" \
  -map 0:v -map "[a_out_limited]" -map 0:s? \
  -c:v copy -c:a eac3 -b:a $BITRATE_AUDIO -c:s copy \
  -metadata:s:a:0 language=ita -metadata:s:a:0 title="Repair Surround Adaptive" \
  "$OUTPUT"

echo "✅ Output generato: $OUTPUT"

}

# Decisione sulla pipeline da applicare
if [[ "$CHANNELS" -eq 2 ]]; then
  echo "➡️ Stereo rilevato: applico conversione a Clearvoice 5.1"
  apply_stereo_conversion "$INPUT"
elif [[ "$CHANNELS" -eq 6 ]]; then
  echo "➡️ 5.1 rilevato: applico Repair Surround Adaptive"
  apply_repair_surround "$INPUT"
else
  echo "⚠️ Canali non gestiti automaticamente: $CHANNELS ($LAYOUT)"
  echo "🔔 Nessuna elaborazione eseguita"
  exit 0
fi
