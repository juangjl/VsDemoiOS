//--------------------------------------------------------------------------------//
// @file  VSInfo.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
//------------------------------------------------------------------------------------------------//
// VS_INFO_ID
//------------------------------------------------------------------------------------------------//
let VS_INFO_ID_YEAR         : Int = 0
let VS_INFO_ID_MONTH        : Int = 1
let VS_INFO_ID_DAY          : Int = 2
let VS_INFO_ID_HOUR         : Int = 3
let VS_INFO_ID_MIN          : Int = 4
let VS_INFO_ID_SEC          : Int = 5
let VS_INFO_ID_MS           : Int = 6
let VS_INFO_ID_UTC          : Int = 7
let VS_INFO_ID_TEMP         : Int = 8
let VS_INFO_ID_HR_NOW       : Int = 9
let VS_INFO_ID_LEAD_OFF     : Int = 10
let VS_INFO_ID_GSEN_X_NOW   : Int = 11
let VS_INFO_ID_GSEN_Y_NOW   : Int = 12
let VS_INFO_ID_GSEN_Z_NOW   : Int = 13
let VS_INFO_ID_BATT_SOC     : Int = 14
let VS_INFO_ID_BATT_SEC     : Int = 15
let VS_INFO_ID_BAR          : Int = 16
let VS_INFO_ID_BAR_TEMP     : Int = 17
let VS_INFO_ID_HRV_SDNN     : Int = 18
let VS_INFO_ID_HRV_NN50     : Int = 19
let VS_INFO_ID_HRV_RMSSD    : Int = 20
let VS_INFO_ID_HRV_RR       : Int = 21
let VS_INFO_ID_HRV_VLF      : Int = 22
let VS_INFO_ID_HRV_LF       : Int = 23
let VS_INFO_ID_HRV_HF       : Int = 24
let VS_INFO_ID_HRV_TP       : Int = 25
let VS_INFO_ID_HRV_LFTP     : Int = 26
let VS_INFO_ID_HRV_HFTP     : Int = 27
let VS_INFO_ID_HRV_LFHF     : Int = 28
let VS_INFO_ID_GSEN_POWER   : Int = 29

let VS_INFO_ID_LOC_LAT      : Int = 30
let VS_INFO_ID_LOC_LONG     : Int = 31
let VS_INFO_ID_LOC_ALT      : Int = 32
let VS_INFO_ID_LOC_SPEED    : Int = 33

let VS_INFO_ID_TILT_PITCH   : Int = 34
let VS_INFO_ID_TILT_ROLL    : Int = 35

let VS_INFO_ID_COUNT        : Int = 36

//----------------------------------------------------------------//
// FILE LINE TOKEN
//----------------------------------------------------------------//
let VS_INFO_TOKEN_YEAR                : Int = 0
let VS_INFO_TOKEN_MONTH               : Int = 1
let VS_INFO_TOKEN_DAY                 : Int = 2
let VS_INFO_TOKEN_HOUR                : Int = 3
let VS_INFO_TOKEN_MIN                 : Int = 4
let VS_INFO_TOKEN_SEC                 : Int = 5
let VS_INFO_TOKEN_MS                  : Int = 6
let VS_INFO_TOKEN_UTC                 : Int = 7
let VS_INFO_TOKEN_TEMP                : Int = 8
let VS_INFO_TOKEN_HR_NOW              : Int = 9
let VS_INFO_TOKEN_LEAD_OFF            : Int = 10
let VS_INFO_TOKEN_GSEN_X_NOW          : Int = 11
let VS_INFO_TOKEN_GSEN_Y_NOW          : Int = 12
let VS_INFO_TOKEN_GSEN_Z_NOW          : Int = 13
let VS_INFO_TOKEN_BATT_SOC            : Int = 14
let VS_INFO_TOKEN_BATT_SEC            : Int = 15
let VS_INFO_TOKEN_HRV_SDNN            : Int = 16
let VS_INFO_TOKEN_HRV_NN50            : Int = 17
let VS_INFO_TOKEN_HRV_RMSSD           : Int = 18
let VS_INFO_TOKEN_HRV_RR              : Int = 19
let VS_INFO_TOKEN_HRV_VLF             : Int = 20
let VS_INFO_TOKEN_HRV_LF	            : Int = 21
let VS_INFO_TOKEN_HRV_HF	            : Int = 22
let VS_INFO_TOKEN_HRV_TP	            : Int = 23
let VS_INFO_TOKEN_HRV_LFTP	          : Int = 24
let VS_INFO_TOKEN_HRV_HFTP	          : Int = 25
let VS_INFO_TOKEN_HRV_LFHF	          : Int = 26
let VS_INFO_TOKEN_GSEN_POWER	        : Int = 27
let VS_INFO_TOKEN_LOC_LAT	            : Int = 28
let VS_INFO_TOKEN_LOC_LONG	          : Int = 29
let VS_INFO_TOKEN_LOC_ALT	            : Int = 30
let VS_INFO_TOKEN_LOC_SPEED           : Int = 31
let VS_INFO_TOKEN_TILT_PITCH          : Int = 32
let VS_INFO_TOKEN_TILT_ROLL           : Int = 33
let VS_INFO_TOKEN_BAR                 : Int = 34
let VS_INFO_TOKEN_BAR_TEMP            : Int = 35


