//--------------------------------------------------------------------------------//
// @file  JAFItem.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI

//----------------------------------------------------------------//
//
//  HR < BLOCK_HEART_RATE_MIN  for continous BLOCK_BEAT_COUNT beats or more
//
//----------------------------------------------------------------//
public let AF_HR_MIN_HEART_RATE_MIN            : Float = 50
public let AF_HR_MIN_HEART_RATE_MAX            : Float = 150
public let AF_HR_MIN_BEAT_COUNT                : Int   = 16
public let AF_HR_MIN_HEART_RATE_DELTA          : Float = 15

public let AF_HR_MIN_COLOR_SELECTED            : Color =  Color(red: 230 / 255, green: 230 / 255, blue: 125 / 255)
public let AF_HR_MIN_COLOR_CLICKED             : Color =  Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255)
public let AF_HR_MIN_COLOR_DEFAULT             : Color =  Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
public let AF_HR_MIN_COLOR_ADDITION            : Color =  Color(red: 255 / 255, green: 242 / 255, blue: 204 / 255)
public let AF_HR_MIN_COLOR_ADDITION_SELECTED   : Color =  Color(red: 218 / 255, green: 227 / 255, blue: 243 / 255)

public let AF_HR_MIN_COLOR_BTN_SELECT          : Color =  Color(red: 180 / 255, green: 180 / 255, blue:  30 / 255)
public let AF_HR_MIN_COLOR_BTN_DEFAULT         : Color =  Color(red: 160 / 255, green: 160 / 255, blue: 160 / 255)

//----------------------------------------------------------------//
//  AF
//----------------------------------------------------------------//
public let  REPORT_ITEM_AF_HR_LOWER_BOUND     : Float = 50.0
public let  REPORT_ITEM_AF_HR_UPPER_BOUND     : Float = 180.0
public let  REPORT_ITEM_AF_KEEP_PERIOD        : Float = 60.0
public let  REPORT_ITEM_AF_PERIOD             : Float = 60.0

class JAFItem  : NSObject , Identifiable, Codable
{
  //------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //------------------------------------------------------------------------------------------------//
  var iAFID         : Int     = 0
  var iReportID     : Int     = 0
  var iYear         : Int     = 0
  var iMonth        : Int     = 0
  var iDay          : Int     = 0
  var iHour         : Int     = 0
  var iMin          : Int     = 0
  var iSec          : Int     = 0
  var dwUtc         : UInt32  = 0 
  var bAFHROn       : Bool    = FALSE
	var iAFBeatCount  : Int     = 0
	var fAFT0         : Double  = 0
	var fAFT1         : Double  = 0
  var fAFT          : Double  = 0
	var fAFPeriod     : Double  = 0
  var fAFHRMin      : Float   = 999
  var fAFHRMax      : Float   = 0
  var fAFHRSum      : Float   = 0
  var fAFHRAvg      : Float   = 0
  var iExpired      : Int     = 0
  var iStatus       : Int     = 0  

  var iUtcHRMin     : Int64  = 0
  var iUtcHRMax     : Int64  = 0
    
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
  
  func Copy(_ item : JAFItem)
  {
    self.iAFID        = item.iAFID
    self.iReportID    = item.iYear
    self.iYear        = item.iYear
    self.iMonth       = item.iMonth
    self.iDay         = item.iDay
    self.iHour        = item.iHour
    self.iMin         = item.iMin
    self.iSec         = item.iSec
    self.dwUtc        = item.dwUtc
    self.bAFHROn      = item.bAFHROn
    self.iAFBeatCount = item.iAFBeatCount
    self.fAFT0        = item.fAFT0
    self.fAFT1        = item.fAFT1
    self.fAFT         = item.fAFT
    self.fAFPeriod    = item.fAFPeriod
    self.fAFHRMin     = item.fAFHRMin
    self.fAFHRMax     = item.fAFHRMax
    self.fAFHRSum     = item.fAFHRSum
    self.fAFHRAvg     = item.fAFHRAvg
    self.iExpired     = item.iExpired
    self.iStatus      = item.iStatus    

    self.iUtcHRMin   = item.iUtcHRMin    
    self.iUtcHRMax   = item.iUtcHRMax    
  }
  
  func AFItemPrint()
  {
    /*
    let strMsg =  String (format : "\t\t [AF-MIN] AID = %03d ~ %03d,",self.iAtrDataId,   self.iAtrDataId + self.iBeatCnt - 1) +
                  String (format : "BEATS = %d, ",    self.iBeatCnt)  +
                  String (format : "MAX = %0.2f, ",   self.fHRMax)    +
                  String (format : "MIN = %0.2f, ",   self.fHRMin)    +
                  String (format : "AVG = %0.2f, ",   self.fHRAvg)    +
                  String (format : "total %d sec",    self.iTotalSec)
    print(strMsg)
    */
  }
}
