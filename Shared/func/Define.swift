//--------------------------------------------------------------------------------//
// @file  Define.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI
                      
//----------------------------------------------------------------//
//  bool
//----------------------------------------------------------------//
let TRUE  : Bool  = true
let FALSE : Bool  = false

//----------------------------------------------------------------//
//  UUID IDENTIFIER
//----------------------------------------------------------------//
let UUID_VS_SERVICE                 : String                      = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
let UUID_VS_SERVICE_CHAR_TX         : String                      = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"; //< Host TX, slave RX
let UUID_VS_SERVICE_CHAR_RX         : String                      = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"; //< Host RX, slave TX
let UUID_VS_SERVICE_CHAR_REGTX      : String                      = "6E400008-B5A3-F393-E0A9-E50E24DCCA9E";
let UUID_VS_SERVICE_CHAR_REGRX      : String                      = "6E400009-B5A3-F393-E0A9-E50E24DCCA9E";

let UUID_BATT_SERVICE               : String                      = "0000180F-0000-1000-8000-00805f9b34fb";
let UUID_BATT_SERVICE_CHAR_LEVEL    : String                      = "00002a19-0000-1000-8000-00805f9b34fb";


let UUID_MAC_ADDR_SERVICE :String                                 = "180A";
let UUID_MAC_ADDR_SERVICE_CHAR_READ :String                       = "F7BF3564-FB6D-4E53-88A4-5E37E0326063";


//----------------------------------------------------------------//
//  SYSTEM CONTROL2
//----------------------------------------------------------------//
let SYS_CTL2_TASK_EVT         : UInt32          = (1<<0)    //< dwTimerMS = 000
let SYS_CTL2_SEC_EVT          : UInt32          = (1<<1)    //< dwTimerMS = 000
let SYS_CTL2_000MS_EVT        : UInt32          = (1<<1)    //< dwTimerMS = 000
let SYS_CTL2_100MS_EVT        : UInt32          = (1<<2)    //< dwTimerMS = 100
let SYS_CTL2_200MS_EVT        : UInt32          = (1<<3)    //< dwTimerMS = 200
let SYS_CTL2_300MS_EVT        : UInt32          = (1<<4)    //< dwTimerMS = 300
let SYS_CTL2_400MS_EVT        : UInt32          = (1<<5)    //< dwTimerMS = 400
let SYS_CTL2_500MS_EVT        : UInt32          = (1<<6)    //< dwTimerMS = 500
let SYS_CTL2_600MS_EVT        : UInt32          = (1<<7)    //< dwTimerMS = 600
let SYS_CTL2_700MS_EVT        : UInt32          = (1<<8)    //< dwTimerMS = 700
let SYS_CTL2_800MS_EVT        : UInt32          = (1<<9)    //< dwTimerMS = 800
let SYS_CTL2_900MS_EVT        : UInt32          = (1<<10)   //< dwTimerMS = 900
let SYS_CTL2_TIMER_50MS_EVT   : UInt32          = (1<<11)
let SYS_CTL2_TIMER_100MS_EVT  : UInt32          = (1<<12)   //< TIMER_100, dwTimerMS = 000/100/200/300/400/500/600/700/800/900
let SYS_CTL2_TIMER_200MS_EVT  : UInt32          = (1<<13)   //< TIMER_200, dwTimerMS = 000/200/400/600/800
let SYS_CTL2_TIMER_500MS_EVT  : UInt32          = (1<<14)   //< TIMER_400, dwTimerMS = 000/400/800

//----------------------------------------------------------------//
// BLE Init steps
//----------------------------------------------------------------//
let BLE_INIT_STEP0 : Int  =  (0)
let BLE_INIT_STEP1 : Int  =  (1)
let BLE_INIT_STEP2 : Int  =  (2)
let BLE_INIT_STEP3 : Int  =  (3)
let BLE_INIT_STEP4 : Int  =  (4)
let BLE_INIT_STEP5 : Int  =  (5)
let BLE_INIT_STEP6 : Int  =  (6)
let BLE_INIT_STEP7 : Int  =  (7)
let BLE_INIT_STEP8 : Int  =  (8)
let BLE_INIT_STEP_FINISH : Int = (BLE_INIT_STEP8)

