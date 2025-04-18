# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto amico di avventure audio!  
Qui trovi un "arsenale" di pipeline FFmpeg pensate per tirare fuori il meglio dai tuoi film e serie TV in 5.1 quando il mix lascia a desiderare. Simula l’impossibile, amplifica il dialogo e allargha il surround... perché ogni bit conta!!!

---

## 🔧 Script Inclusi

### 🔊 **Clearvoice 5.1 (Enhanced)**

🎯 Focus sulla chiarezza vocale e bilanciamento surround.

- 🎙️ Dialoghi scolpiti sul canale centrale
- 🌌 Rear "ariosi" con echo e delay calibrati
- 📏 Loudnorm attivabile per volumi bilanciati

📂 Script: `clearvoice_single.sh`, `clearvoice_multi.sh`

### 🛰️ **Virtual Height 5.1.2 (Cinematic)**

🌫️ Altezza virtuale per un sound più immersivo.

- 🛸 Simulazione height leggera ma presente
- 🧘‍♂️ Rear lasciati intatti per naturalezza
- 📏 Loudnorm attivabile

📂 Script: `height512_single.sh`, `height512_multi.sh`

### 🌪️ **Phantom Atmos 7.1.2 (Cinematic)**

💥 Surround cinematografico anche senza Atmos nativo.

- 🌀 Rear doppi con echo realistico
- 🛸 Height ambientali
- 🧩 Layout Dolby Atmos 7.1.2 simulato

📂 Script: `phantom712_single.sh`, `phantom712_multi.sh`

---

## 🧠 **Script Intelligente Extra (Repair)**

### 🛠️ `repair_surround_single.sh` `repair_surround_multi.sh`

L’intelligenza artificiale... fatta a bash.

- 🔍 Rileva automaticamente se il file è stereo, 5.1 simulato o reale
- 🔁 Applica preset adattivi (Clearvoice, surround enhancement)
- 🧠 Scelte automatiche in base alla qualità rilevata

📂 Script: `repair_surround_adaptive.sh`, `repair_surround_multi.sh`

---

## ⚙️ **Requisiti**

- 🎛️ FFmpeg (versione full, consigliata da [gyan.dev](https://www.gyan.dev/ffmpeg/builds/)
- 🖥️ Linux, macOS, o Windows con Git Bash / Cygwin / WSL
- 🎥 File con audio 5.1 in AC3/EAC3 (ma anche stereo per conversione)

---

## 🚀 **Come si usano?**

### ▶️ **Modalità Singolo File**

```bash
./clearvoice_single.sh
./height512_single.sh
./phantom712_single.sh
./repair_surround_single.sh
```

### 📁 **Modalità Batch (multi-file)**

```bash
./clearvoice_multi.sh
./height512_multi.sh
./phantom712_multi.sh
./repair_surround_multi.sh
```

Puoi personalizzare input/output e parametri direttamente nello script o tramite variabili d’ambiente.

---

## 🔍 **Focus su `repair_surround_adaptive.sh`**

Questo script analizza l’audio e decide il da farsi:

### 📥 **Input**

- File `.mkv`, `.mp4`, ecc.

### 🤖 **Analisi layout**

- **Stereo** ➜ Simula 5.1 + Clearvoice
- **5.1 sospetto** ➜ Applica Clearvoice + potenzia surround
- **5.1 reale** ➜ Solo Clearvoice, con avviso

### 🎣 **Filtro Clearvoice**

- `speechnorm`, `equalizer`, `dynaudnorm`, `highpass`, `lowpass`

### 🔊 **Espansione surround (se richiesta)**

- `stereowiden`, `aecho`, `aphaser`

---

## 🚀 **Codifica**

Lo script utilizza di default `-hwaccel cuda` per sfruttare l'accelerazione hardware **NVIDIA CUDA** durante la decodifica video.  
Tuttavia, puoi modificare questo parametro in base alla tua configurazione hardware.

### ⚡ Altre opzioni di accelerazione supportate da FFmpeg

| Accelerazione     | Parametro FFmpeg        | Note                                                      |
|-------------------|--------------------------|-----------------------------------------------------------|
| **CUDA**          | `-hwaccel cuda`          | Solo per GPU NVIDIA. È il default negli script.           |
| **DXVA2**         | `-hwaccel dxva2`         | Per GPU AMD/NVIDIA su Windows.                            |
| **D3D11VA**       | `-hwaccel d3d11va`       | Alternativa moderna a DXVA2 su Windows 10+.               |
| **VAAPI**         | `-hwaccel vaapi`         | Per GPU Intel/AMD su Linux (richiede setup extra).        |
| **Videotoolbox**  | `-hwaccel videotoolbox`  | Per macOS con GPU integrata Apple.                        |

> 🔧 **Nota:** puoi modificare la riga `ffmpeg` negli script per sostituire `-hwaccel cuda` con l’opzione più adatta al tuo sistema.

### 📌 **Esempi**

**Su Windows con GPU AMD:**
```bash
ffmpeg -hwaccel dxva2 -i input.mkv ...
```

**Su Linux con VAAPI:**
```bash
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -i input.mkv ...
```

**Output finale:**
- Codifica in `AC3` o `EAC3` a bitrate configurabile

---

## 🏷️ **Output naming**

- `-repairadaptive.mkv`
- `-sideheight712.mkv` 
- `-clearvoice51.mkv`  
- `-height512.mkv`

---

## 🎚️ **Personalizzazioni**

Tutti gli script supportano:

- ✅ Abilitazione/disattivazione loudnorm → `ENABLE_LOUDNORM=1` o `0`
- ✅ Bitrate configurabile → `BITRATE_AUDIO=384k` fino a `720k`
- ✅ Suffisso automatico nel nome file in base al miglioramento effettuato

---

## 🎙️ **Frequenze della Voce Umana**

### 🎙️ **Frequenze chiave per la voce e l'intelligibilità**

| Tipo di Voce       | Gamma Frequenze      |
|--------------------|----------------------|
| 🧔 Uomo parlato     | 85 – 180 Hz          |
| 👩 Donna parlato    | 165 – 255 Hz         |
| 🧒 Bambino          | 250 – 400 Hz         |
| 📈 Intelligibilità  | 300 – 3400 Hz        |
| 🔊 Sibili           | 4000 – 8000 Hz       |

---

## 🇮🇹 **Specificità della Voce Italiana**

La lingua italiana presenta:

- 🎯 Vocali ben marcate: A, E, I, O, U
- 💥 Consonanti forti e plosive (P, T, C)

🎛️ Filtri ideali:

- **500 Hz – 3.5 kHz** → articolazione e chiarezza  
- **5 – 8 kHz** → nitidezza dei sibili  
- **100 – 300 Hz** → corpo e presenza vocale

---

## 🧪 **Obiettivo dei Preset**

- ✅ Dialoghi nitidi anche in ambienti rumorosi
- 🎧 Surround realistico su sistemi 5.1, 5.1.2 e 7.1.2
- 🚀 Compatibilità con soundbar, TV e home theater moderni

---

## 📜 **Licenza**

Uso personale, studio, sperimentazione.  
Miglioralo, remixalo, condividilo.  
Nessun DRM, solo D-I-Y.

---

## 🎬 **Buona visione (e ascolto)!**

**Dal un Nerd ai Nerd: che il Surround sia con voi.**  
– Sandro (aka **D@mocle77**)
