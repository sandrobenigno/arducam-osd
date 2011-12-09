/* ******************************************************************/
/* *********************** GENERAL FUNCTIONS ********************** */

boolean ISa(byte whichBit) {
  return getBit(panA_REG, whichBit);
}

boolean ISb(byte whichBit) {
  return getBit(panB_REG, whichBit);
}

boolean ISc(byte whichBit) {
  return getBit(panC_REG, whichBit);
}

boolean getBit(byte Reg, byte whichBit) {
  boolean State;
  State = Reg & (1 << whichBit);
  return State;
}

byte setBit(byte &Reg, byte whichBit, boolean stat) {
  if (stat) {
    Reg = Reg | (1 << whichBit);
  } 
  else {
    Reg = Reg & ~(1 << whichBit);
  }
  return Reg;
}

// EEPROM reader/writers
// Utilities for writing and reading from the EEPROM
byte readEEPROM(int address) {

  return EEPROM.read(address);
}

void writeEEPROM(byte value, int address) {
  EEPROM.write(address, value);
}


void InitializeOSD() {
  
  cliCheckup();
  delay(500);

  writeEEPROM(42, CHK1);
  writeEEPROM(VER-42,CHK2);
  writeSettings();
  
  osd.setPanel(4,9);
  osd.openPanel();
  osd.printf_P(PSTR("OSD Initialized, reboot")); 
  osd.closePanel();
 
  // run for ever so user resets 
  for(;;) {}
   
}

// Write our latest FACTORY settings to EEPROM
void writeSettings() {
 // Writing all default parameters to EEPROM, ON = panel enabled  
 // All panels have 3 values:
 //  - Enable/Disable
 //  - X coordinate on screen
 //  - Y coordinate on screen
 writeEEPROM(on, panCenter_en_ADDR);
 writeEEPROM(13, panCenter_x_ADDR);
 writeEEPROM(0,  panCenter_y_ADDR);//calculated in runtime (0 + autodetect center)
 writeEEPROM(on, panPitch_en_ADDR);
 writeEEPROM(23, panPitch_x_ADDR);
 writeEEPROM(9,  panPitch_y_ADDR);
 writeEEPROM(on, panRoll_en_ADDR);
 writeEEPROM(11, panRoll_x_ADDR);
 writeEEPROM(1,  panRoll_y_ADDR);
 writeEEPROM(on, panBattery_en_ADDR);
 writeEEPROM(23, panBattery_x_ADDR);
 writeEEPROM(1,  panBattery_y_ADDR);
 writeEEPROM(on, panGPSats_en_ADDR);
 writeEEPROM(1,  panGPSats_x_ADDR);
 writeEEPROM(13, panGPSats_y_ADDR);
 writeEEPROM(on, panGPL_en_ADDR);
 writeEEPROM(1,  panGPL_x_ADDR);
 writeEEPROM(12, panGPL_y_ADDR);
 writeEEPROM(on, panGPS_en_ADDR);
 writeEEPROM(1,  panGPS_x_ADDR);
 writeEEPROM(14, panGPS_y_ADDR);
 writeEEPROM(on, panRose_en_ADDR);
 writeEEPROM(17, panRose_x_ADDR);
 writeEEPROM(14, panRose_y_ADDR);
 writeEEPROM(on, panHeading_en_ADDR);
 writeEEPROM(25, panHeading_x_ADDR);
 writeEEPROM(13, panHeading_y_ADDR);
 writeEEPROM(on, panMavBeat_en_ADDR);
 writeEEPROM(1,  panMavBeat_x_ADDR);
 writeEEPROM(9, panMavBeat_y_ADDR);
 writeEEPROM(on, panHomeDir_en_ADDR);
 writeEEPROM(14, panHomeDir_x_ADDR);
 writeEEPROM(3,  panHomeDir_y_ADDR);
 writeEEPROM(on, panHomeDis_en_ADDR);
 writeEEPROM(1,  panHomeDis_x_ADDR);
 writeEEPROM(1,  panHomeDis_y_ADDR);
 writeEEPROM(off,panWPDir_en_ADDR);
 writeEEPROM(0,  panWPDir_x_ADDR);
 writeEEPROM(0,  panWPDir_y_ADDR);
 writeEEPROM(off,panWPDis_en_ADDR);
 writeEEPROM(0,  panWPDis_x_ADDR);
 writeEEPROM(0,  panWPDis_y_ADDR);
 writeEEPROM(on, panNav_en_ADDR);
 writeEEPROM(23, panNav_x_ADDR);
 writeEEPROM(3,  panNav_y_ADDR);
 writeEEPROM(on, panMod_en_ADDR);
 writeEEPROM(23, panMod_x_ADDR);
 writeEEPROM(4,  panMod_y_ADDR);
 writeEEPROM(on, panAlt_en_ADDR);
 writeEEPROM(1,  panAlt_x_ADDR);
 writeEEPROM(2,  panAlt_y_ADDR);
 writeEEPROM(on, panVel_en_ADDR);
 writeEEPROM(1,  panVel_x_ADDR);
 writeEEPROM(3,  panVel_y_ADDR);
 writeEEPROM(on, panThr_en_ADDR);
 writeEEPROM(1,  panThr_x_ADDR);
 writeEEPROM(4,  panThr_y_ADDR);
 writeEEPROM(on, panFMod_en_ADDR);
 writeEEPROM(1,  panFMod_x_ADDR);
 writeEEPROM(10,  panFMod_y_ADDR);
}

