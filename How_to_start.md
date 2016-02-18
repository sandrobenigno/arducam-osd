# Quick Start Guide #

## Wiring it up ##

It's pretty simple:

**Serial connection:** It has a USART interface FTDI compatible pads, so you just need to add male pin headers to use it.

**OSD Video IO connection:** You will find two ways to attach video IN and OUT: pin based pads and surface solder pads.

**USB Host connection:** There is a standard USB A female bus to host the peripherals;

**Power connection:** You can attach a battery to VIN power line (up to 12V). There is a tinny ON/OFF switch to enable/disable battery power. Alternatively, you can just feed the board by 5V power line. You can also use the USART FTDI interface to feed the board.

![http://arducam-osd.googlecode.com/svn/wiki/images/PinMap.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/PinMap.jpg)

After wire it up, all you'll need to do is checkout the trunk from ArduCam OSD [source code](http://code.google.com/p/arducam-osd/source/checkout) and follow the instructions below:

<br />
## About trunk folders ##

**'ArduCamOSD\_Beta"**

This is an Arduino project folder which has the code base to adapt/integrate with any project. Until now the OSD part is running on something like a "demo loop" just to allow us to test it and seeing some values changing, simulating as it came from APM

**"Library"** (folder with external necessary libraries)
  * **"USBHOST"**: to drive Max4321;
  * **"PTPCamera"**: the library to control cameras through PTP;
  * **"Time"**: to easily control OSD and USB loop nodes.

**Tools**

  * **"Max\_Char\_Write"**

This is another Arduino project folder, used to set the arduino as a bridge to upload the new charset to Max7456.
You will need a good terminal to "send file". I'm using "TeraTerm Pro". It's free, from [here](http://hp.vector.co.jp/authors/VA002416/teraterm.html).

  * **root files in Tools folder**
    * **"TERATERM.INI"** (modified to open more than default 4 serial ports)
    * **"OSD\_SA\_v3.mcm"** (the ArduCam OSD charset)
    * **"MAX7456Charwizard.jar"** (used to see/change the charset)

<br />
## Installing it ##
  * Copy USBHOST, PTPCamera and Time folders to Arduino libraries folder;
  * Copy folders ArduCamOSD\_Beta and Max\_Char\_Write to your Arduino scketch folder;
  * Upload the sketch "Max\_Char\_Write" to ArduCam OSD board;
  * Install TeraTerm;
  * Replace the ini in your program files "TTERMPRO" folder;
  * Use TeraTerm to send file: "OSD\_SA\_v1.mcm" to ArduCam board;
  * When it finished sending it, you just need to reset Arduino. It will shows the new charset
  * Upload sketch "ArduCamOSD\_Beta" to ArduCam OSD board.

<br />
If everything is OK you will see the OSD Demo loop running on your NTSC or PAL display.
**Note:** If you're using PAL hardware, you will need to enable "#define isPAL" on "ArduCam\_Max7456.h" to fits better all data on screen).

If you have a compatible PowerShot cam (switched to "P" mode), when you attach it to the board it will start capture session. If you send C by UART it will capture a picture and so one. Take a look into the "readSerialCommand" function at main sketch "ArduCamOSD\_Beta" to understand how it work and to test some more commands. It's pretty easy.