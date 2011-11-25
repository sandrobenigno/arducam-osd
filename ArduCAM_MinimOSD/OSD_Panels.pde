
/******* STARTUP PANEL *******/

void startPanels(){
  osd.clear();
  
  panCenter_XY[0] = readEEPROM(panCenter_x_ADDR);
  panCenter_XY[1] = readEEPROM(panCenter_y_ADDR);
  
  // Display our logo  
  panLogo(10,5);
}

/******* PANELS - POSITION *******/

void writePanels(){
  if(millis() < (lastMAVBeat + 2000)){

    //Testing bits from 8 bit register A 
    if(ISa(Cen_BIT)) panCenter(panCenter_XY[0], (panCenter_XY[1] + osd.getCenter()));   //4x2
    if(ISa(Pit_BIT)) panPitch(panPitch_XY[0], panPitch_XY[1]);               //5x1
    if(ISa(Rol_BIT)) panRoll(panRoll_XY[0], panRoll_XY[1]);         //5x1
    if(ISa(Bat_BIT)) panBattery(panBattery_XY[0], panBattery_XY[1]);         //7x1
    if(ISa(GPSats_BIT)) panGPSats(panGPSats_XY[0], panGPSats_XY[1]);
    if(ISa(GPL_BIT)) panGPL(panGPL_XY[0], panGPL_XY[1]);            //1x1
    if(ISa(GPS_BIT)) panGPS(panGPS_XY[0], panGPS_XY[1]);            //12x3
  
    //Testing bits from 8 bit register B
    if(ISb(Rose_BIT)) panRose(panRose_XY[0], panRose_XY[1]);        //13x3
    if(ISb(Head_BIT)) panHeading(panHeading_XY[0], panHeading_XY[1]); //13x3
    if(ISb(MavB_BIT)) panMavBeat(panMavBeat_XY[0], panMavBeat_XY[1]); //13x3

    if(osd_got_home == 1){
      if(ISb(HDis_BIT)) panHomeDis(panHomeDis_XY[0], panHomeDis_XY[1]);        //13x3
      if(ISb(HDir_BIT)) panHomeDir(panHomeDir_XY[0], panHomeDir_XY[1]);        //13x3
    }
    //Testing bits from 8 bit register C 
    //if(ISc(Mod_BIT)) panMod(panMod_XY[0], panMod_XY[1]); //7x1 Debug Mod
    //if(ISc(Nav_BIT)) panNav(panNav_XY[0], panNav_XY[1]); //7x1 Debug Nav 
    if(osd_got_home == 1){
      if(ISc(Alt_BIT)) panAlt(panAlt_XY[0], panAlt_XY[1]);
      if(ISc(Vel_BIT)) panVel(panVel_XY[0], panVel_XY[1]);
    }
    if(ISc(Thr_BIT)) panThr(panThr_XY[0], panThr_XY[1]);
    if(ISc(FMod_BIT)) panFlightMode(panFMod_XY[0], panFMod_XY[1]); 

  }
  else{
    osd.clear();
    waitingMAVBeats = 1;
    // Display our logo and waiting... 
    panWaitMAVBeats(5,10); //Waiting for MAVBeats...
  }
}

/******* PANELS - DEFINITION *******/


/* **************************************************************** */
// Panel  : panAlt
// Needs  : X, Y locations
// Output : Alt symbol and altitude value in meters from MAVLink
// Size   : 1 x 7Hea  (rows x chars)
// Staus  : done

