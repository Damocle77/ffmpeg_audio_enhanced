
:: --------------------------------------------------------------------------------------------
:: === Clearvoice 5.1 (Sidechain) ===
:: --------------------------------------------------------------------------------------------

🔊	:: Clearvoice 5.1 (Enhanced) singolo file

ffmpeg -hwaccel cuda -i "video.mkv" -filter_complex "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];[FC]speechnorm=e=12.5:r=0.00001:l=1,equalizer=f=250:width_type=o:width=1.2:g=1.5,equalizer=f=850:width_type=o:width=1.4:g=3,equalizer=f=1800:width_type=o:width=1.5:g=4.2,equalizer=f=3400:width_type=o:width=1.5:g=3,highpass=f=70,lowpass=f=11500,acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,volume=2.0,highshelf=f=8000:g=-3.5[FC_enhanced];[FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];[FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];[LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,equalizer=f=90:width_type=o:width=1.0:g=3,lowpass=f=115,acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,asubboost=boost=2.5,volume=1.3[LF_adj];[BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,equalizer=f=1800:width_type=o:width=1.4:g=2,equalizer=f=2500:width_type=o:width=2:g=0.6,equalizer=f=3500:width_type=o:width=1.2:g=0.2,acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,asubboost=boost=1.4,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,aphaser=type=t:speed=0.3,adelay=12|12[BL_ready];[BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,equalizer=f=1800:width_type=o:width=1.4:g=2,equalizer=f=2500:width_type=o:width=2:g=0.6,equalizer=f=3500:width_type=o:width=1.2:g=0.2,acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,asubboost=boost=1.5,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,aphaser=type=t:speed=0.3,adelay=12|12[BR_ready];[FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]join=inputs=6:channel_layout=5.1[a_out];[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_out_sidechain];[a_out_sidechain]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 640k -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" "video-clearvoice.mkv"

---

🔊	:: Clearvoice 5.1 (Enhanced) file moltepli

@echo off
setlocal enabledelayedexpansion

