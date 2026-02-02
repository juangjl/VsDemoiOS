//--------------------------------------------------------------------------------
// @file  VscModeCtl.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

public let  VSC_MODE_TYPE0                        =  (0)
public let  VSC_MODE_TYPE1                        =  (1)

//-------------------------------------------------------------------------------//
// Command Group
//-------------------------------------------------------------------------------//
public let  VSC_MODE_INFO_TYPE                        =  (0)

public let  VSC_MODE_INFO_TYPE0_TIME_UTC              =  (1)
public let  VSC_MODE_INFO_TYPE0_TEMP_T                =  (2)
public let  VSC_MODE_INFO_TYPE0_ECG_HR                =  (3)
public let  VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF          =  (4)
public let  VSC_MODE_INFO_TYPE0_GSEN_X                =  (5)
public let  VSC_MODE_INFO_TYPE0_GSEN_Y                =  (6)
public let  VSC_MODE_INFO_TYPE0_GSEN_Z                =  (7)
public let  VSC_MODE_INFO_TYPE0_BATT_SOC              =  (8)
public let  VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC        =  (9)
public let  VSC_MODE_INFO_TYPE0_HRV_SDNN              =  (10)
public let  VSC_MODE_INFO_TYPE0_HRV_NN50              =  (11)
public let  VSC_MODE_INFO_TYPE0_HRV_RMSSD             =  (12)
public let  VSC_MODE_INFO_TYPE0_HRV_RR                =  (13)
public let  VSC_MODE_INFO_TYPE0_HRV_VLF               =  (14)
public let  VSC_MODE_INFO_TYPE0_HRV_LF                =  (15)
public let  VSC_MODE_INFO_TYPE0_HRV_HF                =  (16)

public let  VSC_MODE_INFO_TYPE0_BAR                   =  (17)
public let  VSC_MODE_INFO_TYPE0_BAR_TEMP              =  (18)

public let  VSC_MODE_INFO_TYPE0_GSEN_DATA0            =  (19) //< GS_X0 |  GS_Y0
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA1            =  (20) //< GS_Z0 |  GS_X1
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA2            =  (21) //< GS_Y1 |  GS_Z1
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA3            =  (22) //< GS_X2 |  GS_Y2
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA4            =  (23) //< GS_Z2 |  GS_X3
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA5            =  (24) //< GS_Y3 |  GS_Z3
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA6            =  (25) //< GS_X4 |  GS_Y4
public let  VSC_MODE_INFO_TYPE0_GSEN_DATA7            =  (26) //< GS_Z4 |  --

public let  VSC_MODE_INFO_TYPE0_ATR                   =  (27) //< ATR CODE
public let  VSC_MODE_INFO_TYPE0_ATR_TIME              =  (28) //< ATR TIME

public let  VSC_MODE_INFO_TYPE0_VSC_START_UTC         =  (29) //< Start time in seconds since 1970
public let  VSC_MODE_INFO_TYPE0_VSC_RUN_TIME          =  (30) //< Run time in seconds

public let  VSC_MODE_INFO_TYPE0_GSEN_POWER            =  (31) //< G-Sensor power


public let  VSC_MODE_IDX_INVALID                      = (8000)
public let  VSC_MODE_IDX_MAX                          = (1000)

public let  VSC_MODE_CHANNEL_COUNT                    = (2)
public let  VSC_MODE_CHANNEL_DATA_COUNT               = (100)  //< 200ms @ 500 hz =  100
public let  VSC_MODE_GSENSOR_DATA_COUNT               = (5)    //< 200ms @ 25  hz =  5


class VscModeCtlType : NSObject
{
  //----------------------------------------------------//
  // In data packet 65 bytes
  //----------------------------------------------------//
  var    wId : UInt16 = 0  
  var    iChannelCount : Int32 = Int32(VSC_MODE_CHANNEL_COUNT)
      
  var    fValueCH : [[Float]]   =  [[Float]]()  //< JFLOAT   fValueCH[VSC_MODE_CHANNEL_COUNT][VSC_MODE_CHANNEL_DATA_COUNT];

