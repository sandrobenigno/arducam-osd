# Update MinimOSD's Character Set #

The ArduCAM OSD base code has an optimized way to draw panels fast on screen. This is possible due a special technique to write panels with reduced number of SPI transactions and also by the replacement of the original MAX7456 character set to a new one which is indexed as the ASCII table.

**Important note before proceed:**

Defective and fuzzy chars are the result of a faulty character updating.
Max7456's internal memory is really picky about voltage level during a charset update. Usually it happens with some PCs with lower USB voltage.
The only way to fix that is updating the charset by feeding the board properly. Just making sure it has around 5V there. E.g.: tying the two stages and feeding it by an external battery on the video IO pins.

## Using ArduCAM Config Tool ##

Since the firmware 2.0 there is a new charset available on the updated Config Tool's install folder. From now on it will be always there as "OSD\_Charset.mcm". So, you can use our configuration tool as explained below:

  1. Connect your FTDI Serial adapter ([Like this one](https://store.diydrones.com/FTDI_Cable_3_3V_p/ttl-232r-3v3.htm));
  1. Select the proper Serial COM Port (on the example bellow is COM12. Your adapter may use another one);
  1. Go to menu **Options** and select **Update CharSet**.
  1. Select the desired .mcm file from your PC and press **Open**;

![http://arducam-osd.googlecode.com/svn/wiki/images/config_imgs/Serial.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/config_imgs/Serial.jpg)

When the process starts, you board will reboot and go to the upload process in few seconds.<br>
If there is a video monitor attached to the OSD, the screen will show the bootload screen and turn to black.<br>
You have to observe the loading bar on the bottom of ArduCAM OSD Config screen.<br>
<br>
<img src='http://arducam-osd.googlecode.com/svn/wiki/images/config_imgs/UpCharSet.jpg' />