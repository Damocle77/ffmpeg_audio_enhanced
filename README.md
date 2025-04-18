# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto compagno di avventure audio!  
Qui trovi un arsenale di script FFmpeg pensati per tirare fuori il meglio dai tuoi film e serie TV in 5.1, anche quando il mix lascia a desiderare. Simuliamo l’impossibile, amplifichiamo il dialogo e allarghiamo il surround... perché ogni bit conta.

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
📂 **Script unico:** `repair_surround_adaptive.sh`

---

## ⚙️ Requisiti

- 🎛️ **FFmpeg** (versione full, consigliata da [gyan.dev](https://www.gyan.dev/ffmpeg/))
- 🖥️ Linux, macOS, o Windows con Git Bash / Cygwin / WSL
- 🎥 File con audio 5.1 in AC3/EAC3 (ma anche stereo per conversione)

---

## 🚀 Come si usano?

### ▶️ Singolo file:
```bash
./clearvoice_single.sh
./height512_single.sh
./phantom712_single.sh
