## Troubleshooting ##

**MinimOSD won't connect to APM**

This is probably due to outdated firmware that does not support the current MAVLink 1.0 standard used by ArduPlane and ArduCopter. Upgrade your MinimOSD firmware to Version 1.9 or above, which you can find [here](http://code.google.com/p/arducam-osd/downloads/list). Firmware upgrading instructions are [here](http://code.google.com/p/arducam-osd/wiki/Update_Firmware).


**Video overlay presenting fuzzy and not well formed chars**

Defective and fuzzy chars are the result of a faulty character updating.
Max7456's internal memory is really picky about voltage level during a charset update. Usually it happens with some PCs with lower USB voltage.
The only way to fix that is updating the charset by feeding the board properly. Just making sure it has around 5V there. E.g.: tying the two stages and feeding it by an external battery on the video IO pins.


**Data is showing up only when MinimOSD's TX is connected to APM's RX**

This isn't a problem with the firmware. Your APM isn't sending the data automatically. So, because of that you need to request data rates from APM by using the Mission Planer, another GCS or even by your OSD board. That's why it just works with TX connected. ArduPlane saves the requested rates on EEPROM (last request from a GCS or OSD). ArduCopter doesn't do that.
E,g. Check on Mission Planner: Configuration >> Parameter List:
All the params with the prefix "SR3_" are related to this. E.g.: SR3\_Extra1 = 5 means the IMU data being sent through telem port (serial 3) five times per second. If that wasn't set, so it will not send IMU data without a explicit requesting._

This is the complete list with the respective values:

  * SERIAL3\_BAUD, 57    (telemetry output at 57600)
  * SR3\_EXT\_STAT, 2      ( 2hz for waypoints, GPS raw, fence data, current waypoint, etc)
  * SR3\_EXTRA1, 5         ( 5hz for attitude and simulation state)
  * SR3\_EXTRA2, 2         ( 2hz for VFR\_Hud data )
  * SR3\_EXTRA3, 3         ( 3hz for AHRS, Hardware Status, Wind )
  * SR3\_POSITION, 2      ( 2hz for location data )
  * SR3\_RAW\_SENS, 2  ( 2hz for raw imu sensor data )
  * SR3\_RC\_CHAN, 5     ( 5hz for radio input or radio output data )


**EEPROM is shown as outdated and it's not being fixed by the OSD Config Tool**

After updating your OSD to the firmware 2.0 or above you need keep your Config Tool updated.<br> This will update your EEPROM for new resorces automatically. You just need to connect the board to the new OSD config.<br>
<br>So, is <b>mandatory</b> to install the <b>newest "ArduCAM OSD Config Tool"</b> and also update the Character Set.<br> A new charset is available on the Config Tool's install folder. From now on it will be always there as <b>"OSD_Charset.mcm"</b>.<br>
<br>
<br>
<b>MinimOSD showing "Update Charset" on power up, requiring a hardware reset before you start using it</b>

If your system is acting like that, you should set the Telemetry delay in the CGS to a lower value than the default. Customers reported us that a value below 5 seconds fixes that. However we recommend you you to find the best value for your particular case.