# MinimOSD - Using simultaneously with a Ground Station #

MinimOSD's TX is NOT connected if there is also a "wireless serial link" in parallel (E.g.: XBee) in order to use a Ground Control Station simultaneously.<br>
To use a wireless serial link and MinimOSD at same time, you need to make an "Y" cable or prepare your APM IMU board to have a parallel "mirror" connection.<br>
<br>
Bellow is a picture of a nice solution using a bent 20mm long male pin-headers.<br>
<ul><li><b>Upper mirror pins:</b> "TX" from MinimOSD is NOT connected on the APM's telemetry port input.<br>
</li><li><b>Lower mirror pins:</b> all the four wires are connected to the wireless serial link.</li></ul>

<img src='http://arducam-osd.googlecode.com/svn/wiki/images/Preparing_APM.jpg' />