for %%F in (*.mkv) do (
    echo Processing (Clearvoice 5.1): %%F

    ffmpeg -hwaccel cuda -i "%%F" -filter_complex ^
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^
        [FC]speechnorm=e=12.5:r=0.00001:l=1,equalizer=f=250:width_type=o:width=1.2:g=1.5,^
            equalizer=f=850:width_type=o:width=1.4:g=3,equalizer=f=1800:width_type=o:width=1.5:g=4.2,^
            equalizer=f=3400:width_type=o:width=1.5:g=3,highpass=f=70,lowpass=f=11500,^
            acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,^
            volume=2.0,highshelf=f=8000:g=-3.5[FC_enhanced];^
        [FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];^
        [FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];^
        [LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,equalizer=f=90:width_type=o:width=1.0:g=3,^
            lowpass=f=115,acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,^
            asubboost=boost=2.5,volume=1.3[LF_adj];^
        [BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=0.6,^
            equalizer=f=3500:width_type=o:width=1.2:g=0.2,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.4,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=15|17[BL_ready];^
        [BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=0.6,^
            equalizer=f=3500:width_type=o:width=1.2:g=0.2,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.5,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=18|15[BR_ready];^
        [FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]join=inputs=6:channel_layout=5.1[a_out];^
        [a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_out_sidechain];^
        [a_out_sidechain]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" ^
        -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 384k -c:s copy ^
        -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1 Enhanced" ^
        "%%~nF-clearvoice0.mkv"
)
endlocal

---

🎞️	:: Clearvoice 5.1 (Enhanced) con opzione loudnorm (video non dinamici) file singolo (Batch pipeline)

@echo off
setlocal enabledelayedexpansion

:: === ABILITA o DISABILITA loudnorm finale ===
:: Utile per bilanciare film con mix differenti (es. azione vs commedia)
set ENABLE_LOUDNORM=1

:: === Nome del file da elaborare (modifica se necessario) ===
set "INPUT=MioVideo.mkv"
set "OUTPUT=MioVideo-clearvoice0.mkv"

:: === Catena loudnorm condizionale ===
if !ENABLE_LOUDNORM! EQU 1 (
    set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
) else (
    set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
)

:: === Esecuzione FFmpeg ===
ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=250:width_type=o:width=1.2:g=1.5,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,
        acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,
        dynaudnorm=f=90:g=6,volume=2.0,
        highshelf=f=8000:g=-3.5[FC_enhanced];
    [FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,
        acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];
    [FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,
        acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];
    [LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,
        equalizer=f=90:width_type=o:width=1.0:g=3,
        lowpass=f=115,
        acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,
        asubboost=boost=2.5,volume=1.3[LF_adj];
    [BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,
        equalizer=f=1800:width_type=o:width=1.4:g=2,
        equalizer=f=2500:width_type=o:width=2:g=1.8,
        equalizer=f=3500:width_type=o:width=1.2:g=1.5,
        acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,
        asubboost=boost=1.4,
        stereowiden=delay=15:feedback=0.2:crossfeed=0.6,
        aphaser=type=t:speed=0.3,
        adelay=15|17,
        aecho=0.4:0.4:20|30:0.2|0.15,
        dynaudnorm=f=150:g=8[BL_ready];
    [BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,
        equalizer=f=1800:width_type=o:width=1.4:g=2,
        equalizer=f=2500:width_type=o:width=2:g=1.8,
        equalizer=f=3500:width_type=o:width=1.2:g=1.5,
        acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,
        asubboost=boost=1.5,
        stereowiden=delay=15:feedback=0.2:crossfeed=0.6,
        aphaser=type=t:speed=0.3,
        adelay=18|15,
        aecho=0.4:0.4:20|30:0.2|0.15,
        dynaudnorm=f=150:g=8[BR_ready];
    [FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]
        join=inputs=6:channel_layout=5.1[a_out];
    !LOUDNORM_CHAIN!
" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 640k -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1" "!OUTPUT!"

---

🎞️	:: Clearvoice 5.1 (Enhanced) con opzione loudnorm (video non dinamici) multipli file  (Batch pipeline)

@echo off
setlocal enabledelayedexpansion

:: === ATTIVA/DISATTIVA LOUDNORM ===
:: 1 = attivo → volume più bilanciato
:: 0 = disattivo → dinamica completa (film d’azione ecc.)
set ENABLE_LOUDNORM=1

:: === INIZIA CICLO SUI FILE ===
for %%F in (*.mkv) do (
    echo ► Processing: %%F

    set "INPUT=%%F"
    set "OUTPUT=%%~nF-clearvoice0.mkv"

    if !ENABLE_LOUDNORM! EQU 1 (
        set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    ) else (
        set "LOUDNORM_CHAIN=[a_out][FC_enhanced]sidechaincompress=threshold=-20dB:ratio=2:attack=5:release=150[a_tmp];[a_tmp]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    )

    ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex ^
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^
        [FC]speechnorm=e=12.5:r=0.00001:l=1,^
            equalizer=f=250:width_type=o:width=1.2:g=1.5,^
            equalizer=f=850:width_type=o:width=1.4:g=3,^
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,^
            equalizer=f=3400:width_type=o:width=1.5:g=3,^
            highpass=f=70,lowpass=f=11500,^
            acompressor=threshold=-28dB:ratio=2.6:attack=6:release=200:makeup=5.0dB,^
            dynaudnorm=f=90:g=6,volume=2.0,^
            highshelf=f=8000:g=-3.5[FC_enhanced];^
        [FL]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FL_adj];^
        [FR]volume=1.2,equalizer=f=400:width_type=o:width=1.3:g=1.2,^
            acompressor=threshold=-14dB:ratio=2.8:attack=6:release=100:makeup=2.2dB,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[FR_adj];^
        [LFE]equalizer=f=60:width_type=o:width=1.2:g=6.5,^
            equalizer=f=90:width_type=o:width=1.0:g=3,^
            lowpass=f=115,^
            acompressor=threshold=-20dB:ratio=4:attack=4:release=120:makeup=2.5dB,^
            asubboost=boost=2.5,volume=1.3[LF_adj];^
        [BL]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=1.8,^
            equalizer=f=3500:width_type=o:width=1.2:g=1.5,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.4,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=15|17,^
            aecho=0.4:0.4:20|30:0.2|0.15,^
            dynaudnorm=f=150:g=8[BL_ready];^
        [BR]volume=1.8,equalizer=f=300:width_type=o:width=1.2:g=2,^
            equalizer=f=1800:width_type=o:width=1.4:g=2,^
            equalizer=f=2500:width_type=o:width=2:g=1.8,^
            equalizer=f=3500:width_type=o:width=1.2:g=1.5,^
            acompressor=threshold=-20dB:ratio=4:attack=5:release=110:makeup=3.0dB,^
            asubboost=boost=1.5,stereowiden=delay=15:feedback=0.2:crossfeed=0.6,^
            aphaser=type=t:speed=0.3,adelay=18|15,^
            aecho=0.4:0.4:20|30:0.2|0.15,^
            dynaudnorm=f=150:g=8[BR_ready];^
        [FL_adj][FR_adj][FC_enhanced][LF_adj][BL_ready][BR_ready]^
            join=inputs=6:channel_layout=5.1[a_out];^
        !LOUDNORM_CHAIN!
    " ^
    -map 0:v -map "[a_out_limited]" -map 0:s? ^
    -c:v copy -c:a eac3 -b:a 384k -c:s copy ^
    -metadata:s:a:0 language=ita -metadata:s:a:0 title="Clearvoice 5.1" ^
    "!OUTPUT!"

    echo ► Output: !OUTPUT!
)

endlocal


:: --------------------------------------------------------------------------------------------
:: === Virtual Height 5.1.2 (Simulazione verticale Atmos) ===
:: --------------------------------------------------------------------------------------------

🔊	:: Virtual Height 5.1.2 singolo file con opzione alimiter

ffmpeg -hwaccel cuda -i "MioVideo.mkv" -filter_complex "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];[FC]speechnorm=e=12.5:r=0.00001:l=1,equalizer=f=850:width_type=o:width=1.4:g=3,equalizer=f=1800:width_type=o:width=1.5:g=4.2,equalizer=f=3400:width_type=o:width=1.5:g=3,highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];[FL][FR]amerge=inputs=2,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];[stereo]asplit=2[st_left][st_right];[st_left]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_L];[st_right]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_R];[FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]join=inputs=8:channel_layout=5.1.2[a_out];[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 640k -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 Cinematic" "MioVideo-height512.mkv"

---

🔊	:: Virtual Height 5.1.2 molteplici file con opzione alimiter

@echo off
setlocal enabledelayedexpansion

for %%F in (*.mkv) do (
    echo Processing (Virtual Height 5.1.2 - Cinematic): %%F

    ffmpeg -hwaccel cuda -i "%%F" -filter_complex "
        [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
        [FC]speechnorm=e=12.5:r=0.00001:l=1,
            equalizer=f=850:width_type=o:width=1.4:g=3,
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,
            equalizer=f=3400:width_type=o:width=1.5:g=3,
            highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
        [FL][FR]amerge=inputs=2,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];
        [stereo]asplit=2[st_left][st_right];
        [st_left]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_L];
        [st_right]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_R];
        [FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]join=inputs=8:channel_layout=5.1.2[a_out];
        [a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" ^
        -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 640k -c:s copy ^
        -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 Cinematic" ^
        "%%~nF-height512.mkv"
)
endlocal

---

🎞️	:: Virtual Height 5.1.2 con opzione loudnorm (video non dinamici) file singolo (Batch pipeline)

@echo off
setlocal enabledelayedexpansion

:: CONFIG
set "INPUT=MioVideo.mkv"
set "OUTPUT=MioVideo-height512-cinematic.mkv"
set ENABLE_LOUDNORM=1
set BITRATE_AUDIO=640k

if !ENABLE_LOUDNORM! EQU 1 (
    set "LOUDNORM_CHAIN=[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
) else (
    set "LOUDNORM_CHAIN=[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
)

ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
    [FL][FR]amerge=inputs=2,
        stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];
    [stereo]asplit=2[st_left][st_right];
    [st_left]highpass=f=4800,
        aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_L];
    [st_right]highpass=f=4800,
        aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_R];
    [FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]
        join=inputs=8:channel_layout=5.1.2[a_out];
    !LOUDNORM_CHAIN!
" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a !BITRATE_AUDIO! -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 Cinematic" "!OUTPUT!"

endlocal


---

🎞️	:: Virtual Height 5.1.2 con opzione loudnorm (video non dinamici) multipli file (Batch pipeline)

@echo off
setlocal enabledelayedexpansion

set ENABLE_LOUDNORM=1
set BITRATE_AUDIO=640k

for %%F in (*.mkv) do (
    echo ► Processing: %%F

    set "INPUT=%%F"
    set "OUTPUT=%%~nF-height512-cinematic.mkv"

    if !ENABLE_LOUDNORM! EQU 1 (
        set "LOUDNORM_CHAIN=[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    ) else (
        set "LOUDNORM_CHAIN=[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    )

    ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex ^
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^
        [FC]speechnorm=e=12.5:r=0.00001:l=1,^
            equalizer=f=850:width_type=o:width=1.4:g=3,^
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,^
            equalizer=f=3400:width_type=o:width=1.5:g=3,^
            highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];^
        [FL][FR]amerge=inputs=2,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];^
        [stereo]asplit=2[st_left][st_right];^
        [st_left]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_L];^
        [st_right]highpass=f=4800,aecho=0.45:0.45:35|42:0.28|0.25,aphaser=type=t:speed=0.3,hcompand[HT_R];^
        [FL][FR][FC_enhanced][LFE][BL][BR][HT_L][HT_R]^
            join=inputs=8:channel_layout=5.1.2[a_out];^
        !LOUDNORM_CHAIN!
    " -map 0:v -map "[a_out_limited]" -map 0:s? ^
      -c:v copy -c:a eac3 -b:a !BITRATE_AUDIO! -c:s copy ^
      -metadata:s:a:0 language=ita -metadata:s:a:0 title="Virtual Height 5.1.2 Cinematic" ^
      "!OUTPUT!"

    echo ► Output: !OUTPUT!
)
endlocal



