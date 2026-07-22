# KiCad 8 project

## Files

The KiCad source files are **not** shipped in this starter — they are binary-ish
files that don't diff well, and the reference schematic is intentionally small.
Instead, this folder documents the target board so you can recreate it in KiCad
in ~15 minutes.

## Target board

A tiny "sensor node":

- **U1** — ESP32 DevKit V1 (30-pin), placed with headers for socketing
- **D1** — Status LED (3 mm) on GPIO 2 with a 330 Ω resistor
- **U2** — DHT22 (AM2302) temperature/humidity sensor, DATA to GPIO 4, 10 kΩ pull-up
- **J1** — 4-pin JST-XH connector for external 5 V power (or use the ESP32 USB)
- Ground planes on both layers

## Steps to recreate in KiCad 8

1. `File → New → Project` — save as `starter-iot-esp32.kicad_pro`
2. Open the schematic and add:
   - `Module:ESP32-DEVKITV1` (from the module library — install with the "Symbols" library manager if missing)
   - `Device:LED` + `Device:R` (330 Ω)
   - Custom symbol for DHT22 (AM2302) — many community libs on GitHub
3. Wire per the target section above.
4. Assign footprints, run ERC.
5. Open the PCB editor, place components on a 30 × 40 mm board outline.
6. Route on 2 layers, keep the 3V3 trace short.
7. Export Gerbers via `File → Fabrication Outputs → Gerbers…` — settings suitable for [JLCPCB](https://jlcpcb.com/).

## Bill of Materials (BOM)

| Ref | Part | Qty | Approx. price (Africa, ~2026) | Where to buy |
|-----|------|-----|-------------------------------|--------------|
| U1 | ESP32 DevKit V1 (30-pin) | 1 | 4 000 – 6 000 XOF | AliExpress, Kubii, Gotronic, local Douala/Lagos/Yaoundé electronics shops |
| U2 | DHT22 / AM2302 | 1 | 2 500 – 4 000 XOF | idem |
| D1 | LED 3 mm red | 1 | 50 XOF | any local shop |
| R1 | Resistor 330 Ω 1/4 W | 1 | 30 XOF | idem |
| R2 | Resistor 10 kΩ 1/4 W | 1 | 30 XOF | idem |
| J1 | JST-XH 4-pin connector | 1 | 200 XOF | idem |

**Approximate BOM total: 7 000 – 10 500 XOF (~10 – 16 EUR)**.

## PCB manufacturing

- 5 boards from JLCPCB: ~2 USD + ~15 USD shipping to Africa via DHL.
- Kits like [PCBWay](https://www.pcbway.com/) offer similar pricing.
- For faster local access, check hackerspaces (Dakar's DefkoAkNiep, Cotonou's BlolabE, Yaoundé's ActivSpaces).