  var    item : VscModeItemType = VscModeItemType()
    
  
  var    jtm : JTM  = JTM()         //< 0 :
  var    dwUTC      : UInt32   = 0 //< 1 :
  var    fTemp      : Float    = 0 //< 2 :
  var    fHRNow     : Float    = 0 //< 3 :
  var    fLeadOff   : Float    = 0 //< 4 :
  var    fGsenXNow  : Float    = 0 //< 5 :
  var    fGsenYNow  : Float    = 0 //< 6 :
  var    fGsenZNow  : Float    = 0 //< 7 :
  var    fBattSoc   : Float    = 0 //< 8 :
  var    fBattTotalSec: Float  = 0 //< 9 :
  var    fHrvSDNN   : Float    = 0 //< 10 :
  var    fHrvNN50   : Float    = 0 //< 11 :
  var    fHrvRMSSD  : Float    = 0 //< 12 :
  var    fHrvRR     : Float    = 0 //< 13 :

  var    fHrvVLF    : Float    = 0 //< 14 :
  var    fHrvLF     : Float    = 0 //< 15 :
  var    fHrvHF     : Float    = 0 //< 16 :
    
  var    fHrvLFHF   : Float    = 0 //<
  var    fHrvTP     : Float    = 0 //<
  var    fHrvLFTP   : Float    = 0 //<
  var    fHrvHFTP   : Float    = 0 //<

  var    fBar       : Float    = 0 //< 17 :
  var    fBarTemp   : Float    = 0 //< 18 :

  var    sGSenX : [Int16]        = [Int16]()  //< 19~26 : sGSenX[5]
  var    sGSenY : [Int16]        = [Int16]()  //< 19~26 : sGSenY[5]
  var    sGSenZ : [Int16]        = [Int16]()  //< 19~26 : sGSenZ[5]

  var    atrNow :JAtrType      = JAtrType()      //< 27~28 :
  var    dwVscStartUtc  : UInt32   = 0  //< 29 : Start UTC
  var    fVscRunTimeSec : Float    = 0  //< 30 : Run Time
  var    fGsenPower     : Float    = 0  //< 31 :

  // VSC FILE MODE
  var    iVscFileEnableStatus  : Int32  = 0
  var    iVscFileModeIndex     : UInt32 = 0
  var    dwVscFileModeRunSec   : UInt32 = 0
  var    dwVscFileModeLastUTC  : UInt32 = 0
  var    iVscFileModeLastIndex : Int32  = 0
  var    iVscFileModeStartFlag : Int32  = 0
  
  override init()
  {
    super.init()
    
    self.fValueCH    = Array(repeating: [Float](),  count: VSC_MODE_CHANNEL_COUNT)
    self.fValueCH[0] = Array(repeating: Float(),    count: VSC_MODE_CHANNEL_DATA_COUNT)
    self.fValueCH[1] = Array(repeating: Float(),    count: VSC_MODE_CHANNEL_DATA_COUNT)
    
    self.sGSenX      =  Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
    self.sGSenY      =  Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
    self.sGSenZ      =  Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
  }
  
  deinit
  {
    self.fValueCH[0] = [Float]()
    self.fValueCH[1] = [Float]()
    self.fValueCH    = [[Float]]()
    
    self.sGSenX = [Int16]()
    self.sGSenY = [Int16]()
    self.sGSenZ = [Int16]()
    
    self.item.Clear()
  }
  
  func VscModeType0EcgDataParse()
  {
    var iCnt : Int = 0
    var idx  : Int = 0
    var fVal : Float = 0
    

    iCnt = VSC_MODE_ITEM_DATA_SIZE / 4 / Int(self.iChannelCount);

    self.fValueCH[0] = [Float]()
    self.fValueCH[1] = [Float]()
    
    for _ in 0..<iCnt
    {
      for iCH in 0..<self.iChannelCount
      {
        let subArr = Array(self.item.bData[idx...(idx + 3)])
        memcpy(&fVal, subArr, 4)
        let fValNew : Float = Float(fVal)
        self.fValueCH[Int(iCH)].append(fValNew);
        idx = idx + 4;
      }
    }
  }
  
  func VscModeType1EcgDataParse()
  {
    var iCnt : Int = 0;
    var idx  : Int = 0;
    var fVal : Float = 0;
    
    iCnt = VSC_MODE_TYPE1_DATA_SIZE / 4
    
    self.fValueCH[0] = [Float]()
    self.fValueCH[1] = [Float]()
    
    for _ in 0..<iCnt
    {
      let subArr = Array(self.item.bData[idx...(idx + 3)])
      memcpy(&fVal, subArr, 4)
      let fValNew : Float = Float(fVal)
      self.fValueCH[0].append(fValNew);
      self.fValueCH[1].append(fValNew);
      idx = idx + 4;
    }
  }
    
