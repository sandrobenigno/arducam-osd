## Status ##

The code is NOT finished. The hard work continues! ;)

**OSD**

Now we have a windows application to setup and configure the OSD.<br>
Thanks to my friend Michael Oborne from Australia!<br>
<br>
There is much more to improve and add, but it work pretty fine.<br>
Current Panels Set includes:<br>
<br>
<ul><li>Home Distance<br>
</li><li>Home Direction<br>
</li><li>MAVLink HeartBeats<br>
</li><li>Throttle<br>
</li><li>Speed<br>
</li><li>Altitude<br>
</li><li>Battery voltage<br>
</li><li>GPS lock<br>
</li><li>Number of visible sats<br>
</li><li>Latitude<br>
</li><li>Longitude<br>
</li><li>Pitch angle<br>
</li><li>Row angle<br>
</li><li>Heading angle<br>
</li><li>Compass rule<br>
</li><li>Flight Modes (ArduCopter and ArduPlane)</li></ul>

<b>USB Host and Camera Control</b>

The camera control part is already working with OSD.<br>
However, deal with !MAVLink  and USB Host at same time demands a lot of SRAM.<br>

We have two options to complete the OSD+USB Host project:<br>
<ul><li>Customize a light OSD panel to fit better ATMega328p resources;<br>
</li><li>Create a new board, based on ATMega2560 chip;</li></ul>

You can try the current code. Just do the checkout of the code from <a href='http://code.google.com/p/arducam-osd/source/browse/trunk'>here</a>.<br>
<br>
<br />

<h2>Basic Goals</h2>

Current:<br>
<ul><li>Mapping: commands from Canon PS (Power Shot cams) <b>(OK)</b>;<br>
</li><li>Coding: to adapt essential mapped PS commands to main PTP library; <b>(OK)</b>
</li><li>Coding: to wrap necessary camera resources into simple serial calls <b>(OK)</b>;<br>
</li><li>Mapping: necessary registers of the chip Max7456 to work as the OSD core <b>(OK)</b>;<br>
</li><li>Testing: sketch which read and write the basic Max7456 registers <b>(OK)</b>;<br>
</li><li>Design:  create a basic charset to use on UAV projects <b>(OK)</b>;<br>
</li><li>Coding: to insert the charset into the Max7456 prototype <b>(OK)</b>;<br>
</li><li>Coding: to wrap all the Map7456 code into a useful library <b>(OK)</b>;<br>
</li><li>Coding: to implement OSD pannels for telemetry data on screen <b>(OK)</b>;<br>
</li><li>Coding: to merge "USB Host" and "OSD" code using the new SPI class; <b>(OK)</b>;<br>
</li><li>Coding and Hardware: to use the mini USB host shield <b>(OK)</b>;<br>
</li><li>Hardware: to develop an "all-in-one" small board <b>(OK)</b>.<br>
</li><li>Coding: to integrate ArduCam OSD with ArduPilot Mega via MAVLink; <b>(OK)</b>
</li><li>Coding: to create new OSD panels to fit ArduPilot Mega needs. <b>(OK)</b></li></ul>

Future:<br>
<ul><li>Accept newest and smallest Canon PS without PTP from factory:<br>
<ul><li>Use CHDK to open one parametrized PTP command to run internal LUA scripts;<br>
</li></ul></li><li>Accept cams with other brands (when possible to hack their firmware).</li></ul>

<br />