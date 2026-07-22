#![no_std]
#![no_main]

//! Blink the on-board LED on GPIO 2 while logging over the serial UART.
//! For the ESP32 DevKit boards the on-board LED is on GPIO 2. Adapt for your board.

use embassy_executor::Spawner;
use embassy_time::{Duration, Timer};
use esp_backtrace as _;
use esp_hal::{
    delay::Delay,
    gpio::{Level, Output},
    prelude::*,
    timer::timg::TimerGroup,
};
use esp_println::println;
use log::info;

#[main]
async fn main(_spawner: Spawner) {
    // Init hardware
    let peripherals = esp_hal::init(esp_hal::Config::default());

    // Install embassy time driver
    let timg0 = TimerGroup::new(peripherals.TIMG0);
    esp_hal_embassy::init(timg0.timer0);

    esp_println::logger::init_logger_from_env();

    let mut led = Output::new(peripherals.GPIO2, Level::Low);

    println!("Skilluv starter-iot-esp32 — booting on ESP32");
    info!("Blinking GPIO 2 every 500 ms");

    let _delay = Delay::new();

    loop {
        led.toggle();
        info!("tick: LED = {:?}", led.output_level());
        Timer::after(Duration::from_millis(500)).await;
    }
}
