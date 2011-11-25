

/* ******************************************************************/
/* *********************** GENERAL FUNCTIONS ********************** */


///////////////////////////////////////////////////////
// Function: cliCheckup(void)
//
// On bootup time we will show loading bar and wait
// user input on Serial port, if no input in 2 seconds
// we will continue in normal mode eg starting to listen
// MAVLink commands

#define barX 5
#define barY 12

void cliCheckup() {
  int waitTimer;
  byte barStep = 0;
//  byte c;


  // Write plain panel to let users know what to do
  panBoot(barX,barY);

  delay(500);    // To give small extra waittime to users
//  Serial.flush(); 
  
  // Our main loop to wait input from user.  
  for(waitTimer = 0; waitTimer <= BOOTTIME; waitTimer++) {

    // How often we update our progress bar is depending on modulo
    if(waitTimer % (BOOTTIME / 8) == 0) {
      barStep++;
      
      // Update bar it self
      osd.setPanel(barX + 12, barY);
      osd.openPanel();
      switch(barStep) {
        case 0:
         osd.printf_P(PSTR("\xf1\xf2\xf2\xf2\xf2\xf2\xf2"));
         break;
        case 1:
         osd.printf_P(PSTR("\xef\xf2\xf2\xf2\xf2\xf2\xf2"));
         break;
        case 2:
         osd.printf_P(PSTR("\xee\xf0\xf2\xf2\xf2\xf2\xf2"));
         break;
        case 3:
         osd.printf_P(PSTR("\xee\xee\xf0\xf2\xf2\xf2\xf2"));
         break;
        case 4:
         osd.printf_P(PSTR("\xee\xee\xee\xf0\xf2\xf2\xf2"));
         break;
        case 5:
         osd.printf_P(PSTR("\xee\xee\xee\xee\xf0\xf2\xf2"));
         break;
        case 6:
         osd.printf_P(PSTR("\xee\xee\xee\xee\xee\xf0\xf2"));
         break;
        case 7:
         osd.printf_P(PSTR("\xee\xee\xee\xee\xee\xee\xf0"));
         break;
        case 8:
         osd.printf_P(PSTR("\xee\xee\xee\xee\xee\xee\xee"));
         break;
        case 9:
         osd.printf_P(PSTR("\xee\xee\xee\xee\xee\xee\xee\xee"));
         break;
      }
      osd.closePanel();
    }
    
    delay(1);       // Minor delay to make sure that we stay here long enough
  }
}


/* ********************************************** */
/* ************** ReadSettings ****************** */
void ReadSettings() {
  byte chr_index = 0;
  byte loopcount = 0;
  char cmd_char[8] = "";
 
  do {
    if (Serial.available() == 0) {
      delay(10);
      loopcount++;
    } else {
      cmd_char[chr_index] = Serial.read();
      loopcount = 0;
      chr_index++;
    }
  } while ((cmd_char[constrain(chr_index-1, 0, 8)] != '\r') && (loopcount < 5) && (chr_index < 8));
  
  // Variable banging.. Reusing old variables so be aware.  
  cmd_char[0] = cmd_char[0] - 48;
  tempvar = ((cmd_char[1] - 48 ) * 10) + (cmd_char[2] - 48);
  cmd_char[1] = tempvar;
  
  if(cmd_char[1] == 99) {
    writeSettings();
    osd.clear();
    readSettings();    
    return;
  }
  if(cmd_char[1] == 98) {
    for(tempvar = 0; tempvar == 255; tempvar++) {
      Serial.println(readEEPROM(tempvar), DEC);   
      return; 
    }  
  }
  tempvar = ((cmd_char[3] - 48 ) * 10) + (cmd_char[4] - 48);
  cmd_char[2] = tempvar;
  tempvar = ((cmd_char[5] - 48 ) * 10) + (cmd_char[6] - 48);
  cmd_char[3] = tempvar;

Serial.print(cmd_char[2], DEC);
Serial.print(",");
Serial.println(cmd_char[3],DEC);
     
  // data[0] = enable/disable  (0/1)
  // data[1] = panel number
  // data[2] = panel_x coordinates
  // data[3] = panel_y coordinates

  // Let's update EEPROM values
   updateSettings(cmd_char[1], cmd_char[2], cmd_char[3], cmd_char[0]);
}
