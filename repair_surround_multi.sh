#!/bin/bash
# ===============================================
# Script: repair_surround_multi.sh
# Descrizione: Analizza ed elabora automaticamente tutti i file MKV nella cartella corrente usando repair_surround_adaptive.sh
# Autore: D@mocle77
# ===============================================

# Imposta i parametri globali (modificabili)
ENABLE_LOUDNORM=1
BITRATE_AUDIO="640k"

# Ciclo su tutti i file .mkv nella directory corrente
for input_file in *.mkv; do
  echo "🛠️ Elaborazione di: $input_file"
  ENABLE_LOUDNORM=$ENABLE_LOUDNORM BITRATE_AUDIO=$BITRATE_AUDIO ./repair_surround_adaptive.sh "$input_file"
done

echo "✅ Elaborazione completata per tutti i file MKV."
