# Getting started — starter-iot-esp32

Two independent paths depending on your background. **Start with MicroPython** if
you've never touched a microcontroller — it's the fastest first success.

---

## Path A — MicroPython (recommended for first-timers)

### Prerequisites

- Python 3.11+ on your host
- `esptool.py` (`pip install esptool`)
- `mpremote` (`pip install mpremote`)
- A pre-built MicroPython image from <https://micropython.org/download/esp32/>
  (e.g. `esp32-20241016-v1.24.0.bin`)

### One-time flashing of MicroPython

```bash
# Linux / macOS
esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 esp32-20241016-v1.24.0.bin
```

Windows: replace `/dev/ttyUSB0` with the COM port (e.g. `COM3`) shown in Device Manager.

### Uploading your app

```bash
mpremote connect /dev/ttyUSB0 cp micropython/boot.py :boot.py
mpremote connect /dev/ttyUSB0 cp micropython/main.py :main.py
mpremote connect /dev/ttyUSB0 reset
```

Or the shorthand:

```bash
make mpy-run
```

Watch the output:

```bash
mpremote connect /dev/ttyUSB0 repl
```

`Ctrl-C` to interrupt, `Ctrl-D` to soft reset, `Ctrl-]` to exit.

---

## Path B — Rust embedded (more setup, more power)

### Prerequisites

- Rust stable + rustup
- `espup` (`cargo install espup`) — installs the Xtensa Rust fork required to
  target the classic ESP32 (LX6 core). ESP32-S3/C3 use RISC-V and don't need
  this, but we target the classic ESP32 here.
- `espflash` (`cargo install espflash`)
- On Linux: your user must be in the `dialout` group to open the serial port
  (`sudo usermod -aG dialout $USER` then log out/in).

### Toolchain install

```bash
cargo install espup
espup install
. $HOME/export-esp.sh   # Add this to your shell rc
cargo install espflash
```

### Building and flashing

```bash
cd rust
cargo run --release       # builds + flashes + opens the serial monitor
```

Or the shorthand from the repo root:

```bash
make rust-flash
```

### Serial output

The default log level is `INFO`. Change with `ESP_LOG=debug cargo run --release`.

---

## Common issues

- **"permission denied" on `/dev/ttyUSB0`**: on Linux add yourself to
  `dialout`, or run one-time `sudo chmod 666 /dev/ttyUSB0`.
- **Windows COM port not showing**: install the CP210x or CH340 USB-serial
  driver corresponding to your dev board.
- **Rust build fails on non-`esp` toolchain**: make sure `rust-toolchain.toml`
  is honoured (`rustup show` in `rust/` should say `esp`).
- **MicroPython "MemoryError"**: the DHT22 lib is optional; the code catches
  its import failure.
