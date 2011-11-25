/*Panels variables*/
//Will come from APM telem port


static float    osd_vbat = 0;                   // voltage in milivolt
static uint16_t osd_battery_remaining = 0;      // 0 to 100 <=> 0 to 1000
static uint8_t  osd_battery_pic = 0xb4;         // picture to show battery remaining

static uint16_t osd_mode = 0;                   // Navigation mode from RC AC2 = CH5, APM = CH8
static uint8_t  osd_nav_mode = 0;               // Navigation mode from RC AC2 = CH5, APM = CH8

static float    osd_lat = 0;                    // latidude
static float    osd_lon = 0;                    // longitude
static uint8_t  osd_satellites_visible = 0;     // number of satelites
static uint8_t  osd_fix_type = 0;               // GPS lock 0-1=no fix, 2=2D, 3=3D

static uint8_t  osd_got_home = 0;               // tels if got home position or not
static float    osd_home_lat = 0;               // home latidude
static float    osd_home_lon = 0;               // home longitude
static float    osd_home_alt = 0; 
static long     osd_home_distance = 0;          // distance from home
static uint8_t  osd_home_direction;             // Arrow direction pointing to home (1-16 to CW loop)

static int8_t      osd_pitch = 0;                  // pitch form DCM
static int8_t      osd_roll = 0;                   // roll form DCM
static int8_t      osd_yaw = 0;                    // relative heading form DCM
static float    osd_heading = 0;                // ground course heading from GPS
static float    osd_alt = 0;                    // altitude
static float    osd_groundspeed = 0;            // ground speed
static uint16_t osd_throttle = 0;               // throtle

//MAVLink session control
static boolean  mavbeat = 0;
static float    lastMAVBeat = 0;
static boolean  waitingMAVBeats = 1;
static uint8_t  apm_mav_type;
static uint8_t  apm_mav_system; 
static uint8_t  apm_mav_component;
static boolean  enable_mav_request = 0;

// Panel BIT registers
byte panA_REG = 0b00000000;
byte panB_REG = 0b00000000;
byte panC_REG = 0b00000000;

byte modeScreen = 0; //NTSC:0, PAL:1

byte SerCMD1 = 0;
byte SerCMD2 = 0;


int tempvar;      // Temporary variable used on many places around the OSD

// First 8 panels and their X,Y coordinate holders
byte panCenter_XY[2]; // = { 13,7,0 };
byte panPitch_XY[2]; // = { 11,1 };
byte panRoll_XY[2]; // = { 23,7 };
byte panBattery_XY[2]; // = { 23,1 };
//byte pan--_XY[2] = { 0,0 };
byte panGPSats_XY[2]; // = { 2,12 };
byte panGPL_XY[2]; // = { 2,11 };
byte panGPS_XY[2]; // = { 2,13 };

// Second 8 set of panels and their X,Y coordinate holders
byte panRose_XY[2]; // = { 16,13 };
byte panHeading_XY[2]; // = { 16,12 };
byte panMavBeat_XY[2]; // = { 2,10 };
byte panHomeDir_XY[2]; // = { 0,0 };
byte panHomeDis_XY[2]; // = { 0,0 };
byte panWPDir_XY[2]; // = { 0,0 };
byte panWPDis_XY[2]; // = { 0,0 };
//byte pan---_XY[2] = { 0,0 };

// Third set of panels and their X,Y coordinate holders
byte panNav_XY[2]; // = { 0,0 };
byte panMod_XY[2]; // = { 0,0 };
byte panAlt_XY[2]; // = { 0,0 };
byte panVel_XY[2]; // = { 0,0 };
byte panThr_XY[2]; // = { 0,0 };
byte panFMod_XY[2]; // = { 0,0 };
//byte panXXX_XY[2] = { 0,0 };
//byte panXXX_XY[2] = { 0,0 };


