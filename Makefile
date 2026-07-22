.PHONY: help rust-build rust-flash rust-monitor mpy-flash mpy-run clean

SERIAL_PORT ?= /dev/ttyUSB0

help:
	@echo "Requires: espflash (Rust) OR esptool.py + mpremote (MicroPython)."
	@echo "Set SERIAL_PORT=<device> to override /dev/ttyUSB0."
	@echo ""
	@echo "Targets:"
	@echo "  rust-build    — cargo build --release (Rust firmware)"
	@echo "  rust-flash    — espflash flash --monitor (Rust firmware)"
	@echo "  rust-monitor  — espflash monitor"
	@echo "  mpy-flash     — esptool.py write_flash for MicroPython image"
	@echo "  mpy-run       — mpremote to upload main.py + boot.py"
	@echo "  clean         — cargo clean"

rust-build:
	cd rust && cargo build --release

rust-flash:
	cd rust && cargo run --release

rust-monitor:
	espflash monitor $(SERIAL_PORT)

mpy-flash:
	@echo "Download MicroPython firmware from https://micropython.org/download/esp32/ first, e.g. esp32-20241016-v1.24.0.bin"
	@echo "Then run: esptool.py --chip esp32 --port $(SERIAL_PORT) erase_flash"
	@echo "         esptool.py --chip esp32 --port $(SERIAL_PORT) --baud 460800 write_flash 0x1000 <firmware.bin>"

mpy-run:
	mpremote connect $(SERIAL_PORT) cp micropython/boot.py :boot.py
	mpremote connect $(SERIAL_PORT) cp micropython/main.py :main.py
	mpremote connect $(SERIAL_PORT) reset

clean:
	cd rust && cargo clean
