/*
ArduCam OSD - The Arduino based Remote Camera Control and OSD.

File : ArduCamOSD_Beta.pde
Version : v0.9, 25 april 2011

Author(s): Sandro Benigno
           FastSerial and BetterStream from Michael Smith
           USB host and PTP library from Oleg Mazurov - circuitsathome.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.  You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <FastSerial.h>

#undef PROGMEM 
#define PROGMEM __attribute__(( section(".progmem.data") )) 

#undef PSTR 
#define PSTR(s) (__extension__({static prog_char __c[] PROGMEM = (s); &__c[0];})) 

#include <inttypes.h>
#include <avr/pgmspace.h>
#include <stdio.h>

#include "Spi.h"
#include "Wire.h" //Future i2c comunication. Uncommented to watch hex size

/****** USB INCLUDES ******/
#include <Max3421e.h>
#include <Max3421e_constants.h>
#include <Usb.h>
#include <ptp.h>
#include <ptpdebug.h>
#include <canonps.h>
#include <simpletimer.h>
#include "pseventparser.h"
#include "ptpobjinfoparser.h"

#define DEV_ADDR        1
//Example -> Canon PowerShot S3 IS
#define DATA_IN_EP      1
#define DATA_OUT_EP     2
#define INTERRUPT_EP    3
#define CONFIG_NUM      1

#define MAX_USB_STRING_LEN 64

/****** OSD INCLUDES ******/
#include "ArduCam_Max7456.h"
#include "OSD_Vars.h"

#define SerPri  Serial.print
#define SerPriln Serial.println
#define SerAva  Serial.available
#define SerRea  Serial.read

void setup();
void loop();

FastSerialPort0(Serial);

/****** CAMSTATES CLASS ******/
class CamStateHandlers : public PSStateHandlers
{
      bool stateConnected;
    
public:
      CamStateHandlers() : stateConnected(false) {};
      
      virtual void OnDeviceDisconnectedState(PTP *ptp);
      virtual void OnDeviceInitializedState(PTP *ptp);
} CamStates;
/****** END CAMSTATES ******/

/****** OBJECTS ******/
OSD osd; //OSD object instance
CanonPS  Ps(DEV_ADDR, DATA_IN_EP, DATA_OUT_EP, INTERRUPT_EP, CONFIG_NUM, &CamStates); //Canon PS object instance
SimpleTimer  displayTimer, cameraTimer; //Timers

/********** HANDLERS**********/

void CamStateHandlers::OnDeviceDisconnectedState(PTP *ptp)
{
    if (stateConnected)
    {
        cameraTimer.Disable();
        stateConnected = false;
        Notify(PSTR("Camera disconnected\r\n"));
    }
}

void CamStateHandlers::OnDeviceInitializedState(PTP *ptp)
{
    if (!stateConnected)
    {
        Notify(PSTR("Camera connected\r\n"));
        stateConnected = true;
        cameraTimer.Enable();
    }
}

/**********END TIMERS HANDLERS******/

//Demo vars control (!!! Remember to delete it after APM integration)
float lastGPSUpdate = 0;
float lastBatUpdate = 0;
float lastHeadUpdate = 0;
float headIncrementSignal = 1;

void setup()
{
  Serial.begin(115200);
  pinMode(10, OUTPUT); //usb host CS
  pinMode(6,  OUTPUT); //OSD CS
  
  unplugSlaves();
  osd.init();
  startPanels();
  delay( 200 );
  
  unplugSlaves();
  Ps.Setup();
  
  //Starting Timers
  displayTimer.Set(&OnDisplayTimer, 20);
  cameraTimer.Set(&OnCameraTimer, 500);
  delay( 200 );
  //displayTimer.Disable();
  displayTimer.Enable();
}

void loop(){
  unplugSlaves();
  displayTimer.Run();
  unplugSlaves();
  Ps.Task();
  cameraTimer.Run();
}

void OnCameraTimer()
{
  readSerialCommand();
}

void OnDisplayTimer()
{
  osd_job();
}

void writeOSD() //Interrupt function (ISR)
{
  //Serial.println("Interrupt!");
  detachInterrupt(0); //It will respect the new aquisition
  unplugSlaves();
  osd.clear();
  writePanels();//Check OSD_Panels Tab!
}

void osd_job()
{ 
	/*Its the place for data aquisition*/
	
	/*JUST Simulated here as DEMO and test*/
	
  if(millis() > lastGPSUpdate + 100){
    lastGPSUpdate = millis();
    lat+=0.0001;
    lon+=0.002;
    hom_dis+=1;
  }
  if(millis() > lastHeadUpdate + 100){
    lastHeadUpdate = millis();
    
    //looping forever
    
    if(head >= 180){
      head -= 360;
    }else head+=5;
    
    //or ping-pong
    
    /*if(head >= 180) headIncrementSignal = -1;
    if(head <= -180) headIncrementSignal = 1;
    head += 1.8 * headIncrementSignal;*/
  }
  if(millis() > lastBatUpdate + 2000){
    lastBatUpdate = millis();
    alt++;
    vel+=5;
    bat_val -= 0.1;
  }
  
  //Next line will arm OSD function for the next VSync interruption
  attachInterrupt(0, writeOSD, FALLING);
}

void readSerialCommand() {
  char queryType;
  if (SerAva()) {
    queryType = SerRea();
    switch (queryType) {
    case 'A': //Activate Capture
      Ps.Initialize(true);
      //mapping capture target to SD card
      Ps.SetDevicePropValue(PS_DPC_CaptureTransferMode, (uint16_t)0x0F);
      break;
    case 'C': //Capture!!!
      Ps.Capture();
      break;
    case 'D': //Deactivate Capture
      Ps.Operation(PS_OC_ViewfinderOff);
      Ps.Initialize(false);
      break;
    case 'L': //Focus Lock
      Ps.Operation(PS_OC_FocusLock);
      delay(50);
      break;
    case 'O': //ViewFinder Output. 1 = LCD. 2 = AV.
      Ps.SetDevicePropValue(PS_DPC_CameraOutput, (uint16_t)readFloatSerial());
      break;
    case 'U': //Focus Unlock
      Ps.Operation(PS_OC_FocusUnlock);
      break;
    case 'V': //ViewFinder ON/OFF
      if((uint16_t)readFloatSerial() == 0){
        Ps.Operation(PS_OC_ViewfinderOff);
      }
      else Ps.Operation(PS_OC_ViewfinderOn);
      break;
    case 'X': //Close session forever
      Ps.Initialize(false);      
      break;
    case 'Z': //Set Zoom
      Ps.SetDevicePropValue(PS_DPC_Zoom, (uint16_t)readFloatSerial());
      break;
    }
  }
}

float readFloatSerial() {
  byte index = 0;
  byte timeout = 0;
  char data[128] = "";

  do {
    if (SerAva() == 0) {
      delay(10);
      timeout++;
    }
    else {
      data[index] = SerRea();
      timeout = 0;
      index++;
    }
  }  
  while ((data[constrain(index-1, 0, 128)] != ';') && (timeout < 5) && (index < 128));
  return atof(data);
}

void unplugSlaves(){
  digitalWrite(10, HIGH); //unplug USB Host
  digitalWrite(6,  HIGH); //unplug OSD
}
