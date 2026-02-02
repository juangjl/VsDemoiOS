//--------------------------------------------------------------------------------
// @file  JTM.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

class JTM
{
  var   iYear   : Int = 0
  var   iMonth  : Int = 0
  var   iDay    : Int = 0
  var   iHour   : Int = 0
  var   iMin    : Int = 0
  var   iSec    : Int = 0
  var   iMS     : Int = 0
  var   iTimeZoneSec: Int = 0
  var   t       : UInt32  = 0

  var   tLocal  : UInt32 = 0
  var   tGmt  : UInt32 = 0
  
  init()
  {
  }
    
  deinit
  {
  }
  
  func TimeStringGet(_ iTimeSec : Int) -> String
  {
    let iSec = iTimeSec % 60
    let iMinTotal = (iTimeSec - iSec) / 60
    let iMin = iMinTotal % 60
    let iHour = (iMinTotal - iMin) / 60
    let strTime = String(format : "%02d:", iHour) +
                  String(format : "%02d:", iMin)  +
                  String(format : "%02d", iSec)
    
    return strTime
  }

  func Copy(_ pJtm : JTM)
  {
    self.iYear        = pJtm.iYear
    self.iMonth       = pJtm.iMonth
    self.iDay         = pJtm.iDay
    self.iHour        = pJtm.iHour
    self.iMin         = pJtm.iMin
    self.iSec         = pJtm.iSec
    self.iMS          = pJtm.iMS
    self.iTimeZoneSec = pJtm.iTimeZoneSec
    self.t            = pJtm.t
    
    self.tLocal       = pJtm.tLocal
    self.tGmt         = pJtm.tGmt
  }

  func JTMTimeStringGet() -> String
  {
    let strTime : String = String(format : "%04d/%02d/%02d-%02d:%02d:%02d",
                                          self.iYear,
                                          self.iMonth,
                                          self.iDay,
                                          self.iHour,
                                          self.iMin,
                                          self.iSec)
    return strTime
  }
  
  func JTMLocalTimeGet(tNow : UInt32)
  {
    let date : Date = Date(timeIntervalSince1970: Double(tNow))
    let calendar : Calendar = Calendar.current
    let components : DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
   
    //-----------------------------------//
    // Set current time
    //-----------------------------------//
    self.iYear  = Int(components.year!)
    self.iMonth = Int(components.month!)
    self.iDay   = Int(components.day!)
    self.iHour  = Int(components.hour!)
    self.iMin   = Int(components.minute!)
    self.iSec   = Int(components.second!)
    self.t      = tNow;
  }
  
  func JTMLocalTimeShitGet() -> Int
  {
    self.iTimeZoneSec =  TimeZone.current.secondsFromGMT()
    return self.iTimeZoneSec
  }

  func JTMMakeTimeLocal(_ iYear : Int, _ iMonth : Int, _ iDay : Int, _ iHour : Int, _ iMin : Int, _ iSec : Int)
  {
    var tmTime = tm()

    let  iShift = self.JTMLocalTimeShitGet()

    self.iYear  = iYear
    self.iMonth = iMonth
    self.iDay   = iDay
    self.iHour  = iHour
    self.iMin   = iMin
    self.iSec   = iSec

    tmTime.tm_year  = Int32(self.iYear - 1900)
    tmTime.tm_mon   = Int32(self.iMonth - 1)
    tmTime.tm_mday  = Int32(self.iDay)
    tmTime.tm_hour  = Int32(self.iHour)
    tmTime.tm_min   = Int32(self.iMin)
    tmTime.tm_sec   = Int32(self.iSec)
    tmTime.tm_isdst = 0

    self.t = UInt32(mktime(&tmTime)) //+ UInt32(iShift)
    
    self.tLocal = self.t 
    self.tGmt = self.t - UInt32(iShift)
    // Uncomment the following lines if you want to print the result
    //print("\t [JTM] GMT TIME: \(iYear)/\(iMonth)/\(iDay)-\(iHour):\(iMin):\(iSec), UTC = \(pJtm.t)")    
    
  }

  func JTMMakeTimeGmt(_ iYear : Int, _ iMonth : Int, _ iDay : Int, _ iHour : Int, _ iMin : Int, _ iSec : Int)
  {
    var tmTime = tm()

    let iShift = self.JTMLocalTimeShitGet()

    self.iYear  = iYear
    self.iMonth = iMonth
    self.iDay   = iDay
    self.iHour  = iHour
    self.iMin   = iMin
    self.iSec   = iSec

    tmTime.tm_year  = Int32(self.iYear - 1900)
    tmTime.tm_mon   = Int32(self.iMonth - 1)
    tmTime.tm_mday  = Int32(self.iDay)
    tmTime.tm_hour  = Int32(self.iHour)
    tmTime.tm_min   = Int32(self.iMin)
    tmTime.tm_sec   = Int32(self.iSec)
    tmTime.tm_isdst = 0

    self.t      = UInt32(mktime(&tmTime)) - UInt32(iShift)
    self.tGmt   = self.t
    self.tLocal = self.tGmt + UInt32(iShift)

    // Uncomment the following lines if you want to print the result    
    //print("\t [JTM] GMT TIME: \(iYear)/\(iMonth)/\(iDay)-\(iHour):\(iMin):\(iSec), UTC = \(pJtm.t)")
  }
}

