# Does it suitable to my camera? #

Currently, this project is based on Canon SDK (PS-ReCSDK 1.1.0e) definitions.

The SDK lists the follow cameras:

  * PowerShot A620,
  * PowerShot S80,
  * PowerShot S3 IS
  * PowerShot G7
  * PowerShot A640
  * PowerShot S5 IS
  * PowerShot G9
  * PowerShot SX100 IS
  * PowerShot G10
  * PowerShot SX110 IS

You can get detailed info [here](http://www.gphoto.org/doc/remote/).

You can adapt the code easily to work on Canon EOS cams and some Nikon ones, due ArduCam board is compatible with [Oleg's PTP library](http://www.circuitsathome.com/camera-control/generic-ptp-control-of-digital-cameras).

By other hand, there is a [PTP hacking extension](http://chdk.wikia.com/wiki/PTP_Extension) in course at CHDK project.
The ArduCam project's goal is use that nice resource on future, for extending the PTP control to other newer Canon models, which are small and light.