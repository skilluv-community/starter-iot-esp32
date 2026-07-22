# Architecture — starter-iot-esp32

## Choix opinionated

### 1. Deux implémentations, une cible

Même comportement (blink + lecture DHT22 optionnelle) implémenté deux fois :

- **MicroPython** — path "rapide, pardonnant, plus lent + plus lourd RAM"
- **Rust + Embassy** — path "setup dur mais zéro overhead + memory-safe"

Permet un atelier qui commence en MicroPython puis passe en Rust.

### 2. `esp-hal 0.22` + `esp-hal-embassy`

HAL Rust d'Espressif, activement développé. Embassy = runtime async. Panic + prints via `esp-backtrace` + `esp-println`.

### 3. `machine.Pin` + `dht` stdlib

Zéro dépendance tierce. `dht.DHT22` livré dans l'image MicroPython.

### 4. Capteur optionnel

Si DHT22 pas câblé, code catch l'ImportError/OSError et continue en blink-only. Premier flash toujours "quelque chose est vivant" sans hardware externe.

### 5. Cible KiCad documentée, pas livrée

Board assez petite pour recréer depuis la BOM en 15 min. Livrer `.kicad_pcb` binaire = diffs pauvres.

## Hors scope

- Wi-Fi / MQTT (`esp-wifi` Rust, `network` + `umqtt.simple` MicroPython).
- OTA.
- Deep-sleep.
- Variantes non-classiques (S3, C3, C6, H2).
