/*
ArduCam OSD - The Arduino based Remote Camera Control and OSD.

File : ArduCamOSD.pde
Version : v0.5, 25 november 2010

Author(s): Sandro Benigno (USB host and PTP library from Oleg Mazurov - circuitsathome.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.  You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <inttypes.h>
#include <avr/pgmspace.h>

#include <Spi.h>
#include <Max3421e.h>
#include <Max3421e_constants.h>
#include <Usb.h>

#include <ptp.h>
#include <ptpdebug.h>
#include "canonps.h"

#define DEV_ADDR        1

// Canon PowerShot S3 IS
#define DATA_IN_EP      1
#define DATA_OUT_EP     2
#define INTERRUPT_EP    3
#define CONFIG_NUM      1

#define MAX_USB_STRING_LEN 64

#define SerPri  Serial.print
#define SerPriln Serial.println
#define SerAva  Serial.available
#define SerRea  Serial.read

void setup();
void loop();
void ptpmain();

CanonPS  Ps(DEV_ADDR, DATA_IN_EP, DATA_OUT_EP, INTERRUPT_EP, CONFIG_NUM, (PTPMAIN)&ptpmain);
boolean camSession = false;

void setup() {
  Serial.begin( 9600 );
  //Serial.println("Started!");
  Ps.Setup();
  delay(200);
}

void loop() {
    Ps.Task();
}

void ptpmain()
{
  if (Ps.OpenSession() == PTP_RC_OK)
  {
    camSession = true;
    Ps.GetDeviceInfo(NULL);
    Ps.SetDevicePropValue(PS_DPC_EventEmulateMode, (uint16_t)4);
    while(camSession){
      readSerialCommand();
    }
    Ps.SetDevicePropValue(PS_DPC_EventEmulateMode, (uint16_t)2);
    Ps.CloseSession();
  }
}

void readSerialCommand() {
  char queryType;
  if (SerAva()) {
    queryType = SerRea();
    switch (queryType) {
    case 'A': //Activate Capture
      Ps.Initialize(true);
      delay(1000);
      //mapping capture target to SD card
      Ps.SetDevicePropValue(PS_DPC_CaptureTransferMode, (uint16_t)0x0F);
      break;
    case 'C': //Capture!!!
      Ps.Capture();
      delay(1000);
      break;
    case 'D': //Deactivate Capture
      Ps.Initialize(false);
      delay(1000);
      break;
    case 'L': //Focus Lock
      Ps.FocusLock();
      delay(500);
      break;
    case 'O': //ViewFinder Output. 1 = LCD. 2 = AV.
      Ps.SetDevicePropValue(PS_DPC_CameraOutput, (uint16_t)readFloatSerial());
      delay(1000);
      break;
    case 'U': //Focus Unlock
      Ps.FocusUnlock();
      delay(500);
      break;
    case 'V': //ViewFinder ON/OFF
      if((uint16_t)readFloatSerial() == 0){
        Ps.ViewFinder(false);
      }
      else Ps.ViewFinder(true);
      delay(1000);
      break;
    case 'X': //Close session forever
      Ps.Initialize(false);      
      delay(1000);
      camSession = false;
      break;
    case 'Z': //Set Zoom
      Ps.SetDevicePropValue(PS_DPC_Zoom, (uint16_t)readFloatSerial());
      delay(1000);
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