:: --------------------------------------------------------------------------------------------
:: === VERSIONE 3: Phantom Atmos 7.1.2 (Simulazione completa Atmos) ===
:: --------------------------------------------------------------------------------------------

🔊	:: Phantom Atmos 7.1.2 singolo file

ffmpeg -hwaccel cuda -i "MioVideo.mkv" -filter_complex "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];[FC]speechnorm=e=12.5:r=0.00001:l=1,equalizer=f=850:width_type=o:width=1.4:g=3,equalizer=f=1800:width_type=o:width=1.5:g=4.2,equalizer=f=3400:width_type=o:width=1.5:g=3,highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];[BL]highpass=f=4800,aphaser=type=t:speed=0.3,adelay=20|22,aecho=0.3:0.3:15|20:0.1|0.08[BACK_L];[BR]highpass=f=4800,aphaser=type=t:speed=0.3,adelay=22|20,aecho=0.3:0.3:15|20:0.1|0.08[BACK_R];[FL][FR]amerge=inputs=2,stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];[stereo]asplit=2[HTL_SRC][HTR_SRC];[HTL_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,aecho=0.45:0.45:35|42:0.28|0.25[HT_L];[HTR_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,aecho=0.45:0.45:35|42:0.28|0.25[HT_R];[FL][FR][FC_enhanced][LFE][BL][BR][BACK_L][BACK_R][HT_L][HT_R]join=inputs=10:channel_layout=7.1.2[a_out];[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 768k -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2 Cinematic" "MioVideo-sideheight712-cinematic.mkv"

