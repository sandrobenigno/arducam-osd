# Updating MinimOSD Firmware #

If you just want to update your OSD board, the easiest way is using released .hex files from our [Download Section](http://code.google.com/p/arducam-osd/downloads/list) and use our configuration tool as explained below.

**Important NOTE:**<br>After updating your OSD to the firmware 2.0 or above you need to keep your Config Tool updated.<br> This will update your EEPROM for new resorces automatically. You just need to connect the board to the new OSD config.<br>
<br>So, is <b>mandatory</b> to install the <b>newest "ArduCAM OSD Config Tool"</b> and also update the Character Set.<br> A new charset is available on the Config Tool's install folder. From now on it will be always there as <b>"OSD_Charset.mcm"</b>.<br>
<br>
<br>
<h2>Using ArduCAM Config Tool</h2>

<ol><li>Connect your FTDI Serial adapter (<a href='https://store.diydrones.com/FTDI_Cable_3_3V_p/ttl-232r-3v3.htm'>Like this one</a>) to the six-pin connector.<br>
</li><li>Select the proper Serial COM Port (on the example bellow is COM12. Your adapter may use another one);<br>
</li><li>Go to menu <b>Options</b> and select <b>Update Firmware</b>.<br>
</li><li>Select the desired .hex file (you can download the latest one <a href='http://code.google.com/p/arducam-osd/downloads/list'>here</a>) from your PC and press <b>Open</b>;</li></ol>

<img src='http://arducam-osd.googlecode.com/svn/wiki/images/config_imgs/Serial.jpg' />

When the process starts, you board will reboot and go to the upload process in few seconds.<br>
If there is a video monitor attached to the OSD, the screen will turn to a blank state.<br>
You have to observe the loading bar on the bottom of ArduCAM OSD Config screen.<br>
<br>
<img src='http://arducam-osd.googlecode.com/svn/wiki/images/config_imgs/UpFirmware.jpg' />


<h2>Using Arduino</h2>

This project is based on Arduino. So, you can download the code, make tweaks, customize or just update the firmware through Arduino IDE.<br> All you need to do is checkout the source from our <a href='http://code.google.com/p/arducam-osd/source/checkout'>SVN repository</a>.