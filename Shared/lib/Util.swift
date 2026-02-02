//--------------------------------------------------------------------------------
// @file  Util.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

class Util
{ 
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
    
  func TimeStringGet(_ iTimeSec : Int, _ iMS : Int) -> String
  {
    let iSec = iTimeSec % 60
    let iMinTotal = (iTimeSec - iSec) / 60
    let iMin = iMinTotal % 60
    let iHour = (iMinTotal - iMin) / 60
    let strTime = String(format : "%02d:", iHour) +
                  String(format : "%02d:", iMin)  +
                  String(format : "%02d_", iSec)  +
                  String(format : "%03d",  iMS)
    
    return strTime
  }
  
  func TimeStampAllGet(_ iTimeStampMS : Int64) -> String
  {
    let iMS  = Int(iTimeStampMS % 1000)
    let tNow = (iTimeStampMS - iTimeStampMS % 1000) / 1000
    let date = Date(timeIntervalSince1970: Double(tNow))
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
   
    //-----------------------------------//
    // Set current time
    //-----------------------------------//
    let iYear  = Int(components.year!)
    let iMonth = Int(components.month!)
    let iDay   = Int(components.day!)
    let iHour  = Int(components.hour!)
    let iMin   = Int(components.minute!)
    let iSec   = Int(components.second!)
    let strTime = String(format : "%04d", iYear) +
                  String(format : "%02d%02d-", iMonth, iDay) +
                  String(format : "%02d:%02d", iHour, iMin)  +
                  String(format : "%02d_%03d", iSec,iMS)
    
    return strTime
  }
  
  func TimeStampTimeGet(_ iTimeStampMS : Int64) -> String
  {
    let iMS  = Int(iTimeStampMS % 1000)
    let tNow = (iTimeStampMS - iTimeStampMS % 1000) / 1000
    let date = Date(timeIntervalSince1970: Double(tNow))
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
   
    //-----------------------------------//
    // Set current time
    //-----------------------------------//
    //let iYear  = Int(components.year!)
    //let iMonth = Int(components.month!)
    //let iDay   = Int(components.day!)
    let iHour  = Int(components.hour!)
    let iMin   = Int(components.minute!)
    let iSec   = Int(components.second!)
    let strTime = String(format : "%02d:",  iHour) +
                  String(format : "%02d:",  iMin)  +
                  String(format : "%02d.",  iSec)  +
                  String(format : "%03d",   iMS)
    return strTime
  }
  
  func StringPad(_ strData :String, _ iCount : Int) -> String
  {
    var strValue : String = strData
    while(TRUE)
    {
      if(strValue.count < iCount)
      {
        strValue = strValue + " "
      }
      else
      {
        break
      }
    }
    return strValue
  }
  
  func StringToBytes(_ strData :String) -> [UInt8]
  {
    let bArr : [UInt8] = Array(strData.utf8)
    return bArr
  }
  
  func StringToDouble(_ strData :String) -> Double
  {
    let fValue = (strData as NSString).doubleValue
    return fValue
  }

  func StringToFloat(_ strData :String) -> Float
  {
    let fValue = (strData as NSString).floatValue
    return fValue
  }
  
  func BytesToString(_ bData : [UInt8]) -> String
  {
    var str  : String = ""
    var idx : Int  = 0
    
    // [UInt8] to String
    for i in 0..<bData.count
    {
      if(bData[i] == 0)
      {
        break;
      }
      idx = i
    }
    str = String(decoding: bData[0...idx], as: UTF8.self)
    return str
  }
  
