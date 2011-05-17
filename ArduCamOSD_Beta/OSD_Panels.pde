/******* STARTUP PANEL *******/

void startPanels(){
  osd.clear();
  panLogo(10,5);
}

/******* PANELS - POSITION *******/

void writePanels(){
//osd.clear();
int offset = 2;
#ifdef isPAL
  offset = 0;
#endif
  //Top = no offset in NTSC
  panHome(2,1);  //1x2
  panBattery(22,1); //7x1 
  //Bottom = need offset in NTSC
  panCenter(13,8-offset); //4x2
  panGPS(2,12-offset); //12x3
  panCompass(16,12-offset); //13x3
  //osd.control(1);
}

/******* PANELS - DEFINITION *******/

//------------------ Panel: Home ---------------------------------------------------

void panHome(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%5.0f|%c%5.0f|%c%5.0f%c",0x1f,hom_dis,0x85,alt,0x86,vel,0x88);
  osd.closePanel();
}

//------------------ Panel: Center -------------------------------------------------

void panCenter(int first_col, int first_line){
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%c%c%c%c|%c%c%c%c",0x05,0x03,0x04,0x05,0x15,0x13,0x14,0x15);
  osd.closePanel();
}

//------------------ Panel: Battery ------------------------------------------------

void panBattery(int first_col, int first_line){
  char buf_bat[6] = {0xb4,0xb5,0xb6,0xb7,0xb8,0xb9}; //dead, critic, 25%, 50%, 75%, 100%
  float critic = bat_cel * 3.0;
  float full = bat_cel * 3.7;
  float level = round((bat_val - critic) * (5 - 0) / (full - critic) + 0);
  level = constrain(level, 0, 5);
  if(bat_val < 0) bat_val = 0;
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%4.1f%c%c", bat_val, 0x76, buf_bat[(int)level]);
  osd.closePanel();
}

//------------------ Panel: Startup ArduCam OSD LOGO -------------------------------

void panLogo(int first_col, int first_line){
  char buf_logo[][12] = { //11 Null terminated 
    {0x20,0x20,0x20,0x20,0xba,0xbb,0xbc,0xbd,0xbe},
    {0x20,0x20,0x20,0x20,0xca,0xcb,0xcc,0xcd,0xce},
    {"ArduCam OSD"}
  };
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf("%s|%s|%s", buf_logo[0], buf_logo[1], buf_logo[2]);
  osd.closePanel();
}

//------------------ Panel: GPS ---------------------------------------------------

void panGPS(int first_col, int first_line){
  char buf_lock[3] = {0x10,0x11};
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  switch (gps_lock){
    case 0:
      osd.printf("%c%c%2.0f %c|%c%s|%c%s", 0x0f, 0xe3,(float)num_sat, buf_lock[0], 0x83, " ---- ", 0x84, " ---- ");
      break;
    case 1:
      osd.printf("%c%c%d %c|%c%11.6f|%c%11.6f", 0x0f, 0xe3,num_sat, buf_lock[1], 0x83, lat, 0x84, lon);
      break;
  }
  osd.closePanel();
}

//------------------ Panel: Compass -----------------------------------------------

void panCompass(int first_col, int first_line){
  char buf_Rule[36] = {0xc2,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                       0xc4,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                       0xc3,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0,
                       0xc5,0xc0,0xc0,0xc1,0xc0,0xc0,0xc1,0xc0,0xc0};
  char buf_mark[14] = {0x20,0xc0,0xc0,0xc0,0xc0,0xc0,0xc7,0xc0,0xc0,0xc0,0xc0,0xc0,0x20,'\0'};
  char buf_show[12];
  buf_show[11] = '\0';
  int start;
  start = round((head * 18)/180);
  start -= 5;
  if(start < 0) start += 36;
  for(int x=0; x <= 10; x++){
    buf_show[x] = buf_Rule[start];
    if(++start > 35) start = 0;
  }
  osd.setPanel(first_col, first_line);
  osd.openPanel();
  osd.printf(" %c%c%4.0f%c|%s|%c%s%c", 0xc8, 0xc9, head, 0xb0, buf_mark, 0xd0, buf_show, 0xd1);
  osd.closePanel();
}
