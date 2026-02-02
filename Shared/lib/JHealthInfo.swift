//--------------------------------------------------------------------------------//
// @file  JMeasItem.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI

let HEALTH_INFO_TEMP_MAX          : Float    = 100
let HEALTH_INFO_TEMP_MIN          : Float    = -20
let HEALTH_INFO_TEMP_MAX_INIT     : Float    = 0
let HEALTH_INFO_TEMP_MIN_INIT     : Float    = 100

let HEALTH_INFO_BATT_SOC_MAX      : Float    = 100
let HEALTH_INFO_BATT_SOC_MIN      : Float    = 0

let HEALTH_INFO_GSEN_G_MAX        : Float    = 8000
let HEALTH_INFO_GSEN_G_MIN        : Float    = -8000

class JHealthInfo  : NSObject, Identifiable, Codable
{  
  //------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //------------------------------------------------------------------------------------------------//
  // Removed DB functionality
  
  //----------------------------------------------------------------//
  // Time
  //----------------------------------------------------------------//
  var  iYear          : Int     = 0
  var  iMonth         : Int     = 0
  var  iDay           : Int     = 0
  var  iHour          : Int     = 0
  var  iMin           : Int     = 0
  var  iSec           : Int     = 0

  var  iTotalTime     : Int     = 0
    
  //----------------------------------------------------------------//
  // Beat count
  //----------------------------------------------------------------//
  var fBeatCountTotal     : Float = 0
  var fBeatCountNormal    : Float = 0
  var fBeatCountAbnormal  : Float = 0

  var fBeatRateNormal     : Float = 0
  var fBeatRateAbnormal   : Float = 0
    
  var fBeatCountApc       : Float = 0
  var fBeatCountEctopic   : Float = 0
  var fBeatCountOther     : Float = 0
  
  //----------------------------------------------------------------//
  // Heart Rate
  //----------------------------------------------------------------//
  var fHRNow           : Float    = 0
  var fHRMin           : Float    = 999
  var fHRMax           : Float    = 0
  var fHRSum           : Float    = 0
  var fHRCount         : Float    = 0
  var fHRAvg           : Float    = 0

  //----------------------------------------------------------------//
  // Temperature
  //----------------------------------------------------------------//
  var fTempNow           : Float    = 0
  var fTempMin           : Float    = HEALTH_INFO_TEMP_MIN
  var fTempMax           : Float    = HEALTH_INFO_TEMP_MAX
  var fTempSum           : Float    = 0
  var fTempCount         : Float    = 0
  var fTempAvg           : Float    = 0

  //----------------------------------------------------------------//
  // GSen-X
  //----------------------------------------------------------------//
  var fGSenXNow           : Float    = 0
  var fGSenXMin           : Float    = 0
  var fGSenXMax           : Float    = 0
  var fGSenXSum           : Float    = 0
  var fGSenXCount         : Float    = 0
  var fGSenXAvg           : Float    = 0

  //----------------------------------------------------------------//
  // GSen-X
  //----------------------------------------------------------------//
  var fGSenYNow           : Float    = 0
  var fGSenYMin           : Float    = 0
  var fGSenYMax           : Float    = 0
  var fGSenYSum           : Float    = 0
  var fGSenYCount         : Float    = 0
  var fGSenYAvg           : Float    = 0

  //----------------------------------------------------------------//
  // GSen-Z
  //----------------------------------------------------------------//
  var fGSenZNow           : Float    = 0
  var fGSenZMin           : Float    = 0
  var fGSenZMax           : Float    = 0
  var fGSenZSum           : Float    = 0
  var fGSenZCount         : Float    = 0
  var fGSenZAvg           : Float    = 0


  //----------------------------------------------------------------//
  // GSen-G
  //----------------------------------------------------------------//
  var fGSenGNow           : Float    = 0
  var fGSenGMin           : Float    = 0
  var fGSenGMax           : Float    = 0
  var fGSenGSum           : Float    = 0
  var fGSenGCount         : Float    = 0
  var fGSenGAvg           : Float    = 0
  
  //----------------------------------------------------------------//
  // GSen-Power
  //----------------------------------------------------------------//
  var fGSenPowerNow        : Float    = 0
  var fGSenPowerMin        : Float    = 0
  var fGSenPowerMax        : Float    = 0
  var fGSenPowerSum        : Float    = 0
  var fGSenPowerCount      : Float    = 0
  var fGSenPowerAvg        : Float    = 0