//----------------------------------------------------------------//
// ADDITIONS
//----------------------------------------------------------------//
let MARKER_TYPE_TRIGGER                 : Int   = (100)
let MARKER_TYPE_ADDITION                : Int   = (200)
let MARKER_TYPE_ADDITION_AF_HR_MAX      : Int   = (201)
let MARKER_TYPE_ADDITION_AF_HR_MIN      : Int   = (202)
let MARKER_TYPE_ADDITION_SVT            : Int   = (203)
let MARKER_TYPE_ADDITION_VT             : Int   = (204)
let MARKER_TYPE_ADDITION_BLOCK          : Int   = (205)
let MARKER_TYPE_ADDITION_SINUS_HR_MAX   : Int   = (206)
let MARKER_TYPE_ADDITION_SINUS_HR_MIN   : Int   = (207)
let MARKER_TYPE_ADDITION_ECTOPIC        : Int   = (208)
let MARKER_TYPE_ADDITION_PAUSE          : Int   = (209)
let MARKER_TYPE_ADDITION_BRADY          : Int   = (210)
let MARKER_TYPE_ADDITION_TACHY          : Int   = (211)
let MARKER_TYPE_ADDITION_TRIGGER        : Int   = (212)
let MARKER_TYPE_ADDITION_ADDITION       : Int   = (213)

//----------------------------------------------------------------//
//  VIEW_ID
//----------------------------------------------------------------//
let VIEW_ID_LAUNCH                                  : Int = 0

let VIEW_ID_LOGIN                                   : Int = 1
let VIEW_ID_WEB_PIN_CODE                            : Int = 2
let VIEW_ID_REGISTER                                : Int = 3
let VIEW_ID_FORGOT_PASSWORD                         : Int = 4

let VIEW_ID_PATIENT_LIST                            : Int = 6

let VIEW_ID_ENTRY                                   : Int = 8
let VIEW_ID_SCAN                                    : Int = 9
let VIEW_ID_ABOUT                                   : Int = 16
let VIEW_ID_CONNECTING                              : Int = 17
let VIEW_ID_AUTO_CONNECTING                         : Int = 18
let VIEW_ID_MEASUREMENT                             : Int = 19
let VIEW_ID_STATISTICS                              : Int = 20
let VIEW_ID_CONFIG                                  : Int = 22

//----------------------------------------------------------------//
// 
// SCREEN WIDTH TYPE
//
//----------------------------------------------------------------//

//----------------------------------------------------------------//
// SCREEN
//----------------------------------------------------------------//
let SCREEN_WIDTH_SMALL                              : CGFloat    = 420
let SCREEN_WIDTH_MIDDLE                             : CGFloat    = 640  
let SCREEN_WIDTH_BIG                                : CGFloat    = 1024
let SCREEN_WIDTH_LARGE                              : CGFloat    = 2048

let SCREEN_WIDTH_TYPE_UNKNOWN                       : Int       = 0
let SCREEN_WIDTH_TYPE_SMALL                         : Int       = 1
let SCREEN_WIDTH_TYPE_MIDDLE                        : Int       = 2
let SCREEN_WIDTH_TYPE_BIG                           : Int       = 3
let SCREEN_WIDTH_TYPE_LARGE                         : Int       = 4

//----------------------------------------------------------------//
//  CHART
//----------------------------------------------------------------//
let CHART_RUN_DIR_FORWARD  : Bool = TRUE
let CHART_RUN_DIR_BACKWARD : Bool = FALSE

//----------------------------------------------------------------//
//  BLE 
//----------------------------------------------------------------//
let BLE_MAX_MTU : Int = 150

//---------------------------------------------------------------//
// BLE_STATE
//---------------------------------------------------------------//
let BLE_STATE_CLOSE                     : Int = (0)
let BLE_STATE_WAIT                      : Int = (1)
let BLE_STATE_CONNECT_INIT              : Int = (2)
let BLE_STATE_CONNECTED                 : Int = (3)
let BLE_STATE_DISCONNECTED              : Int = (4)
let BLE_STATE_AUTO_CONNECT              : Int = (5)
let BLE_STATE_BIT_MODE                  : Int = (6)
let BLE_STATE_NOTIFY_MODE1              : Int = (7)
let BLE_STATE_NOTIFY_MODE2              : Int = (8)
let BLE_STATE_RECONNECT                 : Int = (9)

