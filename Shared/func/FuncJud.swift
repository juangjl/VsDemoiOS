//--------------------------------------------------------------------------------//
// @file  FuncJud.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func FuncJudRead(_ strKey : String) -> String
  {
    let str = self.jud.StringGet(strKey)
    return str
  }
  
  func FuncJudWrite(_ strKey : String, _ strValue : String)
  {
    self.jud.StringSet(strKey, strValue)
  }
  
  func FuncJudReadSwitch(_ strKey : String) -> Bool
  {
    let str = self.jud.StringGet(strKey)
    if(str == "ON")
    {
      return TRUE
    }
    return FALSE
  }
  
  func FuncJudWriteSwitch(_ strKey : String, _ bValue : Bool)
  {
    var strValue : String = ""
    if(bValue == TRUE)
    {
      strValue = "ON"
    }
    else
    {
      strValue = "OFF"
    }
    self.jud.StringSet(strKey, strValue)
  }
  
  func FuncJudReadInt(_ strKey : String) -> Int
  {
    let strValue = self.jud.StringGet(strKey)
    var iValue : Int = -1
    iValue = (strValue as NSString).integerValue
    return iValue
  }
  
  func FuncJudWriteInt(_ strKey : String, _ iValue : Int)
  {
    let strValue : String = String(format :  "%d", iValue)
    self.jud.StringSet(strKey, strValue)
  }
  
  func FuncJudReadFloat(_ strKey : String) -> Float
  {
    let strValue = self.jud.StringGet(strKey)
    var fValue : Float = -1
    fValue = (strValue as NSString).floatValue
    return fValue
  }
  
  func FuncJudWriteFloat(_ strKey : String, _ fValue : Float)
  {
    let strValue : String = String(format :  "%f", fValue)
    self.jud.StringSet(strKey, strValue)
  }
  
  func FuncJudReadDouble(_ strKey : String) -> Double
  {
    let strValue = self.jud.StringGet(strKey)
    var fValue : Double = -1
    fValue = (strValue as NSString).doubleValue
    return fValue
  }
  
  func FuncJudWriteDouble(_ strKey : String, _ fValue : Double)
  {
    let strValue : String = String(format :  "%f", fValue)
    self.jud.StringSet(strKey, strValue)
  }
  
  func FuncJudPatch()
  {
    var strKey      : String = ""
    var strValue    : String = ""
    var strDefault  : String = ""
    
    //----------------------------------------------------------------//
    // JUD Patch : JUD_KEY_TEST_MAIN_KEY
    //----------------------------------------------------------------//
    strKey      = JUD_KEY_TEST_MAIN_KEY
    strDefault  = JUD_VAL_TEST_MAIN_KEY
    strValue = self.jud.StringGet(strKey)
    if(strValue == "")
    {
      self.jud.StringSet(strKey, strDefault)
    }
    
    //----------------------------------------------------------------//
    // JUD Patch : JUD_KEY_REPORT_JSON_PLAIN_FILE_SAVE_ON
    //----------------------------------------------------------------//
    strKey      = JUD_KEY_REPORT_JSON_PLAIN_FILE_SAVE_ON
    strDefault  = JUD_VAL_REPORT_JSON_PLAIN_FILE_SAVE_ON
    strValue = self.jud.StringGet(strKey)
    if(strValue == "")
    {
      self.jud.StringSet(strKey, strDefault)
    }

    //----------------------------------------------------------------//
    // JUD Patch : JUD_KEY_REPORT_PDF_PLAIN_FILE_SAVE_ON
    //----------------------------------------------------------------//
    strKey      = JUD_KEY_REPORT_PDF_PLAIN_FILE_SAVE_ON
    strDefault  = JUD_VAL_REPORT_PDF_PLAIN_FILE_SAVE_ON
    strValue = self.jud.StringGet(strKey)
    if(strValue == "")
    {
      self.jud.StringSet(strKey, strDefault)
    }

    //----------------------------------------------------------------//
    // JUD Patch : JUD_KEY_DATABASE_ENCRYPTION_ON
    //----------------------------------------------------------------//
    strKey      = JUD_KEY_DATABASE_ENCRYPTION_ON
    strDefault  = JUD_VAL_DATABASE_ENCRYPTION_ON
    strValue = self.jud.StringGet(strKey)
    if(strValue == "")
    {
      self.jud.StringSet(strKey, strDefault)
    }
  }

  func FuncJudInit()
  {
    // JUD INIT
    self.jud.JUDInit()
    
    // JUD PATCH
    self.FuncJudPatch()        
  }
}
