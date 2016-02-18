# USB/OSD 328p Prototype Board (in development) #


**Introduction and Features List**

This board has being projected to be a DIY board very hackable and customizable to provide OSD and USB host. And the best part: it already has an Arduino based circuitry controlling the dedicated chips and give you access to everything.

![http://arducam-osd.googlecode.com/svn/wiki/images/ArduCamOSD_bootloader_pic.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/ArduCamOSD_bootloader_pic.jpg)
Designed by Sandro Benigno and routed by Jordi Munõz.
The board has just: 56 x 34 x 10mm (W x L x D).

<a href='Hidden comment: That"s a start point, however DIYers can create very nice projects with that awesome Arduino based board, such rovers controlled by Bluetooth joystick or even another custom project using mouse, keyboard, touch-panel, etc. All this, sending OSD data directly to a video monitor or video transmitter... and much more!'></a>


**General Features**

  * open source and open hardware OSD board with integrated USB host;
  * both resources are driven by on-board Atmega328p over SPI;
  * Arduino compatible;
  * serial interface is compatible with FTDI cable;
  * voltage input VIN has a switch to enable/disable external power source from (up to 12V);
  * 3V3 and 5V exposed from integrated voltage regulators;
  * it can be integrated to any project through exposed UART or i2C pins;
  * 3 extra digital pins exposed, 2 PWM capable;
  * it can drive external peripherals by exposed SPI and the extra digital pins as chip selectors;
  * 6 analog pins exposed to read external sensors (i2c clock and data included);

![http://arducam-osd.googlecode.com/svn/wiki/images/Chips.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/Chips.jpg)

![http://arducam-osd.googlecode.com/svn/wiki/images/PinMap.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/PinMap.jpg)

**OSD Features**

  * based on specialized OSD chip Max7456;
  * compatible with NTSC or PAL signal;
  * provides internal, external and automatic vertical sync;
  * LOS, Hsync and ClockOut are exposed;
  * video input and output exposed as pin and solder pads.
  * Open Code:
    * optimized code to write OSD panels pretty fast;
    * character table can be customized and replaced by using a free editor and a special Arduino sketch;
    * user has total control to enable/disable specific panels, change its location and everything else.

**USB Host Features**

  * based on specialized USB host chip Max3421;
  * compatible with [Arduino USB host shield](https://github.com/felis/USB_Host_Shield) and [PTP libraries](https://github.com/felis/Arduino_Camera_Control) (from circuitsathome.com);
  * Open Code:
    * current firmware shows you how to control PowerShot digital cameras from Canon with PTP remote-control enabled;
    * the PTP library have examples to control Canon EOS cams and even Nikon cams which have the standard PTP remote-control enabled;
    * customers can integrate it with other peripherals, such as bluetooth joysticks, midi interfaces and others. All that is possible by using the USB host shield libraries.