let VS_INFO_TOKEN_COUNT               : Int = 36

//------------------------------------------------------------------------------------------------//
// VS_INFO_LABEL
//------------------------------------------------------------------------------------------------//
let VS_INFO_LABEL_YEAR          : String = "YEAR"           //< 00
let VS_INFO_LABEL_MONTH         : String = "MONTH"          //< 01
let VS_INFO_LABEL_DAY           : String = "DAY"            //< 02
let VS_INFO_LABEL_HOUR          : String = "HOUR"           //< 03
let VS_INFO_LABEL_MIN           : String = "MIN"            //< 04
let VS_INFO_LABEL_SEC           : String = "SEC"            //< 05
let VS_INFO_LABEL_MS            : String = "MS"             //< 06
let VS_INFO_LABEL_UTC           : String = "UTC"            //< 07
let VS_INFO_LABEL_TEMP          : String = "TEMP"           //< 08
let VS_INFO_LABEL_HR_NOW        : String = "HR_NOW"         //< 09
let VS_INFO_LABEL_LEAD_OFF      : String = "LEAD_OFF"       //< 10
let VS_INFO_LABEL_GSEN_X_NOW    : String = "GSEN_X_NOW"     //< 11
let VS_INFO_LABEL_GSEN_Y_NOW    : String = "GSEN_Y_NOW"     //< 12
let VS_INFO_LABEL_GSEN_Z_NOW    : String = "GSEN_Z_NOW"     //< 13
let VS_INFO_LABEL_BATT_SOC      : String = "BATT_SOC"       //< 14
let VS_INFO_LABEL_BATT_SEC      : String = "BATT_TOTAL_SEC" //< 15
let VS_INFO_LABEL_BAR           : String = "BAR"            //< 16
let VS_INFO_LABEL_BAR_TEMP      : String = "BAR_TEMP"       //< 17
let VS_INFO_LABEL_HRV_SDNN      : String = "HRV_SDNN"       //< 18
let VS_INFO_LABEL_HRV_NN50      : String = "HRV_NN50"       //< 19
let VS_INFO_LABEL_HRV_RMSSD     : String = "HRV_RMSSD"      //< 20
let VS_INFO_LABEL_HRV_RR        : String = "HRV_RR"         //< 21
let VS_INFO_LABEL_HRV_VLF       : String = "HRV_VLF"        //< 22
let VS_INFO_LABEL_HRV_LF        : String = "HRV_LF"         //< 23
let VS_INFO_LABEL_HRV_HF        : String = "HRV_HF"         //< 24
let VS_INFO_LABEL_HRV_TP        : String = "HRV_TP"         //< 25
let VS_INFO_LABEL_HRV_LFTP      : String = "HRV_LFTP"       //< 26
let VS_INFO_LABEL_HRV_HFTP      : String = "HRV_HFTP"       //< 27
let VS_INFO_LABEL_HRV_LFHF      : String = "HRV_LFHF"       //< 28
let VS_INFO_LABEL_GSEN_POWER    : String = "GSEN_POWER"     //< 29
let VS_INFO_LABEL_LOC_LAT       : String = "LOC_LAT"        //< 30
let VS_INFO_LABEL_LOC_LONG      : String = "LOC_LONG"       //< 31
let VS_INFO_LABEL_LOC_ALT       : String = "LOC_ALT"        //< 32
let VS_INFO_LABEL_LOC_SPEED     : String = "LOC_SPEED"      //< 33
let VS_INFO_LABEL_TILT_PITCH    : String = "TILT_PITCH"     //< 34
let VS_INFO_LABEL_TILT_ROLL     : String = "TILT_ROLL"      //< 35

