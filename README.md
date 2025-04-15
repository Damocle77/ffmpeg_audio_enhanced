# 🎧 Audio Enhancement Scripts – FFmpeg Nerd Edition

Una collezione di script FFmpeg per l'elaborazione audio multicanale 5.1 avanzata, progettata per migliorare **chiarezza dei dialoghi**, **spazialità surround** e simulazione **Atmos verticale**, mantenendo compatibilità massima con dispositivi comuni (TV, soundbar, lettori, Plex, Shield, ecc.).

---

## 📜 Cos'è incluso

### 🔊 Clearvoice 5.1 (Sidechain)
- Potenzia i **dialoghi centrali** con equalizzatori mirati e compressione sidechain.
- Mantiene il layout 5.1 originale.
- Ideale per film parlati, commedie o vecchi mix con dialoghi bassi.

### 🏔️ Virtual Height 5.1.2
- Aggiunge 2 canali virtuali "height" (alti) creando un effetto Atmos verticale simulato.
- Usa **delay, echo e phaser** filtrati per dare sensazione di altezza.
- Perfetto per film epici, fantascienza e colonne sonore ampie.

### 🌌 Phantom Atmos 7.1.2
- Espande il mix a 7.1.2 simulando **surround posteriori** e **height**, anche su sorgente 5.1.
- Totalmente virtuale ma molto coinvolgente.
- Il preset più immersivo, consigliato per proiettori o soundbar Atmos.

---

## ⚙️ Tecniche utilizzate

- `speechnorm`, `equalizer`, `highpass/lowpass` → Per migliorare l’intelligibilità delle voci
- `acompressor`, `dynaudnorm`, `alimiter` → Per controllare la dinamica
- `stereowiden`, `aphaser`, `aecho` → Per aumentare il senso di spazialità e altezza
- `asubboost`, `adelay`, `amerge`, `join` → Per gestione avanzata di subwoofer e surround

---

## 📐 Loudnorm: ON o OFF?

Tutti gli script includono una variabile `ENABLE_LOUDNORM`:

- `1` (ON) → Normalizza il loudness tra film diversi (utile per playlist o TV)
- `0` (OFF) → Mantiene la dinamica originale del mix (consigliato per cinema o azione)

---

## 🔊 Codec finale

- Audio: **EAC3** (Dolby Digital Plus) a 384k / 640k / 768k a seconda del preset
- Video e sottotitoli: **copia diretta**, nessuna ricodifica

---

## ✅ Compatibilità

- Funziona perfettamente con: **NVIDIA Shield**, **Plex**, **Kodi**, **VLC**, **lettori HDMI ARC**, **TV moderne**, **soundbar LG / Samsung / Sonos**
- Compatibile anche con proiettori e downmix stereo automatico

---

## 📁 Uso personale

Questi script sono pensati per uso personale, studio e miglioramento del comfort di ascolto.  
Condivisibili liberamente con altri nerd dell'audio e appassionati di home cinema. 🍿

---

✨ Powered by FFmpeg, scritto con amore, testato su un sistema 5.1.2 con attenzione alla lingua italiana e ai dialoghi dei film.

## 🔧 Compatibilità hardware e sistema operativo

> Questi script sono ottimizzati per **sistemi Windows** con **schede NVIDIA**.

### 🎮 Accelerazione hardware (video decoding)
Per massima velocità, è raccomandato l’uso di un acceleratore video hardware.  
Il parametro `-hwaccel` può essere modificato in base alla scheda video:

| Scheda Video     | Parametro da usare           |
|------------------|------------------------------|
| NVIDIA           | `-hwaccel cuda`              |
| AMD Radeon       | `-hwaccel dxva2`             |
| Intel (iGPU / ARC)| `-hwaccel qsv`              |

⚠️ **Nota**: L'accelerazione hardware è usata solo per il **decoding video**.  
L'elaborazione audio viene sempre eseguita via **CPU**.

---

### 🖥️ Requisiti di sistema

- **Sistema operativo**: Windows 10/11 (consigliato)
- **FFmpeg**: deve essere installato manualmente
- È **fortemente consigliato** aggiungere `ffmpeg` alle **variabili d'ambiente (PATH)** per poter eseguire gli script da qualsiasi cartella

---