void panAlt(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  //osd.printf("%c%5.0f%c",0x85, (double)(osd_alt - osd_home_alt), 0x8D);
  osd.printf("%c%5.0f%c",0x85, (double)(osd_alt), 0x8D);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panVel
// Needs  : X, Y locations
// Output : Throttle value from MAVlink with symbols
// Size   : 1 x 7  (rows x chars)
// Staus  : done

void panVel(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%5.0f%c ",0x86,(double)osd_groundspeed,0x88);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panThr
// Needs  : X, Y locations
// Output : Throttle value from MAVlink with symbols
// Size   : 1 x 7  (rows x chars)
// Staus  : done

void panThr(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%5.0i%c",0x87,osd_throttle,0x25);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panHomeDis
// Needs  : X, Y locations
// Output : Home Symbol with distance to home in meters
// Size   : 1 x 7  (rows x chars)
// Staus  : done

void panHomeDis(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%5.0f%c", 0x1F, (double)osd_home_distance, 0x8D);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panCenter
// Needs  : X, Y locations
// Output : 2 row croshair symbol created by 2 x 4 chars
// Size   : 2 x 4  (rows x chars)
// Staus  : done

void panCenter(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf_P(PSTR("\x05\x03\x04\x05|\x15\x13\x14\x15"));
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panPitch
// Needs  : X, Y locations
// Output : -+ value of current Pitch from vehicle with degree symbols and pitch symbol
// Size   : 1 x 6  (rows x chars)
// Staus  : done

void panPitch(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%4i%c%c",osd_pitch,0xb0,0xb1);
//  osd.printf("%c%4i%c",0xb1,osd_pitch,0xb0);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panRoll
// Needs  : X, Y locations
// Output : -+ value of current Roll from vehicle with degree symbols and roll symbol
// Size   : 1 x 6  (rows x chars)
// Staus  : done

void panRoll(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%4i%c%c",osd_roll,0xb0,0xb2);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panBattery
// Needs  : X, Y locations
// Output : Voltage value as in XX.X and symbol of over all battery status
// Size   : 1 x 5  (rows x chars)
// Staus  : done

void panBattery(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%2.1f%c%c", (double)osd_vbat, 0x8E, 0xB4);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panMod
// Needs  : X, Y locations
// Output : Text field with numeric output to show current flight mode, needs osd nav mode to be complete.
// Size   : 1 x 9  (rows x chars)
// Staus  : done

void panMod(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%s%1.0i","Mod:",osd_mode);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panNav
// Needs  : X, Y locations
// Output : Text field and numeric value to show osd navigation mode, works along with osd mode
// Size   : 1 x 9  (rows x chars)
// Staus  : done

void panNav(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%s%1.0i","Nav:", osd_nav_mode);
  osd.closePanel();
}

//------------------ Panel: Startup ArduCam OSD LOGO -------------------------------

void panLogo(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf_P(PSTR("\x20\x20\x20\x20\xba\xbb\xbc\xbd\xbe|\x20\x20\x20\x20\xca\xcb\xcc\xcd\xce|ArduCam OSD"));
  osd.closePanel();
}

//------------------ Panel: Waiting for MAVLink HeartBeats -------------------------------

void panWaitMAVBeats(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf_P(PSTR("Waiting for|MAVLink heartbeats..."));
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panGPL
// Needs  : X, Y locations
// Output : 1 static symbol with changing FIX symbol
// Size   : 1 x 2  (rows x chars)
// Staus  : done

void panGPL(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  switch(osd_fix_type) {
    case 0: 
      osd.printf_P(PSTR("\x10\x20"));
      break;
    case 1: 
      osd.printf_P(PSTR("\x10\x20"));
      break;
    case 2: 
      osd.printf_P(PSTR("\x11\x20"));//If not APM, x01 could show 2D fix
      break;
    case 3: 
      osd.printf_P(PSTR("\x11\x20"));//If not APM, x02 could show 3D fix
      break;
  }
    
    /*  if(osd_fix_type <= 1) {
    osd.printf_P(PSTR("\x10"));
  } else {
    osd.printf_P(PSTR("\x11"));
  }  */
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panGPSats
// Needs  : X, Y locations
// Output : 1 symbol and number of locked satellites
// Size   : 1 x 5  (rows x chars)
// Staus  : done

void panGPSats(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c  %2.0i", 0x0f,osd_satellites_visible);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panGPS
// Needs  : X, Y locations
// Output : two row numeric value of current GPS location with LAT/LON symbols as on first char
// Size   : 2 x 12  (rows x chars)
// Staus  : done

void panGPS(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%11.6f|%c%11.6f", 0x83, (double)osd_lat, 0x84, (double)osd_lon);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panHeading
// Needs  : X, Y locations
// Output : Symbols with numeric compass heading value
// Size   : 1 x 7  (rows x chars)
// Staus  : not ready

void panHeading(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf(" %c%c%4.0f%c", 0xc8, 0xc9, (double)osd_heading, 0xb0);
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panRose
// Needs  : X, Y locations
// Output : a dynamic compass rose that changes along the heading information
// Size   : 2 x 13  (rows x chars)
// Staus  : done

void panRose(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  //osd_heading  = osd_yaw;
  //if(osd_yaw < 0) osd_heading = 360 + osd_yaw;
  osd.printf("%s|%c%s%c", "\x20\xc0\xc0\xc0\xc0\xc0\xc7\xc0\xc0\xc0\xc0\xc0\x20", 0xd0, buf_show, 0xd1);
  osd.closePanel();
}


/* **************************************************************** */
// Panel  : panBoot
// Needs  : X, Y locations
// Output : Booting up text and empty bar after that
// Size   : 1 x 21  (rows x chars)
// Staus  : done

void panBoot(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf_P(PSTR("Booting up:\xed\xf2\xf2\xf2\xf2\xf2\xf2\xf2\xf3")); 
  osd.closePanel();

}

/* **************************************************************** */
// Panel  : panMavBeat
// Needs  : X, Y locations
// Output : 2 symbols, one static and one that blinks on every 50th received 
//          mavlink packet.
// Size   : 1 x 2  (rows x chars)
// Staus  : done

void panMavBeat(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  if(mavbeat == 1){
    osd.printf_P(PSTR("\xEA\xEC"));
    mavbeat = 0;
  }
  else{
    osd.printf_P(PSTR("\xEA\xEB"));
  }
  osd.closePanel();
}


/* **************************************************************** */
// Panel  : panWPDir
// Needs  : X, Y locations
// Output : 2 symbols that are combined as one arrow, shows direction to next waypoint
// Size   : 1 x 2  (rows x chars)
// Staus  : not ready

void panWPDir(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  showArrow();
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panHomeDir
// Needs  : X, Y locations
// Output : 2 symbols that are combined as one arrow, shows direction to home
// Size   : 1 x 2  (rows x chars)
// Status : not tested

void panHomeDir(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  showArrow();
  osd.closePanel();
}

/* **************************************************************** */
// Panel  : panFlightMode 
// Needs  : X, Y locations
// Output : 2 symbols, one static name symbol and another that changes by flight modes
// Size   : 1 x 2  (rows x chars)
// Status : done

void panFlightMode(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  if(apm_mav_system == 7 && apm_mav_component == 1){//ArduCopter MEGA
    if(osd_mode == 100 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE2"));//Stabilize
    if(osd_mode == 101 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE3"));//Acrobatic
    if(osd_mode == 102 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE7"));//Simple
    if(osd_mode == 103 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE6"));//Alt Hold
    if(osd_mode == 104 && osd_nav_mode == 3) osd.printf_P(PSTR("\xE0\xE1"));//Auto
    if(osd_mode == 105 && osd_nav_mode == 3) osd.printf_P(PSTR("\xE0\xE1"));//GCS Auto
    if(osd_mode == 106 && osd_nav_mode == 2) osd.printf_P(PSTR("\xE0\xE4"));//Loiter
    if(osd_mode == 107 && osd_nav_mode == 5) osd.printf_P(PSTR("\xE0\xE5"));//Return to Launch
  }
  else if(apm_mav_system == 7 && apm_mav_component == 0){//ArduPilot MEGA Fixed Wing
    if(osd_mode == 100 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE2"));//Stabilize
    if(osd_mode == 2 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE3"));//Acrobatic
    if(osd_mode == 4 && osd_nav_mode == 2) osd.printf_P(PSTR("\xE0\xE4"));//Loiter
    if(osd_mode == 4 && osd_nav_mode == 5) osd.printf_P(PSTR("\xE0\xE5"));//Return to Launch
    if(osd_mode == 6 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE6"));//Alt Hold
    if(osd_mode == 5 && osd_nav_mode == 4) osd.printf_P(PSTR("\xE0\xE7"));//Simple
  }
//    if(osd_mode == 3 && osd_nav_mode == 4) osd.printf_P(PSTR("\xD0\xD2"));
  osd.closePanel();
}


// ---------------- EXTRA FUNCTIONS ----------------------
// Show those fancy 2 char arrows
void showArrow() {  
   switch(osd_home_direction) {
    case 0: 
      osd.printf_P(PSTR("\x90\x91"));
      break;
    case 1: 
      osd.printf_P(PSTR("\x90\x91"));
      break;
    case 2: 
      osd.printf_P(PSTR("\x92\x93"));
      break;
    case 3: 
      osd.printf_P(PSTR("\x94\x95"));
      break;
    case 4: 
      osd.printf_P(PSTR("\x96\x97"));
      break;
    case 5: 
      osd.printf_P(PSTR("\x98\x99"));
      break;
    case 6: 
      osd.printf_P(PSTR("\x9A\x9B"));
      break;
    case 7: 
      osd.printf_P(PSTR("\x9C\x9D"));
      break;
    case 8: 
      osd.printf_P(PSTR("\x9E\x9F"));
      break;
    case 9: 
      osd.printf_P(PSTR("\xA0\xA1"));
      break;
    case 10: 
      osd.printf_P(PSTR("\xA2\xA3"));
      break;
    case 11: 
      osd.printf_P(PSTR("\xA4\xA5"));
      break;
    case 12: 
      osd.printf_P(PSTR("\xA6\xA7"));
      break;
    case 13: 
      osd.printf_P(PSTR("\xA8\xA9"));
      break;
    case 14: 
      osd.printf_P(PSTR("\xAA\xAB"));
      break;
    case 15: 
      osd.printf_P(PSTR("\xAC\xAD"));
      break;
    case 16: 
      osd.printf_P(PSTR("\xAE\xAF"));
      break;
  }  
}
