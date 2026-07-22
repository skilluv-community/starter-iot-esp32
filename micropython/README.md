# MicroPython side

## Prerequisites

- Python 3 on your host
- `esptool.py` (`pip install esptool`)
- `mpremote` (`pip install mpremote`)
- A pre-built MicroPython firmware image for ESP32 from <https://micropython.org/download/esp32/>

## Flashing the firmware (once)

```bash
esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 esp32-*.bin
```

On Windows the port looks like `COM3` (Device Manager tells you which one).

## Uploading the app

```bash
mpremote connect /dev/ttyUSB0 cp boot.py :boot.py
mpremote connect /dev/ttyUSB0 cp main.py :main.py
mpremote connect /dev/ttyUSB0 reset
```

Then open a serial monitor to watch the prints:

```bash
mpremote connect /dev/ttyUSB0 repl
```

Ctrl-C to interrupt, Ctrl-D to soft reset.

## Wiring the DHT22 (optional)

- DHT22 VCC → ESP32 3V3
- DHT22 GND → ESP32 GND
- DHT22 DATA → ESP32 GPIO 4
- 10 kΩ pull-up resistor between VCC and DATA

Without the sensor, `main.py` still blinks the on-board LED.
