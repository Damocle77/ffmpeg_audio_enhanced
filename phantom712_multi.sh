#!/bin/bash
set -e

# =============================================================================
# PHANTOM ATMOS 7.1.2 (CINEMATIC) – MULTI FILE BASH VERSION
# Simula un ambiente tridimensionale con surround ampio e height posteriore.
# =============================================================================

BITRATE_AUDIO="720k"
ENABLE_LOUDNORM=0  # imposta a 1 per abilitare loudnorm

# Loop su tutti i file .mkv nella directory corrente
for INPUT in *.mkv; do
  NAMEBASE="${INPUT%.*}"
  OUTPUT="${NAMEBASE}-phantomatmos712.mkv"

  echo "🎬 Elaborazione: $INPUT"

  if [[ $ENABLE_LOUDNORM -eq 1 ]]; then
    LOUDNORM_CHAIN="[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
  else
    LOUDNORM_CHAIN="[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
  fi

  ffmpeg -hwaccel cuda -i "$INPUT" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=250:width_type=o:width=1.2:g=1.5,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,
        dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
    [FL]volume=1.3,equalizer=f=400:width_type=o:width=1.3:g=1.2[FL_adj];
    [FR]volume=1.3,equalizer=f=400:width_type=o:width=1.3:g=1.2[FR_adj];
    [BL]volume=1.8,aecho=0.3:0.4:20|30:0.25|0.2,adelay=20|25[SHL];
    [BR]volume=1.8,aecho=0.3:0.4:20|30:0.25|0.2,adelay=25|20[SHR];
    [FL_adj][FR_adj][FC_enhanced][LFE][BL][BR][SHL][SHR]
      join=inputs=8:channel_layout=7.1.2[a_out];
    $LOUDNORM_CHAIN
  " -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a "$BITRATE_AUDIO" -c:s copy \
     -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2 Cinematic" "$OUTPUT"

  echo "✅ Output: $OUTPUT"
done