  //----------------------------------------------------------------//
  // HRV-RR
  //----------------------------------------------------------------//
  var fHrvRRNow           : Float    = 0
  var fHrvRRMin           : Float    = 0
  var fHrvRRMax           : Float    = 0
  var fHrvRRSum           : Float    = 0
  var fHrvRRCount         : Float    = 0
  var fHrvRRAvg           : Float    = 0

  //----------------------------------------------------------------//
  // HRV-SDNN
  //----------------------------------------------------------------//
  var fHrvSdnnNow         : Float    = 0
  var fHrvSdnnMin         : Float    = 0
  var fHrvSdnnMax         : Float    = 0
  var fHrvSdnnSum         : Float    = 0
  var fHrvSdnnCount       : Float    = 0
  var fHrvSdnnAvg         : Float    = 0

  //----------------------------------------------------------------//
  // HRV-RMSSD
  //----------------------------------------------------------------//
  var fHrvRmssdNow        : Float    = 0
  var fHrvRmssdMin        : Float    = 0
  var fHrvRmssdMax        : Float    = 0
  var fHrvRmssdSum        : Float    = 0
  var fHrvRmssdCount      : Float    = 0
  var fHrvRmssdAvg        : Float    = 0

  //----------------------------------------------------------------//
  // HRV-LFHF
  //----------------------------------------------------------------//
  var fHrvLFHFNow         : Float    = 0
  var fHrvLFHFMin         : Float    = 0
  var fHrvLFHFMax         : Float    = 0
  var fHrvLFHFSum         : Float    = 0
  var fHrvLFHFCount       : Float    = 0
  var fHrvLFHFAvg         : Float    = 0

  //----------------------------------------------------------------//
  // HRV-LFTP
  //----------------------------------------------------------------//
  var fHrvLFTPNow         : Float    = 0
  var fHrvLFTPMin         : Float    = 0
  var fHrvLFTPMax         : Float    = 0
  var fHrvLFTPSum         : Float    = 0
  var fHrvLFTPCount       : Float    = 0
  var fHrvLFTPAvg         : Float    = 0

  //----------------------------------------------------------------//
  // HRV-HFTP
  //----------------------------------------------------------------//
  var fHrvHFTPNow         : Float    = 0
  var fHrvHFTPMin         : Float    = 0
  var fHrvHFTPMax         : Float    = 0
  var fHrvHFTPSum         : Float    = 0
  var fHrvHFTPCount       : Float    = 0
  var fHrvHFTPAvg         : Float    = 0

  //----------------------------------------------------------------//
  // Battery SOC
  //----------------------------------------------------------------//
  var fBattSocNow         : Float    = 0
  var fBattSocMin         : Float    = 0
  var fBattSocMax         : Float    = 0
  var fBattSocSum         : Float    = 0
  var fBattSocCount       : Float    = 0
  var fBattSocAvg         : Float    = 0
  
  //------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //------------------------------------------------------------------------------------------------//
  override init()
  {
    super.init()
  }
    
  deinit
  {
    
  }

