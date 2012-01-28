#define on 1
#define off 0

/*Enabling disabling Panels Switches*/
//Not working yet!!! Just here to remember:

int swBat = on;
int swCam = off;
int swDir = off;
int swGPS = on;
int swAlt = off;
int swTim = off;
int swDis = off;

/*Panels variables*/
//Will come from APM telem port

float bat_val = 12.05; //current voltage
float bat_cel = 3; //number of cells
float lat = 34.178851; //latidude
float lon = -118.501655; //longitude
float hom_dis = 0; //distance from home <-------- !!! (probably must be calculated here)
float head = 170.0; //heading angle = compass
float alt = 0; //altitude <-------- !!! ( Need to know the default unit meters foots?)
float vel = 0; //velocity <-------- !!! ( Need to know the default unit meters/sec kmeters/h milles/h?)
int   num_sat = 3; //number of satelites
int   gps_lock = 1; //GPS lock... need verify if is boolean or not <--------- !!! ( Remember!!! Very important on startup time!!!)