  func VscModeInit()
  {    
    // Allocate new data
    self.fValueCH    = Array(repeating: [Float](),  count: VSC_MODE_CHANNEL_COUNT)
    self.fValueCH[0] = Array(repeating: Float(),  count: VSC_MODE_CHANNEL_DATA_COUNT)
    self.fValueCH[1] = Array(repeating: Float(),  count: VSC_MODE_CHANNEL_DATA_COUNT)
    
    self.sGSenX = Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
    self.sGSenY = Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
    self.sGSenZ = Array(repeating: Int16(), count: VSC_MODE_GSENSOR_DATA_COUNT)
    
    self.atrNow = JAtrType()
    
    // ID init
    self.wId = 0
    self.iChannelCount = Int32(VSC_MODE_CHANNEL_COUNT)
  }
  
  func VscModeInfoPrint()
  {
    var msg: String = ""
    var idx: Int = 0
        
    // VSC_MODE_INFO_TYPE0_TEMP_T                  (2)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: TEMP = %0.2f oC \n", idx, self.fTemp)
    
    // VSC_MODE_INFO_TYPE0_ECG_HR                  (3)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HR_NOW = %0.1f BPM \n", idx, self.fHRNow)
    
    // VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF            (4)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: LEAD_OFF = %0.0f \n", idx, self.fLeadOff)
    
    // VSC_MODE_INFO_TYPE0_GSEN_X                  (5)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSEN_X_NOW = %0.0f \n",  idx, self.fGsenXNow)
    
    // VSC_MODE_INFO_TYPE0_GSEN_Y                  (6)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSEN_Y_NOW = %0.0f \n",  idx, self.fGsenYNow)
    
    // VSC_MODE_INFO_TYPE0_GSEN_Z                  (7)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSEN_Z_NOW = %0.0f \n",  idx, self.fGsenZNow)

    // VSC_MODE_INFO_TYPE0_BATT_SOC                (8)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: BATT_SOC = %0.0f \n", idx, self.fBattSoc)
    
    // VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC          (9)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: BATT_TOTAL_SEC = %0.0f sec \n", idx, self.fBattTotalSec)
    
    // VSC_MODE_INFO_TYPE0_HRV_SDNN                (10)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_SDNN = %0.0f \n", idx, self.fHrvSDNN)
    
    // VSC_MODE_INFO_TYPE0_HRV_NN50                (11)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_NN50 = %0.0f \n",  idx, self.fHrvNN50)
    
    // VSC_MODE_INFO_TYPE0_HRV_RMSSD                (12)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_RMSSD = %0.0f \n", idx, self.fHrvRMSSD)
    
    // VSC_MODE_INFO_TYPE0_HRV_RR                  (13)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_RR = %0.0f \n", idx, self.fHrvRR)
    
    // VSC_MODE_INFO_TYPE0_HRV_VLF                  (14)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_VLF = %0.0f \n", idx, self.fHrvVLF)
    
    // VSC_MODE_INFO_TYPE0_HRV_LF                  (15)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: HRV_LF = %0.0f \n", idx, self.fHrvLF)
    
    // VSC_MODE_INFO_TYPE0_HRV_HF                  (16)
    idx = idx + 1
    msg = msg +  String(format : "\t\t #%-3d: HRV_LF = %0.0f \n", idx, self.fHrvHF)

    // VSC_MODE_INFO_TYPE0_BAR                     (17)
    self.fBar = self.item.fInfo[VSC_MODE_INFO_TYPE0_BAR];
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: BAR = %0.0f \n", idx, self.fBar)

    // VSC_MODE_INFO_TYPE0_BAR_TEMP                (18)
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: BAR_TEMP = %0.2f oC\n", idx, self.fBarTemp)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA0              (19) //< GS_X0 |  GS_Y0
    // VSC_MODE_INFO_TYPE0_GSEN_DATA1              (20) //< GS_Z0 |  GS_X1
    // VSC_MODE_INFO_TYPE0_GSEN_DATA2              (21) //< GS_Y1 |  GS_Z1
    // VSC_MODE_INFO_TYPE0_GSEN_DATA3              (22) //< GS_X2 |  GS_Y2
    // VSC_MODE_INFO_TYPE0_GSEN_DATA4              (23) //< GS_Z2 |  GS_X3
    // VSC_MODE_INFO_TYPE0_GSEN_DATA5              (24) //< GS_Y3 |  GS_Z3
    // VSC_MODE_INFO_TYPE0_GSEN_DATA6              (25) //< GS_X4 |  GS_Y4
    // VSC_MODE_INFO_TYPE0_GSEN_DATA7              (26) //< GS_Z4 |  --
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSENX = ",  idx)
              + String(format : " %-4d ",    self.sGSenX[0])
              + String(format : " %-4d ",    self.sGSenX[1])
              + String(format : " %-4d ",    self.sGSenX[2])
              + String(format : " %-4d ",    self.sGSenX[3])
              + String(format : " %-4d \n",  self.sGSenX[4])
    
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSENY = ",  idx)
              + String(format : " %-4d ",    self.sGSenY[0])
              + String(format : " %-4d ",    self.sGSenY[1])
              + String(format : " %-4d ",    self.sGSenY[2])
              + String(format : " %-4d ",    self.sGSenY[3])
              + String(format : " %-4d \n",  self.sGSenY[4])
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSENZ = ",  idx)
              + String(format : " %-4d ",    self.sGSenZ[0])
              + String(format : " %-4d ",    self.sGSenZ[1])
              + String(format : " %-4d ",    self.sGSenZ[2])
              + String(format : " %-4d ",    self.sGSenZ[3])
              + String(format : " %-4d \n",  self.sGSenZ[4])

    // VSC_MODE_INFO_TYPE0_ATR                     (27) //< ATR  CODE
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: ATR = %-2d\n", idx,  self.atrNow.bAtr)
    
    // VSC_MODE_INFO_TYPE0_ATR_TIME                 (28) //< ATR_TIME
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: ATR_TIME = %d\n", idx,  self.atrNow.dwMS)
    
    // VSC_MODE_INFO_TYPE0_VSC_START_UTC             (29) //< VSC_START_UTC
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: VSC_START_UTC = %ld\n", idx,  self.dwVscStartUtc)
    
    // VSC_MODE_INFO_TYPE0_VSC_RUN_TIME             (30) //< VSC_RUN_TIME
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: VSC_RUN_TIME = %0.3f\n", idx,  self.fVscRunTimeSec)
    
    // VSC_MODE_INFO_TYPE0_GSEN_POWER               (31) //< GSEN_POWER
    idx = idx + 1
    msg = msg + String(format : "\t\t #%-3d: GSEN_POWER = %0.2f\n", idx,  self.fGsenPower)
    
    print(msg)
  }
  
