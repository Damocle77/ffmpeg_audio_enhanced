# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto amico Nerd di avventure audio!  
Qui trovi un "arsenale£ di pipeline FFmpeg pensate per tirare fuori il meglio dai tuoi film e serie TV in 5.1, anche quando il mix lascia a desiderare.  
Simuliamo l’impossibile, amplifichiamo il dialogo e allarghiamo il surround... perché ogni bit conta!

---

## 🔧 Script Inclusi

### 🔊 Clearvoice 5.1 (Enhanced)
🎯 Focus sulla chiarezza vocale e bilanciamento surround.

- 🎙️ Dialoghi scolpiti sul canale centrale  
- 🌌 Rear "ariosi" con echo e delay calibrati  
- 📏 Loudnorm attivabile per volumi bilanciati  

📂 **Script:** `clearvoice_single.sh`, `clearvoice_multi.sh`

---

### 🛰️ Virtual Height 5.1.2 (Cinematic)
🌫️ Altezza virtuale per un sound più immersivo.

- 🛸 Simulazione height leggera ma presente  
- 🧘‍♂️ Rear lasciati intatti per naturalezza  
- 📏 Loudnorm attivabile  

📂 **Script:** `height512_single.sh`, `height512_multi.sh`

---

### 🌪️ Phantom Atmos 7.1.2 (Cinematic)
💥 Surround cinematografico anche senza Atmos nativo.

- 🌀 Rear doppi con echo realistico  
- 🛸 Height ambientali  
- 🧩 Layout Dolby Atmos 7.1.2 simulato  

📂 **Script:** `phantom712_single.sh`, `phantom712_multi.sh`

---

## 🧠 Script Intelligente Extra

### 🛠️ repair_surround_adaptive.sh
L’intelligenza artificiale... fatta a bash.

- 🔍 Rileva automaticamente se il file è stereo, 5.1 simulato o reale  
- 🔁 Applica preset adattivi (Clearvoice, surround enhancement)  
- 🧠 Scelte automatiche in base alla qualità rilevata  

📂 **Script:** `repair_surround_adaptive.sh`, `repair_surround_multi.sh`

---

## ⚙️ Requisiti

- 🎛️ **FFmpeg** (versione full, consigliata da [gyan.dev](https://www.gyan.dev/ffmpeg/))
- 🖥️ Linux, macOS, o Windows con Git Bash / Cygwin / WSL
- 🎥 File con audio 5.1 in AC3/EAC3 (ma anche stereo per conversione)

---

## 🚀 Come si usano?

### ▶️ Modalità Singolo File
```bash
./clearvoice_single.sh
./height512_single.sh
./phantom712_single.sh
./repair_surround_adaptive.sh
```

### 📁 Modalità Batch (multi-file)
```bash
./clearvoice_multi.sh
./height512_multi.sh
./phantom712_multi.sh
./repair_surround_multi.sh
```

Puoi personalizzare input/output e parametri direttamente nello script o tramite variabili d’ambiente.

---

## 🔍 Focus su `repair_surround_adaptive.sh`

Questo script analizza l’audio e decide il da farsi:

### 📥 Input
- File `.mkv`, `.mp4`, ecc.

### 🤖 Analisi layout
- **Stereo** ➜ Simula 5.1 + Clearvoice  
- **5.1 sospetto** ➜ Applica Clearvoice + potenzia surround  
- **5.1 reale** ➜ Solo Clearvoice, con avviso  

### 🎣 Filtro Clearvoice
- `speechnorm`, `equalizer`, `dynaudnorm`, `highpass`, `lowpass`

### 🔊 Espansione surround (se richiesta)
- `stereowiden`, `aecho`, `aphaser`

### 🚀 Codifica
- Supporto CUDA (`-hwaccel cuda`) se disponibile  
- Output in EAC3 a 640kbit/s

### 🏷️ Output naming
- `-clearvoice51.mkv`  
- `-repairupmix.mkv`  
- `-enhanced.mkv`

---

## 🎚️ Personalizzazioni

Tutti gli script supportano:

- ✅ Abilitazione/disattivazione loudnorm → `ENABLE_LOUDNORM=1` o `0`  
- ✅ Bitrate configurabile → `BITRATE_AUDIO=384k` fino a `720k`  
- ✅ Suffisso automatico nel nome file in base al miglioramento effettuato

---

## 🎙️ Frequenze della Voce Umana

| Tipo di Voce     | Gamma Frequenze               |
|------------------|-------------------------------|
| 🧔 Uomo parlato   | 85 – 180 Hz                   |
| 👩 Donna parlato  | 165 – 255 Hz                  |
| 🧒 Bambino        | 250 – 400 Hz                  |
| 📈 Intelligibilità| 300 – 3400 Hz                 |
| 🔊 Sibili         | 4 – 8 kHz                     |

---

## 🇮🇹 Specificità della Voce Italiana

La lingua italiana presenta:

- 🎯 Vocali ben marcate: A, E, I, O, U  
- 💥 Consonanti forti e plosive (P, T, C)

🎛️ Filtri ideali:

- **500 Hz – 3.5 kHz** → articolazione e chiarezza  
- **5 – 8 kHz** → nitidezza dei sibili  
- **100 – 300 Hz** → corpo e presenza vocale

---

## 🧪 Obiettivo dei Preset

- ✅ Dialoghi nitidi anche in ambienti rumorosi  
- 🎧 Surround realistico su sistemi 5.1, 5.1.2 e 7.1.2  
- 🚀 Compatibilità con soundbar, TV e home theater moderni  

---

## 📜 Licenza

Uso personale, studio, sperimentazione.  
Miglioralo, remixalo, condividilo.  
Nessun DRM, solo D-I-Y.

---

## 🎬 Buona visione (e ascolto)!

**Dal nerd al nerd: che il surround sia con voi.**  
– Sandro (aka **D@mocle77**)