void readSettings() {
  
  // First set of 8 Panels
  setBit(panA_REG, Cen_BIT, readEEPROM(panCenter_en_ADDR));
  panCenter_XY[0] = readEEPROM(panCenter_x_ADDR);
  panCenter_XY[1] = readEEPROM(panCenter_y_ADDR);
  
  setBit(panA_REG, Pit_BIT, readEEPROM(panPitch_en_ADDR));
  panPitch_XY[0] = readEEPROM(panPitch_x_ADDR);
  panPitch_XY[1] = checkPAL(readEEPROM(panPitch_y_ADDR));
  
  setBit(panA_REG, Rol_BIT, readEEPROM(panRoll_en_ADDR));
  panRoll_XY[0] = readEEPROM(panRoll_x_ADDR);
  panRoll_XY[1] = checkPAL(readEEPROM(panRoll_y_ADDR));
  
  setBit(panA_REG, Bat_BIT, readEEPROM(panBattery_en_ADDR));
  panBattery_XY[0] = readEEPROM(panBattery_x_ADDR);
  panBattery_XY[1] = checkPAL(readEEPROM(panBattery_y_ADDR));
  
  setBit(panA_REG, GPSats_BIT, readEEPROM(panGPSats_en_ADDR));
  panGPSats_XY[0] = readEEPROM(panGPSats_x_ADDR);
  panGPSats_XY[1] = checkPAL(readEEPROM(panGPSats_y_ADDR));

  setBit(panA_REG, GPL_BIT, readEEPROM(panGPL_en_ADDR));
  panGPL_XY[0] = readEEPROM(panGPL_x_ADDR);
  panGPL_XY[1] = checkPAL(readEEPROM(panGPL_y_ADDR));
  
  setBit(panA_REG, GPS_BIT, readEEPROM(panGPS_en_ADDR));
  panGPS_XY[0] = readEEPROM(panGPS_x_ADDR);
  panGPS_XY[1] = checkPAL(readEEPROM(panGPS_y_ADDR));

  // Second set of 8 Panels
  setBit(panB_REG, Rose_BIT, readEEPROM(panRose_en_ADDR));
  panRose_XY[0] = readEEPROM(panRose_x_ADDR);
  panRose_XY[1] = checkPAL(readEEPROM(panRose_y_ADDR));

  setBit(panB_REG, Head_BIT, readEEPROM(panHeading_en_ADDR));
  panHeading_XY[0] = readEEPROM(panHeading_x_ADDR);
  panHeading_XY[1] = checkPAL(readEEPROM(panHeading_y_ADDR));

  setBit(panB_REG, MavB_BIT, readEEPROM(panMavBeat_en_ADDR));
  panMavBeat_XY[0] = readEEPROM(panMavBeat_x_ADDR);
  panMavBeat_XY[1] = checkPAL(readEEPROM(panMavBeat_y_ADDR));

  setBit(panB_REG, HDis_BIT, readEEPROM(panHomeDis_en_ADDR));
  panHomeDis_XY[0] = readEEPROM(panHomeDis_x_ADDR);
  panHomeDis_XY[1] = checkPAL(readEEPROM(panHomeDis_y_ADDR));

  setBit(panB_REG, HDir_BIT, readEEPROM(panHomeDir_en_ADDR));
  panHomeDir_XY[0] = readEEPROM(panHomeDir_x_ADDR);
  panHomeDir_XY[1] = checkPAL(readEEPROM(panHomeDir_y_ADDR));

  // Third set of 8 Panels
  setBit(panC_REG, Nav_BIT, readEEPROM(panNav_en_ADDR));
  panNav_XY[0] = readEEPROM(panNav_x_ADDR);
  panNav_XY[1] = checkPAL(readEEPROM(panNav_y_ADDR));

  setBit(panC_REG, Mod_BIT, readEEPROM(panMod_en_ADDR));
  panMod_XY[0] = readEEPROM(panMod_x_ADDR);
  panMod_XY[1] = checkPAL(readEEPROM(panMod_y_ADDR));

  setBit(panC_REG, Alt_BIT, readEEPROM(panAlt_en_ADDR));
  panAlt_XY[0] = readEEPROM(panAlt_x_ADDR);
  panAlt_XY[1] = checkPAL(readEEPROM(panAlt_y_ADDR));

  setBit(panC_REG, Vel_BIT, readEEPROM(panVel_en_ADDR));
  panVel_XY[0] = readEEPROM(panVel_x_ADDR);
  panVel_XY[1] = checkPAL(readEEPROM(panVel_y_ADDR));

  setBit(panC_REG, Thr_BIT, readEEPROM(panThr_en_ADDR));
  panThr_XY[0] = readEEPROM(panThr_x_ADDR);
  panThr_XY[1] = checkPAL(readEEPROM(panThr_y_ADDR));

  setBit(panC_REG, FMod_BIT, readEEPROM(panFMod_en_ADDR));
  panFMod_XY[0] = readEEPROM(panFMod_x_ADDR);
  panFMod_XY[1] = checkPAL(readEEPROM(panFMod_y_ADDR));

}

int checkPAL(int line){
  if(line >= osd.getCenter() && osd.getMode() == 0){
    line -= 3;//Cutting lines offset after center if NTSC
  }
  return line;
}

void updateSettings(byte panel, byte panel_x, byte panel_y, byte panel_s ) {
  if(panel >= 1 && panel <= 32) {
    
    writeEEPROM(panel_s, (6 * panel) - 6 + 0);
    if(panel_s != 0) {
      writeEEPROM(panel_x, (6 * panel) - 6 + 2);
      writeEEPROM(panel_y, (6 * panel) - 6 + 4);
    }
    osd.clear();
    readSettings();
  } 
}

