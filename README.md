# 🎧 Pipeline FFmpeg per Soundbar e Home Theater

Benvenuto amico Nerd del suono digitale! Questo repository contiene **script audio avanzati basati su FFmpeg** per ottimizzare film e serie TV in 5.1 e per simulare (se non disponibili) 5.1.2 e 7.1.2, migliorando, nel contempo, **chiarezza dei dialoghi** ed enfatizzando o simulando **spazialità surround** e **canali height** per sistemi audio multicanale.

---

## 🔧 Script Inclusi

### 🔊 Clearvoice 5.1 (Enhanced)
- ✅ Ottimizzazione dialoghi sul canale centrale
- ✅ Rear "spazializzati" con echo e delay realistici
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
- 💻 Ambiente Linux o Windows con **Git Bash** o **Cygwin** o **WSL**
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
- Attivazione/disattivazione `loudnorm` (`ENABLE_LOUDNORM=1/0`)
- Impostazione bitrate (`BITRATE_AUDIO=384k-720k`)
- Output automatico con suffisso coerente

---

## 🎙️ Gamma di Frequenze della Voce Umana

| Tipo di Voce                                      | Gamma Approssimativa     |
|--------------------------------------------------|---------------------------|
| 🧔 Parlato (uomo)                                 | 85 Hz – 180 Hz            |
| 👩 Parlato (donna)                                | 165 Hz – 255 Hz           |
| 🧒 Parlato (bambini)                              | 250 Hz – 400 Hz           |
| 📈 Contenuto armonico utile per l’intelligibilità | **300 Hz – 3400 Hz**      |
| 🔊 Sibili e consonanti fricative (`s`, `f`, ecc.) | **4 kHz – 8 kHz**         |

> 📌 Queste frequenze sono fondamentali per comprendere come ottimizzare l’equalizzazione in base alla voce e al tipo di contenuto (film, serie TV, podcast, doppiaggio, ecc.).

## 🔊 Caratteristiche della Voce Italiana

L’italiano ha suoni vocalici ben marcati (`A`, `E`, `I`, `O`, `U`) e consonanti spesso plosive (`P`, `T`, `C`).  
Per questo motivo, l’intelligibilità della voce italiana dipende molto da:

- 🎯 **500 Hz – 3.5 kHz**  
  Frequenze fondamentali per la **chiarezza** e **comprensione delle parole**.
  
- ✨ **5 – 8 kHz**  
  Gamma utile per migliorare la **nitidezza dei sibili** e delle consonanti fricative (come `"s"`, `"sc"`, `"z"`).

- 💪 **100 – 300 Hz**  
  Frequenze che danno **corpo**, **presenza** e una sensazione di **voce piena**.

---

## 🎧 Preset Audio Ottimizzati

Questi preset sono pensati ed ideati per:

- ✅ **Preservare la dinamica** naturale della voce
- 🗣️ **Migliorare la comprensione vocale**, anche in ambienti rumorosi
- 🌐 **spazialità 3D compatibile** con amplificatori multicanali o soundbar moderne e non

---

## 📝 Licenza

Uso personale, studio, sperimentazione.  
Se ti piacciono, migliorali e condividi!

---

**Buon ascolto! Da Sandro (AKA D@mocle77) 🎬🔉**
