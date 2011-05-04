#include <FastSerial.h>

#undef PROGMEM 
#define PROGMEM __attribute__(( section(".progmem.data") )) 

#undef PSTR 
#define PSTR(s) (__extension__({static prog_char __c[] PROGMEM = (s); &__c[0];}))

#include "ArduCam_Max7456.h"
#include "WProgram.h"
#include "Spi.h"

volatile int x;

OSD::OSD()
{
}

//------------------ init ---------------------------------------------------

void OSD::init()
{
  pinMode(MAX7456_SELECT,OUTPUT);
  digitalWrite(MAX7456_SELECT,HIGH); //disable device
  pinMode(MAX7456_VSYNC, INPUT);
  digitalWrite(MAX7456_VSYNC,HIGH); //enabling pull-up resistor
  // force soft reset on Max7456
  digitalWrite(MAX7456_SELECT,LOW);
  Spi.transfer(MAX7456_VM0_reg);
  Spi.transfer(MAX7456_reset);
  digitalWrite(MAX7456_SELECT,HIGH);
  delay(50);

  // set all rows to same charactor white level, 90%
  digitalWrite(MAX7456_SELECT,LOW);
  for (x = 0; x < MAX7456_screen_rows; x++)
  {
    Spi.transfer(x + 0x10);
    Spi.transfer(MAX7456_WHITE_level_120);
  }

  // define sync (auto,int,ext) and
  // making sure the Max7456 is enabled
  Spi.transfer(MAX7456_VM0_reg);
  //Spi.transfer(MAX7456_ENABLE_display_vert | MAX7456_SYNC_internal);
  //Spi.transfer(MAX7456_ENABLE_display_vert | MAX7456_SYNC_external);
  Spi.transfer(MAX7456_ENABLE_display_vert | MAX7456_SYNC_autosync);
  digitalWrite(MAX7456_SELECT,HIGH);

  //Serial.println("Initialized!");
}

//------------------ plug ---------------------------------------------------

void OSD::plug()
{
  digitalWrite(MAX7456_SELECT,LOW);
}

//------------------ clear ---------------------------------------------------

void OSD::clear()
{
  // clear the screen
  digitalWrite(MAX7456_SELECT,LOW);
  Spi.transfer(MAX7456_DMM_reg);
  Spi.transfer(MAX7456_CLEAR_display);
  digitalWrite(MAX7456_SELECT,HIGH);
}

//------------------ set panel -----------------------------------------------

void
OSD::setPanel(int st_col, int st_row){
  start_col = st_col;
  start_row = st_row;
  col = st_col;
  row = st_row;
  //Serial.printf("setPanel -> %d %d %d %d\n", start_col, start_row, max_col, max_row);
}

//------------------ open panel ----------------------------------------------

void
OSD::openPanel(void){
  unsigned int linepos;
  byte settings, char_address_hi, char_address_lo;
 
  //find [start address] position
  linepos = row*30+col;
  
  // divide 16 bits into hi & lo byte
  char_address_hi = linepos >> 8;
  char_address_lo = linepos;

  //Auto increment turn writing fast (less SPI commands).
  //No need to set next char address. Just send them
  settings = B00000011; //To Enable DMM Auto Increment
  digitalWrite(MAX7456_SELECT,LOW);
  Spi.transfer(MAX7456_DMM_reg); //dmm
  Spi.transfer(settings);

  Spi.transfer(MAX7456_DMAH_reg); // set start address high
  Spi.transfer(char_address_hi);

  Spi.transfer(MAX7456_DMAL_reg); // set start address low
  Spi.transfer(char_address_lo);
  //Serial.printf("setPos -> %d %d\n", col, row);
}

//------------------ close panel ---------------------------------------------

void
OSD::closePanel(void){  
  Spi.transfer(MAX7456_DMDI_reg);
  Spi.transfer(MAX7456_END_string); //This is needed "trick" to finish auto increment
  digitalWrite(MAX7456_SELECT,HIGH);
  //Serial.println("close");
  row++; //only after finish the auto increment the new row will really act as desired
}

//------------------ write ---------------------------------------------------

void
OSD::write(uint8_t c){
  if(c == '|'){
    closePanel(); //It does all needed to finish auto increment and change current row
    openPanel(); //It does all needed to re-enable auto increment
  }
  else{
    Spi.transfer(MAX7456_DMDI_reg);
    Spi.transfer(c);
  }
}

//------------------ pure virtual ones (just overriding) ---------------------

int  OSD::available(void){
}
int  OSD::read(void){
}
int  OSD::peek(void){
}
void OSD::flush(void){
}