let BLE_STATE_VSC_MODE_INIT             : Int = (20)
let BLE_STATE_VSC_MODE                  : Int = (21)
let BLE_STATE_VSC_MODE_QUEUE_FULL       : Int = (22)
let BLE_STATE_VSC_MODE_END              : Int = (23)
let BLE_STATE_VSC_FILE_MODE_INIT        : Int = (24)
let BLE_STATE_VSC_FILE_MODE             : Int = (25)
let BLE_STATE_VSC_FILE_MODE_QUEUE_FULL  : Int = (26)
let BLE_STATE_VSC_FILE_MODE_END         : Int = (27)

//---------------------------------------------------------------//
// VSC_MODE_INIT_STEP
//---------------------------------------------------------------//
public let VSC_MODE_INIT_STEP0  : Int  = 0 //< DO VSC_MODE_TYPE_SET
public let VSC_MODE_INIT_STEP1  : Int  = 1 //< WAIT VSC_MODE_TYPE_SET DONE
public let VSC_MODE_INIT_STEP2  : Int  = 2 //< VSC_MODE_TYPE_SET DONE, DO VSC_MODE_START
public let VSC_MODE_INIT_STEP3  : Int  = 3 //< WAIT_VSC_START_DONE
public let VSC_MODE_INIT_STEP4  : Int  = 4 //< VSC_MODE_START_DONE goto VSC_MODE
public let VSC_MODE_INIT_STEP5  : Int  = 5 //< DO VSC_MODE_STOP
public let VSC_MODE_INIT_STEP6  : Int  = 6 //< WAIT_VSC_START_DONE
public let VSC_MODE_INIT_STEP7  : Int  = 7 //< VSC_MODE_STop_DONE goto STEP0

//---------------------------------------------------------------//
// DATA SET
//---------------------------------------------------------------//
public let   DATASET_DS0  : Int     = (0)
public let   DATASET_DS1  : Int     = (1)
public let   DATASET_DS2  : Int     = (2)
public let   DATASET_DS3  : Int     = (3)
public let   DATASET_DS4  : Int     = (4)
public let   DATASET_DS5  : Int     = (5)
public let   DATASET_DS6  : Int     = (6)
public let   DATASET_DS7  : Int     = (7)
public let   DATASET_DS8  : Int     = (8)

public let   DATASET_DS9  : Int     = (9)     //< report
public let   DATASET_DS10 : Int     = (10)
public let   DATASET_DS11 : Int     = (11)
public let   DATASET_DS12 : Int     = (12)
public let   DATASET_DS13 : Int     = (13)
public let   DATASET_DS14 : Int     = (14)
public let   DATASET_DS15 : Int     = (15)
public let   DATASET_DS16 : Int     = (16)
public let   DATASET_DS17 : Int     = (17)
public let   DATASET_DS18 : Int     = (18)
public let   DATASET_DS19 : Int     = (19)
public let   DATASET_DS20 : Int     = (20)
public let   DATASET_DS21 : Int     = (21)
public let   DATASET_DS22 : Int     = (22)
public let   DATASET_DS23 : Int     = (23)
public let   DATASET_DS24 : Int     = (24)
public let   DATASET_DS25 : Int     = (25)
public let   DATASET_DS26 : Int     = (26)
public let   DATASET_DS27 : Int     = (27)
public let   DATASET_DS28 : Int     = (28)
public let   DATASET_DS29 : Int     = (29)
public let   DATASET_DS30 : Int     = (30)
public let   DATASET_DS31 : Int     = (31)
public let   DATASET_DS32 : Int     = (32)
public let   DATASET_DS33 : Int     = (33)
public let   DATASET_DS34 : Int     = (34)
public let   DATASET_DS35 : Int     = (35)
public let   DATASET_DS36 : Int     = (36)
public let   DATASET_DS37 : Int     = (37)
public let   DATASET_DS38 : Int     = (38)
public let   DATASET_DS39 : Int     = (39)
public let   DATASET_COUNT : Int    = (40)

public let   DATASET_LOAD_ECG_DS0      : Int   = (DATASET_DS0)
public let   DATASET_LOAD_ECG_DS1      : Int   = (DATASET_DS1)
public let   DATASET_LOAD_ECG_DS2      : Int   = (DATASET_DS2)

public let   DATASET_MONITOR_ECG_DS0   : Int   = (DATASET_DS3)
public let   DATASET_MONITOR_ECG_DS1   : Int   = (DATASET_DS4)
public let   DATASET_MONITOR_ECG_DS2   : Int   = (DATASET_DS5)

