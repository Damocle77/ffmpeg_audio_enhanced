# 🎧 Audio Enhancement Scripts – FFmpeg Nerd Edition

Ovvero una collezione di pipeline avanzate FFmpeg per l'elaborazione audio multicanale, progettata per migliorare, per simulare o enfatizzare: 

**chiarezza dei dialoghi sidechain**
**spazialità surround 7.1.2** 
**verticalità height 5.1.2**,
 
 mantenendo compatibilità massima con dispositivi comuni (TV, Soundbar, Lettori da tavolo, ecc.).

---

## 📜 Cos'è incluso

### 🔊 Clearvoice 5.1 (Sidechain)
- Potenzia i **dialoghi centrali** con equalizzatori mirati e compressione sidechain.
- Mantiene il layout 5.1 originale.
- Ideale per film parlati, commedie o vecchi mix con dialoghi bassi.

### 🏔️ Virtual Height 5.1.2
- Aggiunge 2 canali virtuali "height" (alti) creando un effetto Atmos verticale enfatizzato o simulato.
- Usa **delay, echo e phaser** filtrati per dare sensazione di altezza.
- Perfetto per film epici, fantascienza e colonne sonore ampie.

### 🌌 Phantom Atmos 7.1.2
- Espande il mix a 7.1.2 simulando **surround posteriori** e **height**, anche su sorgente 5.1.
- Totalmente virtuale ma molto coinvolgente soprattutto su HW 5.1.2 nativo.
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

- `1` (ON) → voce sempre chiara, ma anche il volume complessivo viene "normalizzato" → utile per playlist, dialoghi sussurrati, visione notturna
- `0` (OFF) → stesso trattamento sulla voce, ma la dinamica del mix (esplosioni forti, silenzi intensi) resta intatta → più cinematografico, potente

---

## 🔊 Codec finale

- Audio: **EAC3** (Dolby Digital Plus) a 384k / 640k / 768k a seconda del preset
- Video e sottotitoli: **copia diretta**, nessuna ricodifica

---

## ✅ Compatibilità

- Funziona perfettamente con: **NVIDIA Shield**, **Plex**, **Kodi**, **VLC**, **lettori HDMI ARC**, **TV moderne**, **Soundbar**
- Compatibile anche con proiettori e downmix stereo automatico

---

## 📁 Uso personale

Questi script sono pensati per uso personale, studio e miglioramento del comfort di ascolto.  
Condivisibili liberamente con altri nerd dell'audio e appassionati di home cinema. 🍿

---

# 🎧 Audio Enhancement Pipelines (FFmpeg)

## ✅ Clearvoice 5.1 (Enhanced)

✔️ **Sidechain attivo** tra dialoghi e mix (compressore con `FC_enhanced`)  
✔️ Versioni disponibili: **singolo file**, **batch**, **loudnorm ON/OFF**  
✔️ **Bitrate coerente** (384k per serie/dialoghi, 640k per film)  
✔️ **Filtro `speechnorm` + equalizer** su FC, ottimizzato per lingua italiana  
✔️ Rear con **echo realistico ma controllato**

---

## ✅ Virtual Height 5.1.2 (Cinematic)

✔️ **Altezza simulata** su L e R tramite `asplit` e filtri soft (`aecho`, `aphaser`, `hcompand`)  
✔️ Loudnorm **opzionale** con fallback su limiter  
✔️ **Bitrate** coerente a 448k o 640k  
✔️ **Channel layout `5.1.2`** ben dichiarato con `join=inputs=8`  
✔️ Rear **non modificati** → height only focus ✅

---

## ✅ Phantom Atmos 7.1.2 (Cinematic)

✔️ **Height simulati** (HT_L, HT_R) con eco ambientale  
✔️ **Rear doppi**: BL, BR + BACK_L, BACK_R per profondità spaziale  
✔️ Layout **7.1.2 completo** → `join=inputs=10:channel_layout=7.1.2`  
✔️ Volume, filtri ed encoding **ottimizzati e bilanciati**  
✔️ **Loudnorm ON/OFF** in tutte le versioni  
✔️ Bitrate: **768k per film**, **448k per serie / echo light**

---

## ✅ Repair Surround Adaptive (Auto Surround)

✔️ **Rilevamento automatico layout** (stereo vs 5.1)  
✔️ **Stereo → 5.1** con Clearvoice: dialoghi potenziati e surround virtuale  
✔️ **5.1 → Enhancer**: speechnorm, equalizer e echo per surround BL/BR  
✔️ Layout **5.1 completo** → `join=inputs=6:channel_layout=5.1`  
✔️ **Loudnorm ON/OFF** via variabile `ENABLE_LOUDNORM`  
✔️ Bitrate audio: **384k** (configurabile con `BITRATE_AUDIO`)  

## 🧩 Compatibilità & Congruenza

| Sezione               | Bitrate        | Loudnorm   | Canali Simulati | Note                          |
|-----------------------|----------------|------------|------------------|-------------------------------|
| **Clearvoice 5.1**     | 384k / 640k    | ✅ ON/OFF  | Dialoghi         | Ideale per commedie e dialoghi |
| **Virtual Height 5.1.2** | 448k / 640k    | ✅ ON/OFF  | Height (L+R)     | Effetto soft, ambientale       |
| **Phantom Atmos 7.1.2** | 448k / 768k    | ✅ ON/OFF  | Height + Rear    | Massima immersione            |

---

- 🎛️ FFmpeg (versione full, consigliata da [gyan.dev](https://www.gyan.dev/ffmpeg/builds/) da inserire nelle variabili di ambiente:

  - **Windows (PowerShell):**
    1. Scarica e decomprimi il pacchetto in `C:\ffmpeg`.
    2. Apri PowerShell come amministratore e lancia:
       ```powershell
       [Environment]::SetEnvironmentVariable('FFMPEG_HOME','C:\ffmpeg','Machine')
       $old = [Environment]::GetEnvironmentVariable('Path','Machine')
       [Environment]::SetEnvironmentVariable('Path', "$old;C:\ffmpeg\bin", 'Machine')
       ```
    3. Chiudi e riapri il terminale:  
       ```powershell
       ffmpeg -version
       ```
  - **Linux/macOS (bash/zsh):**
    1. Scarica e decomprimi in `~/ffmpeg`.
    2. Aggiungi al tuo `~/.bashrc` o `~/.zshrc`:
       ```bash
       export FFMPEG_HOME="$HOME/ffmpeg"
       export PATH="$FFMPEG_HOME/bin:$PATH"
       ```
    3. Ricarica il profilo:
       ```bash
       source ~/.bashrc   # o `source ~/.zshrc`
       ffmpeg -version
       ```

📁 Ogni pipeline è pronta per bash processing o batch su Windows (con Gitbash, CGwin o WSL) ed è compatibile con:

- 🎬 File `.mkv, .mp4`
- 🔊 Input audio 5.1
- 🧠 Ottimizzazione per lingua **italiana**
- 🎛️ Personalizzazione: bitrate, loudnorm, nomi file

---

💡 *Progetto pensato per ottenere il massimo da Soundbar, AVR 5.1, o set 5.1.2 reali simulando contenuti spatial anche dove non presenti.*