  func FloatToBytes(_ fVal : Float)->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: fVal, Array.init)
    return bArr
  }
  
  func BytesToFloat(_ bArr : [UInt8])->Float
  {
    let  fDataArr  = Data(bArr)
    let fVal : Float  = fDataArr.withUnsafeBytes { $0.load(as: Float.self) }
    return fVal
  }
  
  func IntToBytes(_ iVal : Int )->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: iVal, Array.init)
    return bArr
  }
  
  func BytesToInt(_ bArr : [UInt8])->Int
  {
    let  fDataArr  = Data(bArr)
    let iVal : Int  = fDataArr.withUnsafeBytes { $0.load(as: Int.self) }
    return iVal
  }
  
  func Int32ToBytes(_ iVal : Int32 )->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: iVal, Array.init)
    return bArr
  }
  
  func BytesToInt32(_ bArr : [UInt8])->Int32
  {
    let  fDataArr  = Data(bArr)
    let iVal : Int32  = fDataArr.withUnsafeBytes { $0.load(as: Int32.self) }
    return iVal
  }
  
  func UInt32ToBytes(_ dwVal : UInt32 )->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: dwVal, Array.init)
    return bArr
  }
  
  func BytesToUInt32(_ bArr : [UInt8])->UInt32
  {
    let  fDataArr  = Data(bArr)
    let dwVal : UInt32  = fDataArr.withUnsafeBytes { $0.load(as: UInt32.self) }
    return dwVal
  }

  func LineAngleGet(x1 : CGFloat, y1 : CGFloat, x2 : CGFloat, y2 : CGFloat) -> CGFloat
  {
    // Find Vector
    let fDX : CGFloat = x2 - x1
    let fDY : CGFloat = y2 - y1
    
    // Get the vector angle
    var fAngle : Double = atan2(fDY, fDX)

    fAngle = (fAngle  * 180) / .pi
        
    return fAngle
  }

  func ShannonEntropy(_ fDataArr: [Float], _ iBinNum: Int, _ fDataCount: Int) -> Float
  {
    // Check the data array is not empty
    guard fDataCount > 0, !fDataArr.isEmpty else { return 0.0 }

    // Find max and min
    let fValMin   : Float = fDataArr.min() ?? 0.0
    let fValMax   : Float = fDataArr.max() ?? 1.0
    
    // in case all data the same , it will divide zero
    guard fValMax > fValMin else { return 0.0 }
    
    let fBinWidth : Float = (fValMax - fValMin) / Float(iBinNum)
    var fEntropy  : Float = 0.0

    // Data count in each bin 
    var iBinCountArr : [Int] = [Int](repeating: 0, count: iBinNum)

    for fValue : Float in fDataArr
    {
      let iBinIndex : Int = min(iBinNum - 1, Int((fValue - fValMin) / fBinWidth))
      iBinCountArr[iBinIndex] = iBinCountArr[iBinIndex] + 1
    }
    
    // Find the fProbabilityArr in each bin using for loop
    var fProbabilityArr : [Float] = [Float](repeating: 0.0, count: iBinNum)
    for i : Int in 0..<iBinNum
    {
      fProbabilityArr[i] = Float(iBinCountArr[i]) / Float(fDataCount)
    }
    
    // Calculate Shannon Entropy    
    for probability : Float in fProbabilityArr
    {
      if probability > 0
      {
        fEntropy = fEntropy - probability * log2(probability)
      }
    }
    
    return fEntropy
  }

  func StringToBase64String(strText : String)->String
  {
    guard let data  = strText.data(using: .utf8) else
    {
      return ""
    }
            
    return data.base64EncodedString()
  }

  func DataToString(_ data : Data)->String
  {
    var staValue : String = ""
    if let strText  = String(data: data, encoding: .utf8)
    {
      staValue = strText
    }
    return staValue
  }

  func StringToData(_ strText : String)->Data
  {
    let data : Data = Data()
    if let dataText  = strText.data(using: .utf8)
    {
      return dataText
    }
    return data
  }

  func Base64StringToString(_ str64Text : String)->String
  {
    var strValue : String = ""
    if let data = Data(base64Encoded: str64Text)
    {
      if let strText  = String(data: data, encoding: .utf8)
      {
        strValue = strText
      }
    }            
    return strValue
  }
  
  func StringToBase64String(_ strText : String)->String
  {
    var strValue : String = ""
    let data =  self.StringToData(strText)    
    strValue = data.base64EncodedString()
    return strValue
  }
}