public let   DATASET_MONITOR_GSENSOR_X : Int   = (DATASET_DS6)
public let   DATASET_MONITOR_GSENSOR_Y : Int   = (DATASET_DS7)
public let   DATASET_MONITOR_GSENSOR_Z : Int   = (DATASET_DS8)

public let   DATASET_REPORT_ECG0       : Int   = (DATASET_DS9)    //< REPORT_CHART_ID_SETUP
public let   DATASET_REPORT_ECG1       : Int   = (DATASET_DS10)   //< REPORT_CHART_ID_AF_HR_MIN
public let   DATASET_REPORT_ECG2       : Int   = (DATASET_DS11)   //< REPORT_CHART_ID_AF_HR_MAX
public let   DATASET_REPORT_ECG3       : Int   = (DATASET_DS12)   //< REPORT_CHART_ID_SVT
public let   DATASET_REPORT_ECG4       : Int   = (DATASET_DS13)   //< REPORT_CHART_ID_VT
public let   DATASET_REPORT_ECG5       : Int   = (DATASET_DS14)   //< REPORT_CHART_ID_BLOCK
public let   DATASET_REPORT_ECG6       : Int   = (DATASET_DS15)   //< REPORT_CHART_ID_SINUS_HR_MIN
public let   DATASET_REPORT_ECG7       : Int   = (DATASET_DS16)   //< REPORT_CHART_ID_SINUS_HR_MAX
public let   DATASET_REPORT_ECG8       : Int   = (DATASET_DS17)   //< REPORT_CHART_ID_ECTOPIC_ISOLATED
public let   DATASET_REPORT_ECG9       : Int   = (DATASET_DS18)   //< REPORT_CHART_ID_ECTOPIC_COUPLET
public let   DATASET_REPORT_ECG10      : Int   = (DATASET_DS19)   //< REPORT_CHART_ID_ECTOPIC_TRIPLET
public let   DATASET_REPORT_ECG11      : Int   = (DATASET_DS20)   //< REPORT_CHART_ID_ECTOPIC_MULTIPLE
public let   DATASET_REPORT_ECG12      : Int   = (DATASET_DS21)   //< REPORT_CHART_ID_PAUSE
public let   DATASET_REPORT_ECG13      : Int   = (DATASET_DS22)   //< REPORT_CHART_ID_BRADY
public let   DATASET_REPORT_ECG14      : Int   = (DATASET_DS23)   //< REPORT_CHART_ID_TACHY
public let   DATASET_REPORT_ECG15      : Int   = (DATASET_DS24)   //< REPORT_CHART_ID_TRIGGER_1
public let   DATASET_REPORT_ECG16      : Int   = (DATASET_DS25)   //< REPORT_CHART_ID_TRIGGER_2
public let   DATASET_REPORT_ECG17      : Int   = (DATASET_DS26)   //< REPORT_CHART_ID_TRIGGER_3
public let   DATASET_REPORT_ECG18      : Int   = (DATASET_DS27)   //< REPORT_CHART_ID_TRIGGER_4
public let   DATASET_REPORT_ECG19      : Int   = (DATASET_DS28)   //< REPORT_CHART_ID_ADDITION_1
public let   DATASET_REPORT_ECG20      : Int   = (DATASET_DS29)   //< REPORT_CHART_ID_ADDITION_2
public let   DATASET_REPORT_ECG21      : Int   = (DATASET_DS30)   //< REPORT_CHART_ID_ADDITION_3
public let   DATASET_REPORT_ECG22      : Int   = (DATASET_DS31)   //< REPORT_CHART_ID_ADDITION_4
public let   DATASET_REPORT_ECG23      : Int   = (DATASET_DS32)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_0
public let   DATASET_REPORT_ECG24      : Int   = (DATASET_DS33)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_1
public let   DATASET_REPORT_ECG25      : Int   = (DATASET_DS34)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_2
public let   DATASET_REPORT_ECG26      : Int   = (DATASET_DS35)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_3
public let   DATASET_REPORT_ECG27      : Int   = (DATASET_DS36)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_4
public let   DATASET_REPORT_ECG28      : Int   = (DATASET_DS37)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_5
public let   DATASET_REPORT_ECG29      : Int   = (DATASET_DS38)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_6
public let   DATASET_REPORT_ECG30      : Int   = (DATASET_DS39)   //< REPORT_CHART_ID_AF_HR_MAX_MULTI_7

//--------------------------------------------------------------------------------------------------------//
// APP FONT DEFAULT
//--------------------------------------------------------------------------------------------------------//
public let  APP_FONT_NAME   : String     = "Roboto"

