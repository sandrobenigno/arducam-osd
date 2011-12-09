/*

  File       : ArduCAM-OSD Notes
  Version    : v1.0.02
  Author     : Jani Hirvinen

  File to define all panels that can be used on ArduCAM-OSD hardware. Also their order numbers 
  and other information.

  Order number are also used when configuring their location. Look below

  Register , Order number , Panel name, Data/Size , Definitions
  -------------------------------------------------------
  panA_REG.0    01    panCenter       "IIII" \r "IIII"  - Center xrosshair 
  panA_REG.1    02    panPitch        "DDDDII"          - Pitch angle with symbols
  panA_REG.2    03    panRoll         "DDDDII"          - Roll angle with symbols
  panA_REG.3    04    panBattery      "DD.DII"          - Battery symbol with voltage reading
  panA_REG.4    05    -----
  panA_REG.5    06    panGPSats       "I  CC"           - Amount of locked satelliset with symbols
  panA_REG.6    07    panGPL          "II"              - GPS Lock symbol
  panA_REG.7    08    panGPS          "I DDD.DDDDDD" \r "I DDD.DDDDDD" - GPS location data (lat/lon)
 
  panB_REG.0    09    panRose         "IIIIIIIIIIIII" \r "ICCCCCCCCCCCCI"  - Compass rose
  panB_REG.1    10    panHeading      "IIDDDDI"         - Compass heading with symbols
  panB_REG.2    11    panMavBeat      "II"              - MAVLink heartbeat
  panB_REG.3    12    panHomeDir      "II"      N/Y     - Home location arrows
  panB_REG.4    13    panHomeDis      "IDDDDDI" N/Y     - Distance to home
  panB_REG.5    14    panWPDir        "II"      N/Y     - Waypoint location arrows
  panB_REG.6    15    panWPDis        "IDDDDDI"         - Distance to next waypoint
  panB_REG.7    16    --
  
  panC_REG.0    17    panNav                            - MAVLink Nav debug data
  panC_REG.1    18    panMod                            - MAVLink Mode debug data
  panC_REG.2    19    panAlt          "IDDDDDI"         - Altitude information
  panC_REG.3    20    panVel          "IDDDDDI"         - Velocity information
  panC_REG.4    21    panThr          "IDDDDDI"         - MAVLink Throttle data
  panC_REG.5    22    panFMod         "II"              - Flight mode display
  panC_REG.6    23    --
  panC_REG.7    24    --


I = Icon
D = Digit
C = Char

N/Y = Not Yet working
N/C = Not Confirmed

Screen sizes: 
PAL   15 Rows x 32 Chars
NTSC  13 Rows x 30 Chars


- Configuring

 On serial monitor send following command to move/enable/disable different panels.
 
 Command starts with !! [0/1 as dis/ena] [panel nr, two digit] [Column coord, two digit] [Row coord, two digit]

 Example to move Pitch panel to location Col 8, Row 12 command will be:
 
  !!1020812      (!! 1=Enable, 02=Panel 2, 08=Col 8, 12=Row 12)
  
  Battery monitor to Col 10, row 2: !!1041002

  Reset to default screen is: !!199
 





























*/
