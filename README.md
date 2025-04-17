# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto! Questo repository contiene **script audio avanzati basati su FFmpeg** per ottimizzare film e serie TV in 5.1, 5.1.2 e 7.1.2, migliorando **chiarezza dei dialoghi, spazialità surround** e **simulazione canali height** per sistemi compatibili con Dolby Atmos e simili.

---

## 🔧 Script Inclusi

### 🔊 Clearvoice 5.1 (Enhanced)
- ✅ Ottimizzazione dialoghi sul canale centrale
- ✅ Rear spazializzati con echo e delay realistici
- ✅ Volume bilanciato con loudnorm opzionale
- 📦 `clearvoice_single.sh` e `clearvoice_multi.sh`

### 🛰️ Virtual Height 5.1.2 (Cinematic)
- ✅ Simulazione canali height (L+R) ambientali
- ✅ Rear invariati, height leggeri per layer verticale
- ✅ Loudnorm opzionale
- 📦 `height512_single.sh` e `height512_multi.sh`

### 🌪️ Phantom Atmos 7.1.2 (Cinematic)
- ✅ Rear doppi (side + back) con echo realistico
- ✅ Simulazione height ambientali
- ✅ Layout 7.1.2 compatibile Dolby Atmos
- 📦 `phantom712_single.sh` e `phantom712_multi.sh`

---

## ⚙️ Requisiti

- 🧠 FFmpeg (versione avanzata, es. da [gyan.dev](https://www.gyan.dev/ffmpeg/builds/))
- 💻 Ambiente Linux o Windows con **Git Bash** o **Cygwin**
- 🎧 File sorgente con traccia audio 5.1 (AC3/EAC3)

---

## 🚀 Come si usano?

### Modalità Singolo File

```bash
./clearvoice_single.sh
./height512_single.sh
./phantom712_single.sh
```

> Modifica il nome del file in input direttamente nello script oppure tramite variabili d'ambiente.

### Modalità Batch (multi-file)

```bash
./clearvoice_multi.sh
./height512_multi.sh
./phantom712_multi.sh
```

> Elabora automaticamente tutti i file `.mkv` presenti nella cartella.

---

## 🔄 Personalizzazioni

Ogni script supporta:
- Attivazione/disattivazione `loudnorm` (`ENABLE_LOUDNORM=1`)
- Impostazione bitrate (`BITRATE_AUDIO=384k`-`720k`)
- Output automatico con suffisso coerente

---

## 🧠 Informazioni

Questi preset sono pensati per **preservare la dinamica**, migliorare la **comprensione vocale**, e offrire **spazialità 3D compatibile con soundbar moderne** (LG, Samsung, Sony, ecc.).  
Ideali per contenuti in italiano, anche con mix non perfetti (es. film anni 2000, serie italiane, ecc.).

---

## 📝 Licenza

Uso personale, studio, sperimentazione.  
Se ti piacciono, migliorali e condividi!

---

**Buona visione e buon ascolto! 🎬🔉**
