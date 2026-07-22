# Architecture — starter-iot-esp32

## Opinionated choices

### 1. Two implementations, one target

The exact same behaviour (blink + optional DHT22 read) implemented twice:

- **MicroPython** — the "quick, forgiving, but slower and heavier on RAM" path.
- **Rust + Embassy** — the "steeper setup but zero-overhead, memory-safe" path.

This split lets a workshop start on MicroPython, then re-implement in Rust once
learners are comfortable with the hardware.

### 2. `esp-hal 0.22` + `esp-hal-embassy` for Rust

`esp-hal` is Espressif's own Rust HAL, actively developed. Embassy provides an
`async`-friendly runtime — the `Timer::after(...).await` idiom is much clearer
than blocking loops. The panic handler and print backends come from
`esp-backtrace` and `esp-println`.

### 3. `machine.Pin` + `dht` from stdlib on MicroPython

We deliberately don't pull in any third-party library. `dht.DHT22` is bundled in
the MicroPython image, so a fresh flash is enough.

### 4. Sensor is optional

If the DHT22 isn't wired, the code catches the ImportError / OSError and
continues in blink-only mode. The very first flash always shows "something is
alive" without any external hardware — this matters when someone's LED is the
one and only thing they own.

### 5. KiCad target is documented, not shipped

The board is small enough to recreate from the BOM in 15 minutes. Shipping the
`.kicad_pcb` binary in git diffs poorly and makes reviews painful.

## What's out of scope

- Wi-Fi provisioning / MQTT (add `esp-wifi` for Rust, `network` + `umqtt.simple`
  for MicroPython when ready).
- OTA firmware updates.
- Deep-sleep power management.
- Non-classic ESP32 variants (S3, C3, C6, H2) — adaptation is straightforward
  but each needs its own `esp-hal` feature flag and MicroPython image.