  func VscModeInfoCopy(pVscMode : VscModeCtlType)
  {
    self.jtm.iYear        = pVscMode.jtm.iYear
    self.jtm.iMonth       = pVscMode.jtm.iMonth
    self.jtm.iDay         = pVscMode.jtm.iDay
    self.jtm.iHour        = pVscMode.jtm.iHour
    self.jtm.iMin         = pVscMode.jtm.iMin
    self.jtm.iSec         = pVscMode.jtm.iSec
    self.jtm.t            = pVscMode.jtm.t
    
    self.dwUTC            = pVscMode.dwUTC         //< 1 :
    self.fTemp            = pVscMode.fTemp         //< 2 :
    self.fHRNow           = pVscMode.fHRNow        //< 3 :
    self.fLeadOff         = pVscMode.fLeadOff      //< 4 :
    self.fGsenXNow        = pVscMode.fGsenXNow     //< 5 :
    self.fGsenYNow        = pVscMode.fGsenYNow     //< 6 :
    self.fGsenZNow        = pVscMode.fGsenZNow     //< 7 :
    self.fBattSoc         = pVscMode.fBattSoc      //< 8 :
    self.fBattTotalSec    = pVscMode.fBattTotalSec //< 9 :
    self.fHrvSDNN         = pVscMode.fHrvSDNN      //< 10 :
    self.fHrvNN50         = pVscMode.fHrvNN50      //< 11 :
    self.fHrvRMSSD        = pVscMode.fHrvRMSSD     //< 12 :
    self.fHrvRR           = pVscMode.fHrvRR        //< 13 :

    self.fHrvVLF          = pVscMode.fHrvVLF       //< 14 :
    self.fHrvLF           = pVscMode.fHrvLF        //< 15 :
    self.fHrvHF           = pVscMode.fHrvHF        //< 16 :
      
    self.fHrvLFHF         = pVscMode.fHrvLFHF      //< 16A:
    self.fHrvTP           = pVscMode.fHrvTP        //< 16B:
    self.fHrvLFTP         = pVscMode.fHrvLFTP      //< 16C:
    self.fHrvHFTP         = pVscMode.fHrvHFTP      //< 16D:

    self.fBar             = pVscMode.fBar          //< 17 :
    self.fBarTemp         = pVscMode.fBarTemp      //< 18 :

    self.sGSenX           = []  //< 19~26 : sGSenX[5]
    self.sGSenY           = []  //< 19~26 : sGSenY[5]
    self.sGSenZ           = []  //< 19~26 : sGSenZ[5]
    
    self.atrNow.bAtr      = pVscMode.atrNow.bAtr
    self.atrNow.dwMS      = pVscMode.atrNow.dwMS
    
    self.fGsenPower       = pVscMode.fGsenPower //< 31
  }
  
