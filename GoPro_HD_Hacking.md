# GoPro HD Hacking #

The most wanted cam to be used on UAVs is now partially hacked.
You can control on/off start/stop recording remotely.
A special control function will be added on ArduCam OSD to allow remote controlling GoPro HD cams.

Here goes the complete mapping of GoPro HD Bus:

  1. GND
  1. R video out - component Pb/Cb or composite
  1. G video out - component Y
  1. B video out - component Pr/Cr
  1. USB +5V USB power
  1. USB +5V USB power
  1. USB DP-B USB data line D+
  1. USB DM-B USB data line D-
  1. GND
  1. HPR audio out right channel
  1. HPL audio out left channel
  1. PWR/MODE power/mode button
  1. V3.6
  1. IN1R audio in right channel
  1. IN1L audio in left channel
  1. IR IN input IR receiver
  1. TRIG (?)
  1. GND
  1. ID1 digital input
  1. ID2 digital input
  1. ID3 digital input
  1. ID4 digital input
  1. ADAPTER output (Seems that it could be used as status...)
  1. ADAPTER output (?)
  1. WBAT+ input - ext. power for camera?
  1. WBAT+ input - ext. power for camera?
  1. GND
  1. DATA interface I2C
  1. CLK interface I2C
  1. GND

Pins **28** and **29** are very interesting. Still, nothing was found using the current firmware. It needs to be sniffed using the new firmware that allow shot two cams synchronized to grab 3D images.

## Details ##

This hacking use that Bus slot you can find on back side of GoPro HD.
That connector is pin compatible with that ones used to connect on !iPhone.
Depending on the connector, you will need to cut two small plastic walls.

## Test Hardware ##

Using relay:

  * 1 x iPhone Male Connector: [SparkFun Store](http://www.sparkfun.com/products/8295)
  * 1 x 75 ohms resistors
  * 1 x 150 ohms resistor
  * 1 x LED
  * 1 x relay or button

![http://arducam-osd.googlecode.com/svn/wiki/images/GoPro_remote_video.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/GoPro_remote_video.jpg)

The red part of diagram is about composite output video.
You need to down to ground pins 20 and 21, to enable pin 2 as composite video output. If you ground just pin 20 you will enable component on pins 2, 3 and 4.

## Original Connectors and Plug ##

These are the 100% compatible connectors with GoPro Bus.
No need to cut that small plastic like on iPhone ones.


**SMD Horizontal:**

[DD1B030HA1R500](http://search.digikey.com/scripts/DkSearch/dksus.dll?Detail&name=670-1020-2-ND)


**Cable Plug:**

[DD1P030MA1](http://search.digikey.com/scripts/DkSearch/dksus.dll?vendor=0&keywords=DD1P030MA1)

<br /><br />