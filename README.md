# starter-iot-esp32

> A Skilluv starter — ESP32 blink + DHT22 read, in both **Rust embedded (esp-hal + Embassy)** and **MicroPython**, with a KiCad target board reference.

[![CI](https://github.com/skilluv-community/starter-iot-esp32/actions/workflows/ci.yml/badge.svg)](https://github.com/skilluv-community/starter-iot-esp32/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
[![Skilluv](https://img.shields.io/badge/skilluv-community-emerald)](https://skilluv.io)

## English

### What this is

The most beginner-friendly path onto the ESP32. Two parallel implementations of
"blink the LED and read a temperature sensor" that you can pick from depending
on your background:

- **Rust** (`rust/`) — `esp-hal 0.22` + `esp-hal-embassy` for async, `esp-println` for
  logs, panic handler via `esp-backtrace`. Requires the `esp` Rust toolchain
  installed with `espup`.
- **MicroPython** (`micropython/`) — vanilla `boot.py` + `main.py`, flashed onto
  the official MicroPython ESP32 image. No compiler needed.

A `kicad/README.md` describes a small PCB target (ESP32 DevKit + DHT22 + status
LED) with a Bill of Materials adapted for African prices.

### Hardware

- **Board**: ESP32 DevKit V1 (or any WROOM-32 dev board with USB serial)
- **Sensor**: DHT22 (AM2302) — optional; the code degrades to LED-only if absent
- **Cable**: USB-A → micro USB, or USB-C depending on your board
- **LED**: on-board LED on GPIO 2 (works out of the box on most dev kits)

### Quickstart — MicroPython (easiest)

Fastest path with zero toolchain:

```bash
# Once, flash the MicroPython image
esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 esp32-*.bin

# Upload the app
make mpy-run
```

See [`micropython/README.md`](./micropython/README.md).

### Quickstart — Rust embedded

Longer setup, but you get real Rust on the microcontroller:

```bash
# Once — install the ESP Rust toolchain
cargo install espup
espup install
. $HOME/export-esp.sh
cargo install espflash

# Build + flash + open serial
cd rust
cargo run --release
```

See [`docs/en/getting-started.md`](./docs/en/getting-started.md) for the full
walkthrough (including Windows-specific gotchas).

### PCB

See [`kicad/README.md`](./kicad/README.md) — schematic description, BOM, and
JLCPCB manufacturing tips.

### Docs

- [`docs/en/getting-started.md`](./docs/en/getting-started.md)
- [`docs/en/architecture.md`](./docs/en/architecture.md)

---

## Français

Le chemin le plus doux vers l'ESP32 — deux implémentations parallèles du même
projet "blink + capteur de température" :

- **Rust** (`rust/`) — `esp-hal 0.22` + Embassy async
- **MicroPython** (`micropython/`) — `boot.py` + `main.py` sur image officielle

Une description de PCB cible dans `kicad/README.md` avec BOM adaptée aux prix
africains.

Voir [`docs/fr/getting-started.md`](./docs/fr/getting-started.md).

---

## License

MIT — see [LICENSE](./LICENSE).
