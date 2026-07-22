# This file is executed once on every boot (including wake-boot from deepsleep).
# Kept intentionally minimal — put Wi-Fi credentials and setup here later.

import gc
gc.collect()
print("Skilluv starter-iot-esp32 — MicroPython boot")
