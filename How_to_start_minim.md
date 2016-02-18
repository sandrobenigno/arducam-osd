## MinimOSD - Basic wiring Diagram ##

The orignal MinimOSD's power setup provides two stages to avoid noises coming from servos attached to your ArduPilot boards. Those noises could introduce some glitches on video signal. The independent analog powering from a dedicated battery will heat the board considerably, but the video is the most clean as possible from MAX7456.

Maybe you don't need to use the two stages. The way those noises would impact on the video signal will vary depending on a chain of aspects like servo's brand, model, cables length, etc. So, try yourself and see if it's important for your setup.

Here is the basic diagram which uses two stages approach of MinimOSD board:
![http://arducam-osd.googlecode.com/svn/wiki/images/DiagramaMinimOSD.jpg](http://arducam-osd.googlecode.com/svn/wiki/images/DiagramaMinimOSD.jpg)

<br>
<b>OPTIONAL setup for critical cooling conditions :</b> (Hardware V0.1 and 1.0 only)<br>
<br>
The second stage regulator from the MinimOSD boards earlier than V1.1 gets too hot on 12V video setups. If your frame has not a good air flow for cooling the OSD board you may want to feed the OSD entirely from APM. Probably it will add some noises from servos, but you'll be more safe by this way:<br>
<br><br>
<img src='http://arducam-osd.googlecode.com/svn/wiki/images/DiagramaMinimOSD_OP.jpg' />