//------------------------------------------------------------------------------------------------//
// VSINFO
//------------------------------------------------------------------------------------------------//
class VSInfo
{
  var  strLabelArr     : [String] = [ VS_INFO_LABEL_YEAR,           //< 00:
                                      VS_INFO_LABEL_MONTH,          //< 01:
                                      VS_INFO_LABEL_DAY,            //< 02:
                                      VS_INFO_LABEL_HOUR,           //< 03:
                                      VS_INFO_LABEL_MIN,            //< 04:
                                      VS_INFO_LABEL_SEC,            //< 05:
                                      VS_INFO_LABEL_MS,             //< 06:
                                      VS_INFO_LABEL_UTC,            //< 07:
                                      VS_INFO_LABEL_TEMP,           //< 08:
                                      VS_INFO_LABEL_HR_NOW,         //< 09:
                                      VS_INFO_LABEL_LEAD_OFF,       //< 10:
                                      VS_INFO_LABEL_GSEN_X_NOW,     //< 11:
                                      VS_INFO_LABEL_GSEN_Y_NOW,     //< 12:
                                      VS_INFO_LABEL_GSEN_Z_NOW,     //< 13:
                                      VS_INFO_LABEL_BATT_SOC,       //< 14:
                                      VS_INFO_LABEL_BATT_SEC,       //< 15:
                                      VS_INFO_LABEL_BAR,            //< 16:
                                      VS_INFO_LABEL_BAR_TEMP,       //< 17:
                                      VS_INFO_LABEL_HRV_SDNN,       //< 18:
                                      VS_INFO_LABEL_HRV_NN50,       //< 19:
                                      VS_INFO_LABEL_HRV_RMSSD,      //< 20:
                                      VS_INFO_LABEL_HRV_RR,         //< 21:
                                      VS_INFO_LABEL_HRV_VLF,        //< 22:
                                      VS_INFO_LABEL_HRV_LF,         //< 23:
                                      VS_INFO_LABEL_HRV_HF,         //< 24:
                                      VS_INFO_LABEL_HRV_TP,         //< 25:
                                      VS_INFO_LABEL_HRV_LFTP,       //< 26:
                                      VS_INFO_LABEL_HRV_HFTP,       //< 27:
                                      VS_INFO_LABEL_HRV_LFHF ,      //< 28:
                                      VS_INFO_LABEL_GSEN_POWER,     //< 29:                                      
                                      VS_INFO_LABEL_LOC_LAT,        //< 30:
                                      VS_INFO_LABEL_LOC_LONG,       //< 31:
                                      VS_INFO_LABEL_LOC_ALT,        //< 32:
                                      VS_INFO_LABEL_LOC_SPEED,      //< 33:
                                      VS_INFO_LABEL_TILT_PITCH,     //< 34:
                                      VS_INFO_LABEL_TILT_ROLL,      //< 35:                                      
                                    ]
  
  
  var  fValueArr     : [Float64] = Array(repeating: 0.0, count: VS_INFO_ID_COUNT)
                                        
  init()
  {
  }
    
  deinit
  {
  }
  
  func IndexGet(_ strLabel : String) ->Int
  {
    var idx : Int = 0   
    for i in 0..<self.strLabelArr.count
    {
      if(strLabel == self.strLabelArr[i])
      {
        idx = i
        break
      }
    }
    return idx
  }
  
  func FloatGet(_ strLabel : String) ->Float
  {
    let idx = self.IndexGet(strLabel)
    let fValue = Float(self.fValueArr[idx])
    return fValue
  }
  
  func Float64Get(_ strLabel : String) ->Float64
  {
    let idx = self.IndexGet(strLabel)
    let fValue : Float64 = Float64(self.fValueArr[idx])
    return fValue
  }
   
