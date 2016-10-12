# RelayRace

A [nerves](https://github.com/nerves-project/nerves) example project to control a set of relays from a web interface.

## Setup

### Hardware

You will need:

* A RaspberryPi 3 - https://www.amazon.com/gp/product/B01CD5VC92/
* A USB Serial Port - https://www.amazon.com/gp/product/B00QT7LQ88/
* A Micro SD Card - https://www.amazon.com/gp/product/B00DYQYLQQ
* A Relay Board - https://www.amazon.com/gp/product/B00KTELP3I/
* Breadboard Jumper Wires - https://www.amazon.com/gp/product/B00ZWEFWO8/

#### Wiring

![RaspberryPi 3 Pinout Diagram](https://az835927.vo.msecnd.net/sites/iot/Resources/images/PinMappings/RP2_Pinout.png)

Use this pinout diagram to choose GPIO pins for your relays. Note the GPIO pin
numbers to set in the config.

Connect the serial controller to the UART, ground, and 5v pins of the RaspberryPi.<br/>
**Note that this provides power to the RaspberryPi. No need to use a USB charger.**

### Wifi

* Copy `apps/fw/config/wifi.exs.example` to `apps/fw/config/wifi.exs`
* Edit the new file and add your wifi credentials

### Relay Pin Numbers

* Open `apps/fw/config/config.exs`
* Update the `:relay, :pins` config option with the list of GPIO pins you are using
  * Make sure to use the `GPIO <n>` number (orange in the attached image, not grey)

### Compiling

* `cd apps/fw`
* `mix deps.get`
* `mix firmware`
* Burn to an SD card with `mix firmware.burn`

## Connecting to the serial interface

* Install any necessary drivers
  * For the linked one, they are available at: http://prolificusa.com/pl-2303hx-drivers/
  * Some devices may not need additional drivers
* Determine the device name
  * For the linked one, on a OS X: `/dev/tty.usbserial`
* Use screen to connect: `screen /dev/tty.usbserial 115200`
  * If the screen is blank, try pressing enter to get a prompt