  func HeartRateSet(_ fHR : Float, _ bAtr : UInt8)
  {
    var fValue : Float = 0;
    //----------------------------------------------------------------//
    // Filter
    //----------------------------------------------------------------//
    if(fHR < 0)
    {
      return
    }

    if(fHR > 250)
    {
      fValue = 250;
    }
    else
    {
      fValue = fHR;
    }
        
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHRNow = fValue
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//
    if(fHR > 0)
    {
      if(self.fHRCount == 0)
      {
        self.fHRMin = fValue
        self.fHRMax = fValue
      }
      
      if(self.fHRMin > fValue)
      {
        self.fHRMin = fValue
      }
      
      if(self.fHRMax < fValue)
      {
        self.fHRMax = fValue
      }
      
      self.fHRSum   = self.fHRSum   + fValue
      self.fHRCount = self.fHRCount + 1
      self.fHRAvg   = self.fHRSum / self.fHRCount
//      print("ATR HR : \(fHR), MAX: \(self.fHRMax), MIN\(self.fHRMin ), HR AVG : \(self.fHRAvg)");
    }
    
    //----------------------------------------------------------------//
    // Beat count
    //----------------------------------------------------------------//
    if(fHR > 0)
    {
      // Bypass the unreadable Start & end atr
      if((bAtr != ATR_UNREADABLES) && (bAtr != ATR_UNREADABLEE))
      {
        self.fBeatCountTotal = self.fBeatCountTotal + 1
      }
      if(bAtr == ATR_NORMAL)
      {
        self.fBeatCountNormal = self.fBeatCountNormal + 1
      }
      else if(bAtr == ATR_APC)
      {
        self.fBeatCountApc      =  self.fBeatCountApc + 1
        self.fBeatCountAbnormal = self.fBeatCountAbnormal + 1
      }
      else if(bAtr == ATR_PVC)
      {
        self.fBeatCountEctopic  = self.fBeatCountEctopic + 1
        self.fBeatCountAbnormal = self.fBeatCountAbnormal + 1
      }
      else
      {
        // Bypass the unreadable Start & end atr
        if((bAtr != ATR_UNREADABLES) && (bAtr != ATR_UNREADABLEE))
        {
          self.fBeatCountOther    = self.fBeatCountOther + 1
          self.fBeatCountAbnormal = self.fBeatCountAbnormal + 1
        }
      }

      //--------------------------------------------------------//
      // Normal / Abnormal rate
      //--------------------------------------------------------//
      self.fBeatRateNormal    = (self.fBeatCountNormal  * 100) / self.fBeatCountTotal
      self.fBeatRateAbnormal  = (self.fBeatCountAbnormal * 100) / self.fBeatCountTotal
    }
  }

  func TempSet(_ fTemp : Float)
  {
    //----------------------------------------------------------------//
    // Filter
    //----------------------------------------------------------------//
    if(fTemp < HEALTH_INFO_TEMP_MIN)
    {
      return
    }

    if(fTemp > HEALTH_INFO_TEMP_MAX)
    {
      return
    }

    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fTempNow = fTemp
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fTempCount == 0)
    {
      self.fTempMin = fTemp
      self.fTempMax = fTemp
    }
    
    if(self.fTempMin > fTemp)
    {
      self.fTempMin = fTemp
    }
    
    if(self.fTempMax < fTemp)
    {
      self.fTempMax = fTemp
    }
    
