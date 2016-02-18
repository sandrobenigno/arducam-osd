# MinimOSD - Introduction #

[MinimOSD](https://store.3drobotics.com/products/apm-minimosd-rev-1-1) is a super-tiny board designed by 3DRobotics. It's all you need to get OSD telemetry data from ArduPilot Mega. Just connect your FPV camera and a video link and you're ready to fly with instruments on screen.

![http://arducam-osd.googlecode.com/svn/wiki/images/MinimOSD.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/MinimOSD.jpg)

It's intended to be a dedicated APM telemetry video output.
So, it reads [MAVLink](http://qgroundcontrol.org/mavlink/start) messages from its RX and request rates from APM if you connect its TX to ArduPilot "telem" port.

Important note: **You cannot connect the OSD when your APM 2 is also connected via USB (they share the same port).** Make sure you disconnect your USB cable from the APM 2 board before attempting to use the OSD.

# Details #

It has the Max7456 chip powered by two stages to avoid noises from servos attached to ArduPilot Mega board.<br>
It provides an extra clean power line to feed the FPV camera and video link.<br>

The approach is to use two external power sources: 12V from a Lipo Battery and 5V from APM:<br>
<br>
<img src='http://arducam-osd.googlecode.com/svn/wiki/images/DiagramaMinimOSD.jpg' />

<b>Raw 12V from Lipo Battery:</b>
<ul><li>Feeds directly FPV camera and video transmitter.<br>
</li><li>It also feeds Max7456's analog line (AVDD and AGND) by a 5V voltage regulator (avoiding noises from servos attached to APM).<br>
<b>5V from APM telem port:</b>
</li><li>Feeds the ATmega 328P and Max7456's digital line (DVDD and DGND);</li></ul>

<br><br>
<b>Note:</b> Optionally, you can use two solder jumps to "tie" digital and analog lines.<br>
<br>
<img src='http://arducam-osd.googlecode.com/svn/wiki/images/PowerTieMinimOSD.jpg' />

MinimOSD has no extra pins exposed, because the concept is "capturing all the needed data from MAVLink".<br>
E.g.: to show RSSI from RC receiver, that info needs to be on msgs #35 and #36 (RC_CHANNELS "RAW" and "SCALED").<br>
So, the analog reading of RSSI output from receiver needs to be done on APM analog ports and treated inside the APM code.<br>
<br>
<h1>PAL vs NTSC</h1>

The format of the video does have an impact on how many characters the OSD can fit on the video feed. The MimimOSD can be configured by the ArduCAM OSD Config Tool to work at PAL or NTSC. The "PAL" solder jumper underneath the board is not used anymore (Firmware 2.0 or above).