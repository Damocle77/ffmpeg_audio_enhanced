
# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto amico Nerd del suono digitale! Questo repository contiene script audio avanzati basati su FFmpeg per ottimizzare film e serie TV in 5.1 e per simulare (se non disponibili) 5.1.2 e 7.1.2, migliorando, nel contempo, chiarezza dei dialoghi ed enfatizzando la spazialità surround e canali height per sistemi audio multicanale.

---

## 🔧 Script Inclusi

### 🔊 Clearvoice 5.1 (Enhanced)
- ✅ Ottimizzazione dialoghi sul canale centrale
- ✅ Rear "spazializzati" con echo e delay realistici
- ✅ Volume bilanciato con loudnorm opzionale  
📦 `clearvoice_single.sh`, `clearvoice_multi.sh`

### 🛰️ Virtual Height 5.1.2 (Cinematic)
- ✅ Simulazione canali height (L+R) ambientali
- ✅ Rear invariati, height leggeri per layer verticale
- ✅ Loudnorm opzionale  
📦 `height512_single.sh`, `height512_multi.sh`

### 🌪️ Phantom Atmos 7.1.2 (Cinematic)
- ✅ Rear doppi (side + back) con echo realistico
- ✅ Simulazione height ambientali
- ✅ Layout 7.1.2 compatibile Dolby Atmos  
📦 `phantom712_single.sh`, `phantom712_multi.sh`

---

## 🧪 Script Intelligente Aggiuntivo

### 🛠️ repair_surround_adaptive.sh
- ✅ Analizza automaticamente se l'audio è stereo o 5.1
- ✅ Se stereo ➜ converte con preset Clearvoice 5.1
- ✅ Se 5.1 simulato ➜ migliora surround
- ✅ Se 5.1 reale ➜ applica solo Clearvoice

---

## ⚙️ Requisiti
- 🧠 FFmpeg (versione avanzata, es. da gyan.dev)
- 💻 Ambiente Linux o Windows con Git Bash / Cygwin / WSL
- 🎧 File sorgente con traccia audio 5.1 (AC3/EAC3)

---

## 🚀 Come si usano?

### Modalità Singolo File
```bash
./clearvoice_single.sh
./height512_single.sh
./phantom712_single.sh
```

### Modalità Batch (multi-file)
```bash
./clearvoice_multi.sh
./height512_multi.sh
./phantom712_multi.sh
```

**## repair_surround_adaptive.sh**
'''bash
./repair_surround_adaptive.sh
'''

Modifica il nome del file in input direttamente nello script oppure tramite variabili d'ambiente.

---

## 🔄 Personalizzazioni

Ogni script supporta:

- Attivazione/disattivazione loudnorm (`ENABLE_LOUDNORM=1/0`)
- Impostazione bitrate (`BITRATE_AUDIO=384k` fino a `720k`)
- Output automatico con suffisso coerente

---

## 🎙️ Gamma di Frequenze della Voce Umana

| Tipo di Voce     | Gamma Approssimativa        |
|------------------|-----------------------------|
| 🧔 Uomo parlato   | 85 Hz – 180 Hz              |
| 👩 Donna parlato  | 165 Hz – 255 Hz             |
| 🧒 Bambini        | 250 Hz – 400 Hz             |
| 📈 Intelligibilità| 300 Hz – 3400 Hz            |
| 🔊 Sibili         | 4 kHz – 8 kHz               |

---

## 🔊 Caratteristiche della Voce Italiana

L’italiano ha suoni vocalici ben marcati (A, E, I, O, U) e consonanti spesso plosive (P, T, C).  
Per migliorare la chiarezza:

- 🎯 500 Hz – 3.5 kHz: per comprendere le parole
- ✨ 5 – 8 kHz: per nitidezza sibili e fricative
- 💪 100 – 300 Hz: corpo e presenza vocale

---

## 🎧 Preset Audio Ottimizzati

Pensati per:

- ✅ Preservare la dinamica naturale della voce
- 🗣️ Migliorare la comprensione anche in ambienti rumorosi
- 🌐 Spazialità 3D compatibile con sistemi moderni

---

## 📝 Licenza

Uso personale, studio, sperimentazione.  
Se ti piacciono, migliorali e condividi!

---

## Buon ascolto! 🎬🔉
**Da un nerd ai fratelli di bit. Che il surround sia con voi!**  
– Sandro (AKA D@mocle77)
