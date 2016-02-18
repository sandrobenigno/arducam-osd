## Frequently Asked Questions ##

**Do I need to connect the GND from the batteries when using two ones?**

The quick answer is: No. Don't do that.

It is a good idea to use two batteries: one for ESCs and servos (also APM through the PowerModule or a uBEC) and another one for camera, video transmitter and the analog stage of MinimOSD.
The objective of using those two batteries is exactly achieving two independent sources. It would even result in two GND's "Digital GND" and "Analog GND".

NOTE: If you want to power the whole MinimOSD (two stages) from the second battery, you have to tie the jumpers on top and bottom of the board (check the quick start instructions). In this case the jumpers will result in just one GND and VCC. If you chose doing that, try disconnecting the +5V between APM and the OSD for minimizing the noise's impact from there.