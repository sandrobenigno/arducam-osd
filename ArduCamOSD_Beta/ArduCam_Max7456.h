#ifndef ArduCam_Max7456_h
#define ArduCam_Max7456_h

/******* FROM DATASHEET *******/

//#define isPAL
#define MAX7456_SELECT 6//SS
#define MAX7456_VSYNC 2//INT0

#ifdef isPAL
  #define MAX7456_MODE 0x40 //PAL mask 10000000
#else
  #define MAX7456_MODE 0x00 //NTSC mask 00000000 ("|" will do nothing)
#endif

//MAX7456 reg write addresses
#define MAX7456_VM0_reg   0x00
#define MAX7456_VM1_reg   0x01
#define MAX7456_DMM_reg   0x04
#define MAX7456_DMAH_reg  0x05
#define MAX7456_DMAL_reg  0x06
#define MAX7456_DMDI_reg  0x07
#define MAX7456_OSDM_reg  0x0c //not used. Is to set mix

//MAX7456 reg write addresses to recording NVM process
#define MAX7456_CMM_reg   0x08
#define MAX7456_CMAH_reg  0x09
#define MAX7456_CMAL_reg  0x0a
#define MAX7456_CMDI_reg  0x0b
#define MAX7456_STAT_reg  0xa0 //0xa[X]

//DMM commands
#define MAX7456_CLEAR_display 0x04
#define MAX7456_CLEAR_display_vert 0x06

#define MAX7456_END_string 0xff

//VM0 commands mixed with mode NTSC or PAL mode
#define MAX7456_ENABLE_display (0x08 | MAX7456_MODE) //Don't used. Bad sync. 00001000
#define MAX7456_ENABLE_display_vert (0x0c | MAX7456_MODE) //Much better. Good sync 00001100
#define MAX7456_reset (0x02 | MAX7456_MODE)
#define MAX7456_DISABLE_display (0x00 | MAX7456_MODE)
//VMO command modifiers
#define MAX7456_SYNC_autosync 0x10
#define MAX7456_SYNC_internal 0x30
#define MAX7456_SYNC_external 0x20

#define MAX7456_WHITE_level_80 0x03
#define MAX7456_WHITE_level_90 0x02
#define MAX7456_WHITE_level_100 0x01
#define MAX7456_WHITE_level_120 0x00

//If PAL
#ifdef isPAL
  #define MAX7456_screen_size 480
  #define MAX7456_screen_rows 15
#else
  #define MAX7456_screen_size 390
  #define MAX7456_screen_rows 13
#endif

//------------------ the OSD class -----------------------------------------------

class OSD: public BetterStream
{
  public:
    OSD(void);
    void init(void);
    void clear(void);
    void plug(void);
    void setPanel(int start_col, int start_row);
    void openPanel(void);
    void closePanel(void);
    virtual int     available(void);
    virtual int     read(void);
    virtual int     peek(void);
    virtual void    flush(void);
    virtual void write(uint8_t c);
    using BetterStream::write;
  private:
    int start_col, start_row, col, row;
};

#endif