  func IntGet(_ strLabel : String) ->Int
  {
    let idx : Int = self.IndexGet(strLabel)
    let iValue = Int(self.fValueArr[idx])
    return iValue
  }
  
  func Int64Get(_ strLabel : String) ->Int64
  {
    let idx : Int = self.IndexGet(strLabel)
    let iValue : Int64 = Int64(self.fValueArr[idx])
    return iValue
  }
  
  func Print(_ strLabel : String)
  {
    var idx = 0    
    for i in 0..<self.strLabelArr.count
    {
      if(strLabel == self.strLabelArr[i])
      {
        idx = i
        break
      }
    }
    let strMsg = String(format : "\t\t [INFO] %02d: ", idx) +
                 String(format : "'%@' = %0.2f", self.strLabelArr[idx], self.fValueArr[idx])
    print(strMsg)
  }
  
  func InfoPrintAll()
  {
    for i in 0..<self.strLabelArr.count
    {      
      let strMsg = String(format : "\t\t [INFO][ALL] %02d: ", i) +
                   String(format : "'%@' = %0.2f", self.strLabelArr[i], self.fValueArr[i])
      print(strMsg)
    }
  }
  
  func InfoFileLineParse(_ strLine : String)
  {
    let strArr : [String]? = strLine.components(separatedBy: ",")
    
    if(strLine.count == 0)
    {
      return
    }
    
    if(strArr?.count == 0)
    {
      return
    }
    let tokenArr : [String] = strArr!
    let iCount = tokenArr.count   
    
    if(iCount > VS_INFO_TOKEN_YEAR)
    {
      self.fValueArr[VS_INFO_ID_YEAR]      = Float64(tokenArr[VS_INFO_TOKEN_YEAR])!                  //< 00
    }
    if(iCount > VS_INFO_TOKEN_MONTH)
    {
      self.fValueArr[VS_INFO_ID_MONTH]      = Float64(tokenArr[VS_INFO_TOKEN_MONTH])!                 //< 01
    }
    if(iCount > VS_INFO_TOKEN_DAY)
    {
      self.fValueArr[VS_INFO_ID_DAY]        = Float64(tokenArr[VS_INFO_TOKEN_DAY])!                   //< 02
    }
    if(iCount > VS_INFO_TOKEN_HOUR)
    {
      self.fValueArr[VS_INFO_ID_HOUR]       = Float64(tokenArr[VS_INFO_TOKEN_HOUR])!                  //< 03
    }
    if(iCount > VS_INFO_TOKEN_MIN)
    {
      self.fValueArr[VS_INFO_ID_MIN]        = Float64(tokenArr[VS_INFO_TOKEN_MIN])!                   //< 04
    }
    if(iCount > VS_INFO_TOKEN_SEC)
    {
      self.fValueArr[VS_INFO_ID_SEC]        = Float64(tokenArr[VS_INFO_TOKEN_SEC])!                   //< 05
    }
    if(iCount > VS_INFO_TOKEN_MS)
    {
      self.fValueArr[VS_INFO_ID_MS]         = Float64(tokenArr[VS_INFO_TOKEN_MS])!                    //< 06
    }
    if(iCount > VS_INFO_TOKEN_UTC)
    {
      self.fValueArr[VS_INFO_ID_UTC]        = Float64(tokenArr[VS_INFO_TOKEN_UTC])!                   //< 07
    }
    if(iCount > VS_INFO_TOKEN_TEMP)
    {
      self.fValueArr[VS_INFO_ID_TEMP]       = Float64(tokenArr[VS_INFO_TOKEN_TEMP])!                  //< 08
    }
    if(iCount > VS_INFO_TOKEN_HR_NOW)
    {
      self.fValueArr[VS_INFO_ID_HR_NOW]     = Float64(tokenArr[VS_INFO_TOKEN_HR_NOW])!                //< 09
    }
    if(iCount > VS_INFO_TOKEN_LEAD_OFF)
    {
      self.fValueArr[VS_INFO_ID_LEAD_OFF]   = Float64(tokenArr[VS_INFO_TOKEN_LEAD_OFF])!              //< 10
    }
    if(iCount > VS_INFO_TOKEN_GSEN_X_NOW)
    {
      self.fValueArr[VS_INFO_ID_GSEN_X_NOW] = Float64(tokenArr[VS_INFO_TOKEN_GSEN_X_NOW])!            //< 11
    }
    if(iCount > VS_INFO_TOKEN_GSEN_Y_NOW)
    {
      self.fValueArr[VS_INFO_ID_GSEN_Y_NOW] = Float64(tokenArr[VS_INFO_TOKEN_GSEN_Y_NOW])!            //< 12
    }
    if(iCount > VS_INFO_TOKEN_GSEN_Z_NOW)
    {
      self.fValueArr[VS_INFO_ID_GSEN_Z_NOW] = Float64(tokenArr[VS_INFO_TOKEN_GSEN_Z_NOW])!            //< 13
    }    
    if(iCount > VS_INFO_TOKEN_BATT_SOC)
    {
      self.fValueArr[VS_INFO_ID_BATT_SOC]   = Float64(tokenArr[VS_INFO_TOKEN_BATT_SOC])!              //< 14
    }
    if(iCount > VS_INFO_TOKEN_BATT_SEC)
    {
      self.fValueArr[VS_INFO_ID_BATT_SEC]   = Float64(tokenArr[VS_INFO_TOKEN_BATT_SEC])!              //< 15
    }
    if(iCount > VS_INFO_TOKEN_BAR)
    {    
      self.fValueArr[VS_INFO_ID_BAR]        = Float64(tokenArr[VS_INFO_TOKEN_BAR])!                   //< 16    
    }
    if(iCount > VS_INFO_TOKEN_BAR_TEMP)
    { 
      self.fValueArr[VS_INFO_ID_BAR_TEMP]   = Float64(tokenArr[VS_INFO_TOKEN_BAR_TEMP])!              //< 17
    }
    if(iCount > VS_INFO_TOKEN_HRV_SDNN)
    {
      self.fValueArr[VS_INFO_ID_HRV_SDNN]   = Float64(tokenArr[VS_INFO_TOKEN_HRV_SDNN])!              //< 18
    }
    if(iCount > VS_INFO_TOKEN_HRV_NN50)
    {
      self.fValueArr[VS_INFO_ID_HRV_NN50]   = Float64(tokenArr[VS_INFO_TOKEN_HRV_NN50])!              //< 19
    }
    if(iCount > VS_INFO_TOKEN_HRV_RMSSD)
    {
      self.fValueArr[VS_INFO_ID_HRV_RMSSD]  = Float64(tokenArr[VS_INFO_TOKEN_HRV_RMSSD])!             //< 20
    }    
    if(iCount > VS_INFO_TOKEN_HRV_RR)
    {
      self.fValueArr[VS_INFO_ID_HRV_RR]     = Float64(tokenArr[VS_INFO_TOKEN_HRV_RR])!                //< 21
    }
    if(iCount > VS_INFO_TOKEN_HRV_VLF)
    {
      self.fValueArr[VS_INFO_ID_HRV_VLF]    = Float64(tokenArr[VS_INFO_TOKEN_HRV_VLF])!               //< 22
    }
    if(iCount > VS_INFO_TOKEN_HRV_LF)
    {
      self.fValueArr[VS_INFO_ID_HRV_LF]     = Float64(tokenArr[VS_INFO_TOKEN_HRV_LF])!                //< 23
    }
    if(iCount > VS_INFO_TOKEN_HRV_HF)
    {
      self.fValueArr[VS_INFO_ID_HRV_HF]     = Float64(tokenArr[VS_INFO_TOKEN_HRV_HF])!                //< 24
    }
    if(iCount > VS_INFO_TOKEN_HRV_TP)
    {
      self.fValueArr[VS_INFO_ID_HRV_TP]     = Float64(tokenArr[VS_INFO_TOKEN_HRV_TP])!                //< 25
    }
    if(iCount > VS_INFO_TOKEN_HRV_LFTP)
    {
      self.fValueArr[VS_INFO_ID_HRV_LFTP]   = Float64(tokenArr[VS_INFO_TOKEN_HRV_LFTP])!              //< 26
    }
    if(iCount > VS_INFO_TOKEN_HRV_HFTP)
    {
      self.fValueArr[VS_INFO_ID_HRV_HFTP]   = Float64(tokenArr[VS_INFO_TOKEN_HRV_HFTP])!              //< 27
    }
    if(iCount > VS_INFO_TOKEN_HRV_LFHF)
    {
      self.fValueArr[VS_INFO_ID_HRV_LFHF]   = Float64(tokenArr[VS_INFO_TOKEN_HRV_LFHF])!              //< 28
    }
    if(iCount > VS_INFO_TOKEN_GSEN_POWER)
    {
      self.fValueArr[VS_INFO_ID_GSEN_POWER] = Float64(tokenArr[VS_INFO_TOKEN_GSEN_POWER])!            //< 29
    }
    if(iCount > VS_INFO_TOKEN_LOC_LAT)
    {
      self.fValueArr[VS_INFO_ID_LOC_LAT]    = Float64(tokenArr[VS_INFO_TOKEN_LOC_LAT])!               //< 30
    }
    if(iCount > VS_INFO_TOKEN_LOC_LONG)
    {
      self.fValueArr[VS_INFO_ID_LOC_LONG]   = Float64(tokenArr[VS_INFO_TOKEN_LOC_LONG])!              //< 31
    }
    if(iCount > VS_INFO_TOKEN_LOC_ALT)
    {
      self.fValueArr[VS_INFO_ID_LOC_ALT]    = Float64(tokenArr[VS_INFO_TOKEN_LOC_ALT])!               //< 32
    }
    if(iCount > VS_INFO_TOKEN_LOC_SPEED)
    {
      self.fValueArr[VS_INFO_ID_LOC_SPEED]  = Float64(tokenArr[VS_INFO_TOKEN_LOC_SPEED])!             //< 33
    }
    if(iCount > VS_INFO_TOKEN_TILT_PITCH)
    {
      if tokenArr[VS_INFO_TOKEN_TILT_PITCH] != ""
      {
        self.fValueArr[VS_INFO_ID_TILT_PITCH] = Float64(tokenArr[VS_INFO_TOKEN_TILT_PITCH])!            //< 34
      }
    }
    if(iCount > VS_INFO_TOKEN_TILT_ROLL)
    {
      if tokenArr[VS_INFO_TOKEN_TILT_ROLL] != ""
      {
        self.fValueArr[VS_INFO_ID_TILT_ROLL]  = Float64(tokenArr[VS_INFO_TOKEN_TILT_ROLL])!             //< 35
      }
    }
  }
  