---

🔊	:: Phantom Atmos 7.1.2 molteplici file

@echo off
setlocal enabledelayedexpansion

for %%F in (*.mkv) do (
    echo Processing (Phantom Atmos 7.1.2): %%F

    ffmpeg -hwaccel cuda -i "%%F" -filter_complex "
        [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
        [FC]speechnorm=e=12.5:r=0.00001:l=1,
            equalizer=f=850:width_type=o:width=1.4:g=3,
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,
            equalizer=f=3400:width_type=o:width=1.5:g=3,
            highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
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
        [a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]" ^
        -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a 448k -c:s copy ^
        -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2" ^
        "%%~nF-sideheight712.mkv"
)
endlocal

---

🎞️	:: Phantom Atmos 7.1.2 singolo file con loudnorm (Batch pipeline)
	
@echo off
setlocal enabledelayedexpansion

:: ========= CONFIGURAZIONE =========
set "INPUT=MioVideo.mkv"
set "OUTPUT=MioVideo-sideheight712.mkv"
set "BITRATE_AUDIO=448k"
set ENABLE_LOUDNORM=1

:: ========= LOGICA LOUDNORM =========
if !ENABLE_LOUDNORM! EQU 1 (
    set "LOUDNORM_CHAIN=[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
) else (
    set "LOUDNORM_CHAIN=[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
)

:: ========= ESECUZIONE =========
ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex "
    [0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];
    [FC]speechnorm=e=12.5:r=0.00001:l=1,
        equalizer=f=850:width_type=o:width=1.4:g=3,
        equalizer=f=1800:width_type=o:width=1.5:g=4.2,
        equalizer=f=3400:width_type=o:width=1.5:g=3,
        highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];
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
    !LOUDNORM_CHAIN!
