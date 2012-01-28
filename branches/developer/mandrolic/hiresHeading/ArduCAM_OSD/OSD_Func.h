//------------------ Heading and Compass ----------------------------------------
static char buf_show[12];
const char buf_Rule[36] = {0xc2,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                           0xc4,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                           0xc3,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                           0xc5,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0};
void setHeadingPatern()
{
  int start;
  start = round((osd_heading * 36)/360);
  start -= 5;
  if(start < 0) start += 36;
  for(int x=0; x <= 10; x++){
    buf_show[x] = buf_Rule[start];
    if(++start > 35) start = 0;
  }
  buf_show[11] = '\0';
}


int ToBearing(int degrees)
{
    return (degrees + 360) % 360;
}

//------------------ New 'Hi res' heding -------------------------------------

/*
The high res control is so called because it can appear to present 
NEWS markers 'halfway' between characters. Thus the step in pixels
when the control moves is only half a character (6 pixles), not a whole one (12px)
It does this with specially crafted characters that straddle 2 characters

Charater sequence when column aligned:
N - - |- - E  . . . etc

Sequence when aligned cloumn/2:
N1 N2 - L1 L2 - E1 E2 - . . . etc

where N1, N2 for e.g are the special spanning characters mentioned for the 'N' (north) symbol
*/


const int PATTERN_LENGTH = 24;
const int HEADING_WIDTH = 12;

// Some of the reference pattern bytes will be copied into here; these get 
// sent to the MAX7456 OSD chip
static char current_heading_bytes[HEADING_WIDTH];

// Todo: set these right to agree with the minimOSD char map
const char N = 0xC2;
const char S = 0xC3;
const char E = 0xC4;
const char W = 0xC5;
const char LINE = 0xC0;
const char B = 0xC1;

const char NL = 0xF4;
const char NR = 0xF5;
const char SL = 0xF6;
const char SR = 0xF7;
const char EL = 0xF8;
const char ER = 0xF9;
const char WL = 0xFA;
const char WR = 0xFB;

const char BL = 0xFC;
const char BR = 0xFD;



const char alignedBytesPattern[PATTERN_LENGTH] =
                { LINE, LINE, B ,LINE, LINE, E, LINE, LINE, B, LINE, LINE, S, LINE, LINE, B, LINE, LINE, W, LINE, LINE, B, LINE, LINE, N };
const char halfalignedBytesPattern[PATTERN_LENGTH] = 
                { NR, LINE, BL, BR, LINE, EL, ER, LINE, BL, BR, LINE, SL, SR, LINE, BL, BR, LINE, WL, WR, LINE, BL, BR, LINE, NL };                           

void setHeadingPaternHd()
{
    int degPerChar = 360 / PATTERN_LENGTH;

    // offset bearing - ie the heading as at the left most edge of the control
    // HEADING_WIDTH + 2 because there are 2 bars one either side, but that effectively
    // increases the width of the rose, think of it as an occluding bezel
    int leftEdgeHeading = ToBearing(osd_heading - (180 * (HEADING_WIDTH - 1) / PATTERN_LENGTH));

    int offsetDegrees = ((int)(leftEdgeHeading)) % degPerChar;  // <-- do I need round() here?

    const char *charset;
    
    if (offsetDegrees >= (degPerChar * 0.25) && offsetDegrees < (degPerChar * 0.75))
        charset = alignedBytesPattern;
    else
        charset = halfalignedBytesPattern;

    // starting position in the reference character run
    int idx = leftEdgeHeading / degPerChar;  // <-- do I need round() here?

    if (offsetDegrees >= (degPerChar * 0.75))
        idx += 1;

    for (int i = 0; i < HEADING_WIDTH; i++)
    {
        current_heading_bytes[i] = charset[idx % PATTERN_LENGTH];
        idx++;
    }
    
    // is this really necessary?
    current_heading_bytes[HEADING_WIDTH -1] = '\0';
}



//------------------ Battery Remaining Picture ----------------------------------

void setBatteryPic()
{
  if(osd_battery_remaining <= 270){
    osd_battery_pic = 0xb4;
  }
  else if(osd_battery_remaining <= 300){
    osd_battery_pic = 0xb5;
  }
  else if(osd_battery_remaining <= 400){
    osd_battery_pic = 0xb6;
  }
  else if(osd_battery_remaining <= 500){
    osd_battery_pic = 0xb7;
  }
  else if(osd_battery_remaining <= 800){
    osd_battery_pic = 0xb8;
  }
  else osd_battery_pic = 0xb9;
}

//------------------ Home Distance and Direction Calculation ----------------------------------

void setHomeVars(OSD &osd)
{
  float dstlon, dstlat;
  long bearing;
  
  if(osd_got_home == 0 && osd_fix_type > 1){
    osd_home_lat = osd_lat;
    osd_home_lon = osd_lon;
    osd_home_alt = osd_alt;
    osd_got_home = 1;
  }
  else if(osd_got_home == 1){
    
    // shrinking factor for longitude going to poles direction
    float rads = fabs(osd_home_lat) * 0.0174532925;
    double scaleLongDown = cos(rads);
    double scaleLongUp   = 1.0f/cos(rads);

    //DST to Home
    dstlat = fabs(osd_home_lat - osd_lat) * 111319.5;
    dstlon = fabs(osd_home_lon - osd_lon) * 111319.5 * scaleLongDown;
    osd_home_distance = sqrt(sq(dstlat) + sq(dstlon));

    //DIR to Home
    dstlon = (osd_home_lon - osd_lon); //OffSet_X
    dstlat = (osd_home_lat - osd_lat) * scaleLongUp; //OffSet Y
    bearing = 90 + (atan2(dstlat, -dstlon) * 57.295775); //absolut home direction
    if(bearing < 0) bearing += 360;//normalization
    bearing = bearing - 180;//absolut return direction
    if(bearing < 0) bearing += 360;//normalization
    bearing = bearing - osd_heading;//relative home direction
    if(bearing < 0) bearing += 360; //normalization
    osd_home_direction = round((float)(bearing/360.0f) * 16.0f) + 1;//array of arrows =)
    if(osd_home_direction > 16) osd_home_direction = 0;

  }
}
