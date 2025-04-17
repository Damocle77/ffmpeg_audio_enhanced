#!/bin/bash
# Script Bash per Clearvoice 5.1 Enhanced – Batch (multi-file)
# Applica la pipeline a tutti i file .mkv nella cartella

#!/bin/bash
# =============================================================================
# SCRIPT: Super commentato – batch file per Clearvoice 5.1
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

# ========================================================================================
# CLEARVOICE 5.1 ENHANCED – BATCH MULTIFILE
# Script per elaborare automaticamente tutti i file .mkv nella cartella corrente,
# migliorando la chiarezza dei dialoghi, la spazialità del surround e la profondità del subwoofer.
# ========================================================================================

# === CONFIGURAZIONE UTENTE ===

# Bitrate per il flusso audio EAC3 finale.
# 384k → consigliato per serie TV, animazione o film parlati.
# 448k o 640k → qualità più alta, utile per film d'azione.
set "BITRATE_AUDIO=384k"

# Attivazione loudnorm (normalizzazione loudness):
# 1 = ON  → normalizza il volume tra contenuti diversi (ottimo per binge-watching)
# 0 = OFF → mantiene dinamica piena (consigliato per film dinamici o con buona traccia)
set ENABLE_LOUDNORM=1

# Suffisso da aggiungere automaticamente al nome file di output (prima dell'estensione)
# Es: "Film.mkv" → "Film-clearvoice0.mkv"
set "SUFFIXO_OUTPUT=-clearvoice0"

# ========================================================================================
# CICLO DI ELABORAZIONE - PER OGNI FILE .MKV NELLA CARTELLA
# ========================================================================================
for $F in (*.mkv) do (

    echo ► Processing: $F

#    :: === Costruzione nomi input/output dinamici ===
    set "INPUT=$F"
    set "OUTPUT=$~nF$SUFFIXO_OUTPUT$.mkv"

#    :: === Catena condizionale: loudnorm oppure limiter ===
    if $ENABLE_LOUDNORM$ EQU 1 (
        set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    ) else (
        set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    )

#    :: ========================================================================================
#    :: ESECUZIONE FFMPEG - Rielaborazione audio in 5.1 con compressione sidechain + surround
#    :: ========================================================================================
    ffmpeg -hwaccel cuda -i "$INPUT$" -filter_complex ^

#        :: === 1. Split canali da sorgente 5.1 ===
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^

#        :: === 2. Dialoghi (Center Channel) - Focus su chiarezza vocale italiana ===
        [FC]speechnorm=e=12.5:r=0.00001:l=1,^
            equalizer=f=250:width_type=o:width=1.2:g=1.5,^     :: Frequenze basse (voce maschile)
            equalizer=f=850:width_type=o:width=1.4:g=3,^       :: Mid-range intelligibilità
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,^    :: Frequenze chiare
            equalizer=f=3400:width_type=o:width=1.5:g=3,^      :: Dettaglio finale
            highpass=f=70,lowpass=f=11500,^
            acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,^
            dynaudnorm=f=90:g=6,volume=2.0,^
            highshelf=f=8000:g=-3.5[FC_enhanced];^

#        :: === 3. Frontali L+R - Stereo largo e definito ===
        [FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];^

        [FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];^

#        :: === 4. Subwoofer LFE - Bassi profondi ma controllati ===
        [LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,^
            equalizer=f=90:width_type=o:width=1.0:g=3,^
            lowpass=f=115,^
            acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,^
            asubboost=boost=2.5,volume=1.3[LF_adj];^

#        :: === 5. Surround Rear (L+R) - Delay, ambienti e spazialità ===
        [BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=1.8,^
            equalizer=f=3500:width_type=o:width=1.2:g=1.5,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.4,^
            stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=15|17,^
            aecho=0.4:0.4:20|30:0.2|0.15,^
            dynaudnorm=f=150:g=8[BL_ready];^

        [BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=1.8,^
            equalizer=f=3500:width_type=o:width=1.2:g=1.5,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.5,^
            stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=18|15,^
            aecho=0.4:0.4:20|30:0.2|0.15,^
            dynaudnorm=f=150:g=8[BR_ready];^

#        :: === 6. Unione finale e compressione sidechain ===
        [FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]^
            join=inputs=6:channel_layout=5.1[a_out];^

        $LOUDNORM_CHAIN$
    " -map 0:v -map "[a_out_limited]" -map 0:s? ^
      -c:v copy -c:a eac3 -b:a $BITRATE_AUDIO$ -c:s copy ^
      -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" ^
      "$OUTPUT$"

    echo ► Output generato: $OUTPUT$"
)

endlocal