    self.fTempSum   = self.fTempSum   + fTemp
    self.fTempCount = self.fTempCount + 1
    self.fTempAvg   = self.fTempSum / self.fTempCount    
  }

  func GSensorSet(_ fGSenX : Float, _ fGSenY : Float, _ fGSenZ : Float, _ fGSenPower : Float)
  {
    //----------------------------------------------------------------//
    //
    // GSen - X
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fGSenXNow = fGSenX
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fGSenXCount == 0)
    {
      self.fGSenXMin = fGSenX
      self.fGSenXMax = fGSenX
    }
    
    if(self.fGSenXMin > fGSenX)
    {
      self.fGSenXMin = fGSenX
    }
    
    if(self.fGSenXMax < fGSenX)
    {
      self.fGSenXMax = fGSenX
    }
    
    self.fGSenXSum   = self.fGSenXSum   + fGSenX
    self.fGSenXCount = self.fGSenXCount + 1
    self.fGSenXAvg   = self.fGSenXSum / self.fGSenXCount

    //----------------------------------------------------------------//
    //
    // GSen - Y
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fGSenYNow = fGSenY
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fGSenYCount == 0)
    {
      self.fGSenYMin = fGSenY
      self.fGSenYMax = fGSenY
    }
    
    if(self.fGSenYMin > fGSenY)
    {
      self.fGSenYMin = fGSenY
    }
    
    if(self.fGSenYMax < fGSenY)
    {
      self.fGSenYMax = fGSenY
    }
    
    self.fGSenYSum   = self.fGSenYSum   + fGSenY
    self.fGSenYCount = self.fGSenYCount + 1
    self.fGSenYAvg   = self.fGSenYSum / self.fGSenYCount

    //----------------------------------------------------------------//
    //
    // GSen - Z
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fGSenZNow = fGSenZ
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fGSenZCount == 0)
    {
      self.fGSenZMin = fGSenZ
      self.fGSenZMax = fGSenZ
    }
    
    if(self.fGSenZMin > fGSenZ)
    {
      self.fGSenZMin = fGSenZ
    }
    
    if(self.fGSenZMax < fGSenZ)
    {
      self.fGSenZMax = fGSenZ
    }
    
    self.fGSenZSum   = self.fGSenZSum   + fGSenZ
    self.fGSenZCount = self.fGSenZCount + 1
    self.fGSenZAvg   = self.fGSenZSum / self.fGSenZCount

    //----------------------------------------------------------------//
    //
    // GSen - G
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    let fGSenG : Float  = sqrt(fGSenX * fGSenX + fGSenY * fGSenY  + fGSenZ * fGSenZ)
    self.fGSenGNow = fGSenG
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fGSenGCount == 0)
    {
      self.fGSenGMin = fGSenG
      self.fGSenGMax = fGSenG
    }
    
    if(self.fGSenGMin > fGSenG)
    {
      self.fGSenGMin = fGSenG
    }
    
    if(self.fGSenGMax < fGSenG)
    {
      self.fGSenGMax = fGSenG
    }
    
    self.fGSenGSum   = self.fGSenGSum   + fGSenG
    self.fGSenGCount = self.fGSenGCount + 1
    self.fGSenGAvg   = self.fGSenGSum / self.fGSenGCount

    //----------------------------------------------------------------//
    //
    // GSen - Power
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//    
    self.fGSenPowerNow = fGSenPower
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fGSenPowerCount == 0)
    {
      self.fGSenPowerMin = fGSenPower
      self.fGSenPowerMax = fGSenPower
    }
    
    if(self.fGSenPowerMin > fGSenPower)
    {
      self.fGSenPowerMin = fGSenPower
    }
    
    if(self.fGSenPowerMax < fGSenPower)
    {
      self.fGSenPowerMax = fGSenPower
    }
    
    self.fGSenPowerSum   = self.fGSenPowerSum   + fGSenG
    self.fGSenPowerCount = self.fGSenPowerCount + 1
    self.fGSenPowerAvg   = self.fGSenPowerSum / self.fGSenPowerCount
  }

  func HrvSet(_ fHrvRR : Float, _ fHrvSdnn : Float, _ fHrvRmssd : Float, _ fHrvLFHF : Float, _ fHrvLFTP : Float, _ fHrvHFTP : Float)
  {
    //----------------------------------------------------------------//
    //
    // HRV-RR
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvRRNow = fHrvRR
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvRRCount == 0)
    {
      self.fHrvRRMin = fHrvRR
      self.fHrvRRMax = fHrvRR
    }
    
    if(self.fHrvRRMin > fHrvRR)
    {
      self.fHrvRRMin = fHrvRR
    }
    
    if(self.fHrvRRMax < fHrvRR)
    {
      self.fHrvRRMax = fHrvRR
    }
    
    self.fHrvRRSum   = self.fHrvRRSum   + fHrvRR
    self.fHrvRRCount = self.fHrvRRCount + 1
    self.fHrvRRAvg   = self.fHrvRRSum / self.fHrvRRCount

    //----------------------------------------------------------------//
    //
    // HRV-SDNN
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvSdnnNow = fHrvSdnn
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvSdnnCount == 0)
    {
      self.fHrvSdnnMin = fHrvSdnn
      self.fHrvSdnnMax = fHrvSdnn
    }
    
    if(self.fHrvSdnnMin > fHrvSdnn)
    {
      self.fHrvSdnnMin = fHrvSdnn
    }
    
    if(self.fHrvSdnnMax < fHrvSdnn)
    {
      self.fHrvSdnnMax = fHrvSdnn
    }
    
    self.fHrvSdnnSum   = self.fHrvSdnnSum   + fHrvSdnn
    self.fHrvSdnnCount = self.fHrvSdnnCount + 1
    self.fHrvSdnnAvg   = self.fHrvSdnnSum / self.fHrvSdnnCount

    //----------------------------------------------------------------//
    //
    // HRV-RMSSD
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvRmssdNow = fHrvRmssd
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvRmssdCount == 0)
    {
      self.fHrvRmssdMin = fHrvRmssd
      self.fHrvRmssdMax = fHrvRmssd
    }
    
    if(self.fHrvRmssdMin > fHrvRmssd)
    {
      self.fHrvRmssdMin = fHrvRmssd
    }
    
    if(self.fHrvRmssdMax < fHrvRmssd)
    {
      self.fHrvRmssdMax = fHrvRmssd
    }
    
    self.fHrvRmssdSum   = self.fHrvRmssdSum   + fHrvRmssd
    self.fHrvRmssdCount = self.fHrvRmssdCount + 1
    self.fHrvRmssdAvg   = self.fHrvRmssdSum / self.fHrvRmssdCount

    //----------------------------------------------------------------//
    //
    // HRV-LFHF
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvLFHFNow = fHrvLFHF
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvLFHFCount == 0)
    {
      self.fHrvLFHFMin = fHrvLFHF
      self.fHrvLFHFMax = fHrvLFHF
    }
    
    if(self.fHrvLFHFMin > fHrvLFHF)
    {
      self.fHrvLFHFMin = fHrvLFHF
    }
    
    if(self.fHrvLFHFMax < fHrvLFHF)
    {
      self.fHrvLFHFMax = fHrvLFHF
    }
    
    self.fHrvLFHFSum   = self.fHrvLFHFSum   + fHrvLFHF
    self.fHrvLFHFCount = self.fHrvLFHFCount + 1
    self.fHrvLFHFAvg   = self.fHrvLFHFSum / self.fHrvLFHFCount

    //----------------------------------------------------------------//
    //
    // HRV-LFTP
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvLFTPNow = fHrvLFTP
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvLFTPCount == 0)
    {
      self.fHrvLFTPMin = fHrvLFTP
      self.fHrvLFTPMax = fHrvLFTP
    }
    
    if(self.fHrvLFTPMin > fHrvLFTP)
    {
      self.fHrvLFTPMin = fHrvLFTP
    }
    
    if(self.fHrvLFTPMax < fHrvLFTP)
    {
      self.fHrvLFTPMax = fHrvLFTP
    }
    
    self.fHrvLFTPSum   = self.fHrvLFTPSum   + fHrvLFTP
    self.fHrvLFTPCount = self.fHrvLFTPCount + 1
    self.fHrvLFTPAvg   = self.fHrvLFTPSum / self.fHrvLFTPCount

    //----------------------------------------------------------------//
    //
    // HRV-HFTP
    //
    //----------------------------------------------------------------//
    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fHrvHFTPNow = fHrvHFTP
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fHrvHFTPCount == 0)
    {
      self.fHrvHFTPMin = fHrvHFTP
      self.fHrvHFTPMax = fHrvHFTP
    }
    
    if(self.fHrvHFTPMin > fHrvHFTP)
    {
      self.fHrvHFTPMin = fHrvHFTP
    }
    
    if(self.fHrvHFTPMax < fHrvHFTP)
    {
      self.fHrvHFTPMax = fHrvHFTP
    }
    
    self.fHrvHFTPSum   = self.fHrvHFTPSum   + fHrvHFTP
    self.fHrvHFTPCount = self.fHrvHFTPCount + 1
    self.fHrvHFTPAvg   = self.fHrvHFTPSum / self.fHrvHFTPCount
  }


  func BattSocSet(_ fBattSoc : Float)
  {
    //----------------------------------------------------------------//
    // Filter
    //----------------------------------------------------------------//
    if(fBattSoc <= HEALTH_INFO_BATT_SOC_MIN)
    {
      return
    }

    if(fBattSoc > HEALTH_INFO_BATT_SOC_MAX)
    {
      return
    }

    //----------------------------------------------------------------//
    // Now
    //----------------------------------------------------------------//
    self.fBattSocNow = fBattSoc
    
    //----------------------------------------------------------------//
    // Max and Min
    //----------------------------------------------------------------//    
    if(self.fBattSocCount == 0)
    {
      self.fBattSocMin = fBattSoc
      self.fBattSocMax = fBattSoc
    }
    
    if(self.fBattSocMin > fBattSoc)
    {
      self.fBattSocMin = fBattSoc
    }
    
    if(self.fBattSocMax < fBattSoc)
    {
      self.fBattSocMax = fBattSoc
    }
    
    self.fBattSocSum   = self.fBattSocSum   + fBattSoc
    self.fBattSocCount = self.fBattSocCount + 1
    self.fBattSocAvg   = self.fBattSocSum / self.fBattSocCount    
  }
   
  // Removed DB functionality
  
  func HealthInfoPrint()
  {

  }
}