  func VscModeType0InfoParse()
  {
    var bDataArr : [UInt8]  = [UInt8]()
    var subArr0  : [UInt8]  = [UInt8]()
    var subArr1  : [UInt8]  = [UInt8]()
    
    var fVal : Float = 0
        
    // VSC_MODE_INFO_TYPE0_TIME_UTC                (1)
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_TIME_UTC]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    memcpy(&self.dwUTC, bDataArr, 4);
    
    self.jtm.t = UInt32(self.dwUTC)
       
    self.jtm.JTMLocalTimeGet(tNow: self.jtm.t)
          
    // VSC_MODE_INFO_TYPE0_TEMP_T                  (2)
    self.fTemp = self.item.fInfo[VSC_MODE_INFO_TYPE0_TEMP_T];
    
    // VSC_MODE_INFO_TYPE0_ECG_HR                  (3)
    self.fHRNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_ECG_HR];
    
    // VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF            (4)
    self.fLeadOff = self.item.fInfo[VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF];
    
    // VSC_MODE_INFO_TYPE0_GSEN_X                  (5)
    self.fGsenXNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_X];
    
    // VSC_MODE_INFO_TYPE0_GSEN_Y                  (6)
    self.fGsenYNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_Y];
    
    // VSC_MODE_INFO_TYPE0_GSEN_Z                  (7)
    self.fGsenZNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_Z];

    // VSC_MODE_INFO_TYPE0_BATT_SOC                (8)
    self.fBattSoc = self.item.fInfo[VSC_MODE_INFO_TYPE0_BATT_SOC];
    
    // VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC          (9)
    self.fBattTotalSec = self.item.fInfo[VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC];
    
    // VSC_MODE_INFO_TYPE0_HRV_SDNN                (10)
    self.fHrvSDNN = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_SDNN];
    
    // VSC_MODE_INFO_TYPE0_HRV_NN50                (11)
    self.fHrvNN50 = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_NN50];
    
    // VSC_MODE_INFO_TYPE0_HRV_RMSSD                (12)
    self.fHrvRMSSD = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_RMSSD];
    
    // VSC_MODE_INFO_TYPE0_HRV_RR                  (13)
    self.fHrvRR = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_RR];
    
    // VSC_MODE_INFO_TYPE0_HRV_VLF                  (14)
    self.fHrvVLF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_VLF];
    
    // VSC_MODE_INFO_TYPE0_HRV_LF                  (15)
    self.fHrvLF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_LF];
    
    // VSC_MODE_INFO_TYPE0_HRV_HF                  (16)
    self.fHrvHF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_HF];
    
    if(self.fHrvHF > 0)
    {
      self.fHrvLFHF = self.fHrvLF / self.fHrvHF
    }
    else
    {
      self.fHrvLFHF = 0
    }
    
    /// TP
    self.fHrvTP = self.fHrvVLF  + self.fHrvLF  + self.fHrvHF
    
    if(self.fHrvTP > 0)
    {
      self.fHrvLFTP = self.fHrvLF / self.fHrvTP
      self.fHrvHFTP = self.fHrvHF / self.fHrvTP
    }
    else
    {
      self.fHrvLFTP = 0
      self.fHrvHFTP = 0
    }

    // VSC_MODE_INFO_TYPE0_BAR                     (17)
    self.fBar = self.item.fInfo[VSC_MODE_INFO_TYPE0_BAR];

    // VSC_MODE_INFO_TYPE0_BAR_TEMP                (18)
    self.fBarTemp = self.item.fInfo[VSC_MODE_INFO_TYPE0_BAR_TEMP];

    // VSC_MODE_INFO_TYPE0_GSEN_DATA0              (19) //< GS_X0 |  GS_Y0
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA0]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[0], subArr0, 2)
    memcpy(&self.sGSenY[0], subArr1, 2)
        
    // VSC_MODE_INFO_TYPE0_GSEN_DATA1              (20) //< GS_Z0 |  GS_X1
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA1]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[0], subArr0, 2)
    memcpy(&self.sGSenX[1], subArr1, 2)
    
    // VSC_MODE_INFO_TYPE0_GSEN_DATA2              (21) //< GS_Y1 |  GS_Z1
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA2]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenY[1], subArr0, 2)
    memcpy(&self.sGSenZ[1], subArr1, 2)
    
    
    // VSC_MODE_INFO_TYPE0_GSEN_DATA3              (22) //< GS_X2 |  GS_Y2
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA3]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[2], subArr0, 2)
    memcpy(&self.sGSenY[2], subArr1, 2)
    
    // VSC_MODE_INFO_TYPE0_GSEN_DATA4              (23) //< GS_Z2 |  GS_X3
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA4]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[2], subArr0, 2)
    memcpy(&self.sGSenX[3], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA5              (24) //< GS_Y3 |  GS_Z3
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA5]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenY[3], subArr0, 2)
    memcpy(&self.sGSenZ[3], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA6              (25) //< GS_X4 |  GS_Y4
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA6]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[4], subArr0, 2)
    memcpy(&self.sGSenY[4], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA7              (26) //< GS_Z4 |  --
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA7]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[4], subArr0, 2)
    
    // VSC_MODE_INFO_TYPE0_ATR                     (27) //< ATR  CODE
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_ATR]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    self.atrNow.bAtr = bDataArr[0]
    
    // VSC_MODE_INFO_TYPE0_ATR_TIME                 (28) //< ATR_TIME
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_ATR_TIME]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    memcpy(&self.atrNow.dwMS, bDataArr, 4);
    
    // VSC_MODE_INFO_TYPE0_VSC_START_UTC            (29) //< start time in seconds since 1970
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_VSC_START_UTC]
    memcpy(&self.dwVscStartUtc, bDataArr, 4);
    
    // VSC_MODE_INFO_TYPE0_VSC_RUN_TIME             (30) //<  Run time in seconds
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_VSC_RUN_TIME]
    self.fVscRunTimeSec = fVal
    
    // VSC_MODE_INFO_TYPE0_GSEN_POWER               31) //<  G-Sensor power
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_POWER]
    self.fGsenPower = fVal
  }
  
  func VscModeType1InfoParse()
  {
    var bDataArr : [UInt8]  = [UInt8]()
    var subArr0  : [UInt8]  = [UInt8]()
    var subArr1  : [UInt8]  = [UInt8]()
    
    var fVal : Float = 0
        
    // VSC_MODE_INFO_TYPE0_TIME_UTC                (1)
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_TIME_UTC]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    memcpy(&self.dwUTC, bDataArr, 4);
    
    self.jtm.t = UInt32(self.dwUTC)
       
    self.jtm.JTMLocalTimeGet(tNow: self.jtm.t)
          
    // VSC_MODE_INFO_TYPE0_TEMP_T                  (2)
    self.fTemp = self.item.fInfo[VSC_MODE_INFO_TYPE0_TEMP_T];
    
    // VSC_MODE_INFO_TYPE0_ECG_HR                  (3)
    self.fHRNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_ECG_HR];
    
    // VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF            (4)
    self.fLeadOff = self.item.fInfo[VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF];
    
    // VSC_MODE_INFO_TYPE0_GSEN_X                  (5)
    self.fGsenXNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_X];
    
    // VSC_MODE_INFO_TYPE0_GSEN_Y                  (6)
    self.fGsenYNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_Y];
    
    // VSC_MODE_INFO_TYPE0_GSEN_Z                  (7)
    self.fGsenZNow = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_Z];

    // VSC_MODE_INFO_TYPE0_BATT_SOC                (8)
    self.fBattSoc = self.item.fInfo[VSC_MODE_INFO_TYPE0_BATT_SOC];
    
    // VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC          (9)
    self.fBattTotalSec = self.item.fInfo[VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC];
    
    // VSC_MODE_INFO_TYPE0_HRV_SDNN                (10)
    self.fHrvSDNN = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_SDNN];
    
    // VSC_MODE_INFO_TYPE0_HRV_NN50                (11)
    self.fHrvNN50 = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_NN50];
    
    // VSC_MODE_INFO_TYPE0_HRV_RMSSD                (12)
    self.fHrvRMSSD = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_RMSSD];
    
    // VSC_MODE_INFO_TYPE0_HRV_RR                  (13)
    self.fHrvRR = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_RR];
    
    // VSC_MODE_INFO_TYPE0_HRV_VLF                  (14)
    self.fHrvVLF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_VLF];
    
    // VSC_MODE_INFO_TYPE0_HRV_LF                  (15)
    self.fHrvLF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_LF];
    
    // VSC_MODE_INFO_TYPE0_HRV_HF                  (16)
    self.fHrvHF = self.item.fInfo[VSC_MODE_INFO_TYPE0_HRV_HF];
    
    if(self.fHrvHF > 0)
    {
      self.fHrvLFHF = self.fHrvLF / self.fHrvHF
    }
    else
    {
      self.fHrvLFHF = 0
    }
    
    /// TP
    self.fHrvTP = self.fHrvVLF  + self.fHrvLF  + self.fHrvHF
    
    if(self.fHrvTP > 0)
    {
      self.fHrvLFTP = self.fHrvLF / self.fHrvTP
      self.fHrvHFTP = self.fHrvHF / self.fHrvTP
    }
    else
    {
      self.fHrvLFTP = 0
      self.fHrvHFTP = 0
    }

    // VSC_MODE_INFO_TYPE0_BAR                     (17)
    self.fBar = self.item.fInfo[VSC_MODE_INFO_TYPE0_BAR];

    // VSC_MODE_INFO_TYPE0_BAR_TEMP                (18)
    self.fBarTemp = self.item.fInfo[VSC_MODE_INFO_TYPE0_BAR_TEMP];

    // VSC_MODE_INFO_TYPE0_GSEN_DATA0              (19) //< GS_X0 |  GS_Y0
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA0]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[0], subArr0, 2)
    memcpy(&self.sGSenY[0], subArr1, 2)
        
    // VSC_MODE_INFO_TYPE0_GSEN_DATA1              (20) //< GS_Z0 |  GS_X1
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA1]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[0], subArr0, 2)
    memcpy(&self.sGSenX[1], subArr1, 2)
    
    // VSC_MODE_INFO_TYPE0_GSEN_DATA2              (21) //< GS_Y1 |  GS_Z1
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA2]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenY[1], subArr0, 2)
    memcpy(&self.sGSenZ[1], subArr1, 2)
        
    // VSC_MODE_INFO_TYPE0_GSEN_DATA3              (22) //< GS_X2 |  GS_Y2
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA3]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[2], subArr0, 2)
    memcpy(&self.sGSenY[2], subArr1, 2)
    
    // VSC_MODE_INFO_TYPE0_GSEN_DATA4              (23) //< GS_Z2 |  GS_X3
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA4]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[2], subArr0, 2)
    memcpy(&self.sGSenX[3], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA5              (24) //< GS_Y3 |  GS_Z3
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA5]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenY[3], subArr0, 2)
    memcpy(&self.sGSenZ[3], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA6              (25) //< GS_X4 |  GS_Y4
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA6]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenX[4], subArr0, 2)
    memcpy(&self.sGSenY[4], subArr1, 2)

    // VSC_MODE_INFO_TYPE0_GSEN_DATA7              (26) //< GS_Z4 |  --
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_DATA7]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    subArr0 = Array(bDataArr[0...1])
    subArr1 = Array(bDataArr[2...3])
    memcpy(&self.sGSenZ[4], subArr0, 2)
    
    // VSC_MODE_INFO_TYPE0_ATR                     (27) //< ATR  CODE
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_ATR]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    self.atrNow.bAtr = bDataArr[0]
    
    // VSC_MODE_INFO_TYPE0_ATR_TIME                 (28) //< ATR_TIME
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_ATR_TIME]
    bDataArr = withUnsafeBytes(of: fVal, Array.init)
    memcpy(&self.atrNow.dwMS, bDataArr, 4);

    // VSC_MODE_INFO_TYPE0_VSC_START_UTC            (29) //< start time in seconds since 1970
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_VSC_START_UTC]
    memcpy(&self.dwVscStartUtc, bDataArr, 4);
    
    // VSC_MODE_INFO_TYPE0_VSC_RUN_TIME             (30) //<  Run time in seconds
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_VSC_RUN_TIME]
    self.fVscRunTimeSec = fVal
    
    // VSC_MODE_INFO_TYPE0_GSEN_POWER               (31) //<  G-Sensor power
    fVal = self.item.fInfo[VSC_MODE_INFO_TYPE0_GSEN_POWER]
    self.fGsenPower = fVal
  }
  
  func VscModeType0Decode(_ wId: UInt16, _ wLen : UInt16, _ pbData:[UInt8])
  {
    var idx         : Int = 0
    self.item.wId   = wId
    self.item.wLen  = wLen
    
    self.wId  = wId
        
    for i in 0..<self.item.bData.count
    {
      self.item.bData[i] = pbData[i]
    }
    idx = VSC_MODE_TYPE0_DATA_SIZE
    for i in 0..<(VSC_MODE_ITEM_INFO_SIZE / 4)
    {
      let subArr = Array(pbData[idx...(idx + 3)])
      memcpy(&self.item.fInfo[i], subArr, 4)
      idx = idx + 4
    }
    
    // Info Data Parse
    self.VscModeType0InfoParse()
    
    // Ecg Data Parse
    self.VscModeType0EcgDataParse();
  }
  
  func VscModeType1Decode(_ wId: UInt16, _ wLen : UInt16, _ pbData:[UInt8])
  {
    var idx : Int = 0;
    self.item.wId   = wId
    self.item.wLen  = wLen
    
    self.wId  = wId
        
    for i in 0..<self.item.bData.count
    {
      if(i < pbData.count)
      {
        self.item.bData[i] = pbData[i]
      }
    }
    idx = VSC_MODE_TYPE1_DATA_SIZE
    for i in 0..<(VSC_MODE_ITEM_INFO_SIZE/4)
    {
      let subArr = Array(pbData[idx...(idx + 3)])
      memcpy(&self.item.fInfo[i], subArr, 4)
      idx = idx + 4
    }
    
    // Info Data Parse
    self.VscModeType1InfoParse()
    
    // Ecg Data Parse
    self.VscModeType1EcgDataParse();
  }
  
  func Copy(_ pVscMode : VscModeCtlType)
  {
    self.wId = pVscMode.wId
    self.iChannelCount = pVscMode.iChannelCount
    
    self.item.Copy(pVscMode.item)
    
    self.fValueCH[0] = [Float]()
    self.fValueCH[1] = [Float]()
    
    for i in 0..<pVscMode.fValueCH[0].count
    {
      let fValue = Float(pVscMode.fValueCH[0][i])
      self.fValueCH[0].append(fValue)
    }
    
    for i in 0..<pVscMode.fValueCH[1].count
    {
      let fValue = Float(pVscMode.fValueCH[1][i])
      self.fValueCH[1].append(fValue)
    }

    self.jtm.Copy(pVscMode.jtm)
        
    self.dwUTC          = pVscMode.dwUTC
    self.fTemp          = pVscMode.fTemp
    self.fHRNow         = pVscMode.fHRNow
    self.fLeadOff       = pVscMode.fLeadOff
    self.fGsenXNow      = pVscMode.fGsenXNow
    self.fGsenYNow      = pVscMode.fGsenYNow
    self.fGsenZNow      = pVscMode.fGsenZNow
    self.fBattSoc       = pVscMode.fBattSoc
    self.fBattTotalSec  = pVscMode.fBattTotalSec
    self.fHrvSDNN       = pVscMode.fHrvSDNN
    self.fHrvNN50       = pVscMode.fHrvNN50
    self.fHrvRMSSD      = pVscMode.fHrvRMSSD
    self.fHrvRR         = pVscMode.fHrvRR
    self.fHrvVLF        = pVscMode.fHrvVLF
    self.fHrvLF         = pVscMode.fHrvLF
    self.fHrvHF         = pVscMode.fHrvHF
    self.fHrvLFHF       = pVscMode.fHrvLFHF
    self.fHrvTP         = pVscMode.fHrvTP
    self.fHrvLFTP       = pVscMode.fHrvLFTP
    self.fHrvHFTP       = pVscMode.fHrvHFTP
    self.fBar           = pVscMode.fBar
    self.fBarTemp       = pVscMode.fBarTemp
    
    self.fGsenPower     = pVscMode.fGsenPower
    
    self.sGSenX = [Int16]()
    self.sGSenY = [Int16]()
    self.sGSenZ = [Int16]()
    
    for i in 0..<pVscMode.sGSenX.count
    {
      let sVal = Int16(pVscMode.sGSenX[i])
      self.sGSenX.append(sVal)
    }
    
    for i in 0..<pVscMode.sGSenY.count
    {
      let sVal = Int16(pVscMode.sGSenY[i])
      self.sGSenY.append(sVal)
    }
    
    for i in 0..<pVscMode.sGSenZ.count
    {
      let sVal = Int16(pVscMode.sGSenZ[i])
      self.sGSenZ.append(sVal)
    }

    self.atrNow.AtrCopy(pVscMode.atrNow)
  }
}
