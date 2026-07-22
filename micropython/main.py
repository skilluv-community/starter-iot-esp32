"""Blink the on-board LED (GPIO 2 on most ESP32 dev kits) and print temperature
if a DHT22 sensor is wired to GPIO 4.

If the DHT read fails (no sensor), the loop still blinks. That way the very
first flash always shows "something is alive" without any hardware other than
the ESP32 itself.
"""
import time
from machine import Pin

try:
    import dht
    DHT_PIN = 4
    dht_sensor = dht.DHT22(Pin(DHT_PIN))
    print(f"DHT22 configured on GPIO {DHT_PIN}")
except Exception as err:  # noqa: BLE001 — sensor is optional
    dht_sensor = None
    print(f"DHT22 not available: {err!r} (blink-only mode)")

led = Pin(2, Pin.OUT)


def read_temperature() -> tuple[float, float] | None:
    if dht_sensor is None:
        return None
    try:
        dht_sensor.measure()
        return dht_sensor.temperature(), dht_sensor.humidity()
    except OSError as err:
        print(f"DHT read error: {err}")
        return None


tick = 0
while True:
    led.value(tick % 2)
    if tick % 4 == 0:
        reading = read_temperature()
        if reading is not None:
            temp_c, humidity = reading
            print(f"tick={tick} led={led.value()} temp={temp_c}C humidity={humidity}%")
        else:
            print(f"tick={tick} led={led.value()}")
    time.sleep_ms(500)
    tick += 1