  func VscModeParse(pVscMode : VscModeCtlType)
  {
    self.fValueArr[VS_INFO_ID_YEAR]       = Float64(pVscMode.jtm.iYear)     //< 00
    self.fValueArr[VS_INFO_ID_MONTH]      = Float64(pVscMode.jtm.iMonth)    //< 01
    self.fValueArr[VS_INFO_ID_DAY]        = Float64(pVscMode.jtm.iDay)      //< 02
    self.fValueArr[VS_INFO_ID_HOUR]       = Float64(pVscMode.jtm.iHour)     //< 03
    self.fValueArr[VS_INFO_ID_MIN]        = Float64(pVscMode.jtm.iMin)      //< 04
    self.fValueArr[VS_INFO_ID_SEC]        = Float64(pVscMode.jtm.iSec)      //< 05
    self.fValueArr[VS_INFO_ID_MS]         = Float64(pVscMode.jtm.iMS)       //< 06
    self.fValueArr[VS_INFO_ID_UTC]        = Float64(pVscMode.dwUTC)         //< 07
    self.fValueArr[VS_INFO_ID_TEMP]       = Float64(pVscMode.fTemp)         //< 08
    self.fValueArr[VS_INFO_ID_HR_NOW]     = Float64(pVscMode.fHRNow)        //< 09
    self.fValueArr[VS_INFO_ID_LEAD_OFF]   = Float64(pVscMode.fLeadOff)      //< 10
    
    self.fValueArr[VS_INFO_ID_GSEN_X_NOW] = Float64(pVscMode.fGsenXNow)     //< 11
    self.fValueArr[VS_INFO_ID_GSEN_Y_NOW] = Float64(pVscMode.fGsenYNow)     //< 12
    self.fValueArr[VS_INFO_ID_GSEN_Z_NOW] = Float64(pVscMode.fGsenZNow)     //< 13
    
    self.fValueArr[VS_INFO_ID_BATT_SOC]   = Float64(pVscMode.fBattSoc)      //< 14
    self.fValueArr[VS_INFO_ID_BATT_SEC]   = Float64(pVscMode.fBattTotalSec) //< 15
    
    self.fValueArr[VS_INFO_ID_BAR]        = Float64(pVscMode.fBar)          //< 16
    self.fValueArr[VS_INFO_ID_BAR_TEMP]   = Float64(pVscMode.fBarTemp)      //< 17
    
    self.fValueArr[VS_INFO_ID_HRV_SDNN]   = Float64(pVscMode.fHrvSDNN)      //< 18
    self.fValueArr[VS_INFO_ID_HRV_NN50]   = Float64(pVscMode.fHrvNN50)      //< 19
    self.fValueArr[VS_INFO_ID_HRV_RMSSD]  = Float64(pVscMode.fHrvRMSSD)     //< 20
    self.fValueArr[VS_INFO_ID_HRV_RR]     = Float64(pVscMode.fHrvRR)        //< 21
    
    self.fValueArr[VS_INFO_ID_HRV_VLF]    = Float64(pVscMode.fHrvVLF)       //< 22
    self.fValueArr[VS_INFO_ID_HRV_LF]     = Float64(pVscMode.fHrvLF)        //< 23
    self.fValueArr[VS_INFO_ID_HRV_HF]     = Float64(pVscMode.fHrvHF)        //< 24
    self.fValueArr[VS_INFO_ID_HRV_TP]     = Float64(pVscMode.fHrvTP)        //< 25
    
    self.fValueArr[VS_INFO_ID_HRV_LFTP]   = Float64(pVscMode.fHrvLFHF)      //< 26
    self.fValueArr[VS_INFO_ID_HRV_HFTP]   = Float64(pVscMode.fHrvHFTP)      //< 27
    self.fValueArr[VS_INFO_ID_HRV_LFHF]   = Float64(pVscMode.fHrvLFTP)      //< 28
        
    self.fValueArr[VS_INFO_ID_GSEN_POWER] = Float64(pVscMode.fGsenPower)    //< 29
    
    self.fValueArr[VS_INFO_ID_LOC_LAT]    = 0                               //< 30
    self.fValueArr[VS_INFO_ID_LOC_LONG]   = 0                               //< 31
    self.fValueArr[VS_INFO_ID_LOC_ALT]    = 0                               //< 32
    self.fValueArr[VS_INFO_ID_LOC_SPEED]  = 0                               //< 33

    self.fValueArr[VS_INFO_ID_TILT_PITCH] = 0                               //< 34
    self.fValueArr[VS_INFO_ID_TILT_ROLL]  = 0                               //< 35

    self.TiltSet()            
  }