" -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a !BITRATE_AUDIO! -c:s copy -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2" "!OUTPUT!"

endlocal

---	

🎞️	:: Phantom Atmos 7.1.2 molteplici file con loudnorm (Batch pipeline)

@echo off
setlocal enabledelayedexpansion

:: ========= CONFIGURAZIONE GLOBALE =========
set "BITRATE_AUDIO=448k"
set ENABLE_LOUDNORM=1

:: ========= INIZIO CICLO =========
for %%F in (*.mkv) do (
    echo ► Processing: %%F

    set "INPUT=%%F"
    set "OUTPUT=%%~nF-sideheight712.mkv"

    if !ENABLE_LOUDNORM! EQU 1 (
        set "LOUDNORM_CHAIN=[a_out]loudnorm=I=-16:TP=-1.5:LRA=11[a_out_limited]"
    ) else (
        set "LOUDNORM_CHAIN=[a_out]alimiter=limit=0.95:attack=4:release=50[a_out_limited]"
    )

    ffmpeg -hwaccel cuda -i "!INPUT!" -filter_complex ^
        "[0:a:0]channelsplit=channel_layout=5.1[FL][FR][FC][LFE][BL][BR];^
        [FC]speechnorm=e=12.5:r=0.00001:l=1,^
            equalizer=f=850:width_type=o:width=1.4:g=3,^
            equalizer=f=1800:width_type=o:width=1.5:g=4.2,^
            equalizer=f=3400:width_type=o:width=1.5:g=3,^
            highpass=f=70,lowpass=f=11500,dynaudnorm=f=90:g=6,volume=2.0[FC_enhanced];^
        [BL]highpass=f=4800,aphaser=type=t:speed=0.3,^
            adelay=20|22,aecho=0.4:0.4:20|30:0.2|0.15[BACK_L];^
        [BR]highpass=f=4800,aphaser=type=t:speed=0.3,^
            adelay=22|20,aecho=0.4:0.4:20|30:0.2|0.15[BACK_R];^
        [FL][FR]amerge=inputs=2,^
            stereowiden=delay=10:feedback=0.2:crossfeed=0.5[stereo];^
        [stereo]asplit=2[HTL_SRC][HTR_SRC];^
        [HTL_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,^
            aecho=0.4:0.4:20|30:0.2|0.15[HT_L];^
        [HTR_SRC]highpass=f=4800,aphaser=type=t:speed=0.3,^
            aecho=0.4:0.4:20|30:0.2|0.15[HT_R];^
        [FL][FR][FC_enhanced][LFE][BL][BR][BACK_L][BACK_R][HT_L][HT_R]^
            join=inputs=10:channel_layout=7.1.2[a_out];^
        !LOUDNORM_CHAIN!
    " -map 0:v -map "[a_out_limited]" -map 0:s? -c:v copy -c:a eac3 -b:a !BITRATE_AUDIO! -c:s copy ^
    -metadata:s:a:0 language=ita -metadata:s:a:0 title="Phantom Atmos 7.1.2" ^
    "!OUTPUT!"

    echo ► Output saved: !OUTPUT!
)
endlocal

:: --------------------------------------------------------------------------------------------



