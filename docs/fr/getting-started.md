# Démarrage — starter-iot-esp32

Deux chemins indépendants. **Commencer par MicroPython** si tu n'as jamais
touché un microcontrôleur.

---

## Chemin A — MicroPython (recommandé pour débuter)

### Prérequis

- Python 3.11+
- `esptool.py` (`pip install esptool`)
- `mpremote` (`pip install mpremote`)
- Image MicroPython : <https://micropython.org/download/esp32/>

### Flasher MicroPython (une fois)

```bash
esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 esp32-20241016-v1.24.0.bin
```

Windows : remplacer `/dev/ttyUSB0` par le COM (ex `COM3`).

### Upload de l'app

```bash
make mpy-run
```

Monitor série :

```bash
mpremote connect /dev/ttyUSB0 repl
```

---

## Chemin B — Rust embedded (setup plus lourd, plus de contrôle)

### Prérequis

- Rust stable + rustup
- `espup install` puis `. $HOME/export-esp.sh`
- `cargo install espflash`
- Linux : `sudo usermod -aG dialout $USER` puis re-login

### Build + flash

```bash
cd rust
cargo run --release
```

Ou `make rust-flash`.

---

## Problèmes courants

- **Permission denied `/dev/ttyUSB0`** : Linux, groupe `dialout`.
- **COM Windows introuvable** : driver CP210x ou CH340.
- **Build Rust échoue** : vérifier `rust-toolchain.toml` (`rustup show` doit dire `esp`).
- **MicroPython MemoryError** : lib DHT22 optionnelle, catch géré.