  func TiltSet()
  {
    let tilt : JTilt = JTilt()
    let fGsenX : Float = Float(self.fValueArr[VS_INFO_ID_GSEN_X_NOW])
    let fGsenY : Float = Float(self.fValueArr[VS_INFO_ID_GSEN_Y_NOW])
    let fGsenZ : Float = Float(self.fValueArr[VS_INFO_ID_GSEN_Z_NOW])

    tilt.TiltGet(fGsenX, fGsenY, fGsenZ)
    self.fValueArr[VS_INFO_ID_TILT_PITCH] = Float64(tilt.fPitch)
    self.fValueArr[VS_INFO_ID_TILT_ROLL]  = Float64(tilt.fRoll)
  }
  
  func LocSet(_ fLocLat: Double, _ fLocLong : Double, _ fLocAlt : Double, _ fLocSpeed : Double )
  {
    self.fValueArr[VS_INFO_ID_LOC_LAT]    = fLocLat     //< 30
    self.fValueArr[VS_INFO_ID_LOC_LONG]   = fLocLong    //< 31
    self.fValueArr[VS_INFO_ID_LOC_ALT]    = fLocAlt     //< 32
    self.fValueArr[VS_INFO_ID_LOC_SPEED]  = fLocSpeed   //< 33
  }
  
  func Copy(_ vsInfo: VSInfo)
  {
    for i in 0..<self.strLabelArr.count
    {
      self.fValueArr[i] = vsInfo.fValueArr[i]
    }
  }
}