//--------------------------------------------------------------------------------------------------------//
// APP FONT SIZE
//--------------------------------------------------------------------------------------------------------//
public let  APP_FONT_SIZE_XXS   : CGFloat     = 10
public let  APP_FONT_SIZE_XS    : CGFloat     = 12
public let  APP_FONT_SIZE_S     : CGFloat     = 14
public let  APP_FONT_SIZE_M     : CGFloat     = 16
public let  APP_FONT_SIZE_L     : CGFloat     = 18
public let  APP_FONT_SIZE_XL    : CGFloat     = 20
public let  APP_FONT_SIZE_XXL   : CGFloat     = 24

//--------------------------------------------------------------------------------------------------------//
// APP FONT SIZE
//--------------------------------------------------------------------------------------------------------//
public let  AUTO_CONNECT_STATE_INIT    : Int  = 0
public let  AUTO_CONNECT_STATE_SCAN    : Int  = 1
public let  AUTO_CONNECT_STATE_CONNECT : Int  = 2

//----------------------------------------------------------------//
//  ECG Display Range
//----------------------------------------------------------------//
public let ECG_DISPLAY_RANGE_2P5MM_MV      : Int = 0  //<    2.5 mm/mV, 24mV,   +/- 12.0  mv 
public let ECG_DISPLAY_RANGE_5MM_MV        : Int = 1  //<    5   mm/mV, 12mV,   +/-  6.0  mV
public let ECG_DISPLAY_RANGE_10MM_MV       : Int = 2  //<   10   mm/mV,  6mV,   +/-  3.0  mV, (2 cells, default) 
public let ECG_DISPLAY_RANGE_20MM_MV       : Int = 3  //<   20   mm/mV,  3mV,   +/-  1.5, mV
public let ECG_DISPLAY_RANGE_40MM_MV       : Int = 4  //<   40   mm/mV,  1.5mV, +/-  0.75 mV

public let ECG_DISPLAY_RANGE_LABEL_ARR : [String] = [
  "2.5mm/mV",     //< ECG_DISPLAY_RANGE_2P5MM_MV
  "5mm/mV",       //< ECG_DISPLAY_RANGE_5MM_MV
  "10mm/mV",      //< ECG_DISPLAY_RANGE_10MM_MV
  "20mm/mV",      //< ECG_DISPLAY_RANGE_20MM_MV
  "40mm/mV"       //< ECG_DISPLAY_RANGE_40MM_MV
]

//------------------------------------------------------------//
// Mass Production check active key
//------------------------------------------------------------//
public let MASS_PRODUCTION_INVALID_VALUE  : Int = 10000

//------------------------------------------------------------//
// BLE Pin Code
//------------------------------------------------------------//
public let PIN_CODE_CHALLENGE_NULL_FLAG   : Int = 0
public let PIN_CODE_CHALLENGE_ENABLE_FLAG : Int = 1
public let PIN_CODE_CHALLENGE_FAIL_FLAG   : Int = 2
public let PIN_CODE_CHALLENGE_MAX_CNT     : Int = 3
public let PIN_CODE_ENABLE_FLAG           : Int = 4  ///< fix the default ui switch
public let PIN_CODE_CHANGE_FLAG           : Int = 5

//----------------------------------------------------------------//
//  Queue Stage
//----------------------------------------------------------------//
public let QUEUE_STAGE_INIT               : Int = 1
public let QUEUE_ACCESS_WAIT              : Int = 2

//----------------------------------------------------------------//
// Measurement Period
//----------------------------------------------------------------//
public let MEASUREMENT_PERIOD_CONTINUE    : Int = 0
public let MEASUREMENT_PERIOD_6_MIN       : Int = 360
public let MEASUREMENT_PERIOD_1_HOUR      : Int = 3600
public let MEASUREMENT_PERIOD_24_HOUR     : Int = (3600 * 24)
public let MEASUREMENT_PERIOD_48_HOUR     : Int = (3600 * 48)

//----------------------------------------------------------------//
// ATR Bypass unreadable stage
//----------------------------------------------------------------//
public let ATR_UNREADABLE_NULL_STAGE      : Int = 0
public let ATR_UNREADABLE_START_STAGE     : Int = 1
public let ATR_UNREADABLE_END_STAGE       : Int = 2
public let ATR_UNREADABLE_BYPASS_STAGE    : Int = 3
