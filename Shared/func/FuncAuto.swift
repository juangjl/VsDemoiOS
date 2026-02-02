//--------------------------------------------------------------------------------//
// @file  FuncAuto.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func FuncAutoMeasurementOn()
  {
    var strValue : String  = ""
    
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
        
    //----------------------------------------------------------------//
    // AUTO_MEASUREMENT_STATUS set
    //----------------------------------------------------------------//
    strValue = "ON"
    self.FuncJudWrite(JUD_KEY_AUTO_MEASUREMENT_STATUS, strValue)
    let strEnabled : String = self.FuncJudRead(JUD_KEY_VSC_FILE_MODE)
    if(strEnabled == "OFF")
    {
      _ = self.FuncSRegWrite(SREG_MONITOR_MEAS_ONLY, "ON")
    }
    self.bAutoMeasurementStatus = TRUE
  }
  
  func FuncAutoMeasurementOff()
  {
    var strValue : String  = ""
    
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
    
    //----------------------------------------------------------------//
    // AUTO_MEASUREMENT_STATUS set
    //----------------------------------------------------------------//
    strValue = "OFF"
    self.FuncJudWrite(JUD_KEY_AUTO_MEASUREMENT_STATUS, strValue)
    let strEnabled : String = self.FuncJudRead(JUD_KEY_VSC_FILE_MODE)
    if(strEnabled == "OFF")
    {
      _ = self.FuncSRegWrite(SREG_MONITOR_MEAS_ONLY, "OFF")
    }
    self.bAutoMeasurementStatus = FALSE
  }

  func FuncAutoMeasurementSet()
  {
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
    self.bAutuMeasurementExecute = TRUE
  }
  
  func FuncAutoMeasurementClear()
  {
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
    self.bAutuMeasurementExecute = FALSE
  }
  
  func FuncAutoMeasurementCheck()-> Bool
  {
    if(self.bAutoConnectOn == FALSE)
    {
      return FALSE
    }
    
    if((self.bAutoMeasurementStatus  == TRUE) &&
       (self.bAutuMeasurementExecute == TRUE))
    {
      self.FuncAutoMeasurementClear()
      return TRUE
    }
    
    return FALSE
  }
    
  func FuncAutoConnectOn()
  {
    var strValue : String  = ""
    
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
    
    //----------------------------------------------------------------//
    // AUTO_CONNECT_NAME SET
    //----------------------------------------------------------------//
    strValue = self.strAutoConnectName
    self.FuncJudWrite(JUD_KEY_AUTO_CONNECT_NAME, strValue)
    
    //----------------------------------------------------------------//
    // AUTO_CONNECT STATUS set
    //----------------------------------------------------------------//
    strValue = "ON"
    self.FuncJudWrite(JUD_KEY_AUTO_CONNECT_STATUS, strValue)
    
    self.bAutoConnectStatus = TRUE
    
    //self.DbgPrint(String(format : "\t\t [AUTO][ON] self.bAutoConnectStatus = %d \n", self.bAutoConnectStatus))
  }
  
  func FuncAutoConnectOff()
  {
    var strValue : String  = ""
    
    //----------------------------------------------------------------//
    // AUTO_CONNECT STATUS set
    //----------------------------------------------------------------//
    strValue = "OFF"
    self.FuncJudWrite(JUD_KEY_AUTO_CONNECT_STATUS, strValue)
    self.bAutoConnectStatus = FALSE
    
    //self.DbgPrint(String(format : "\t\t [AUTO][OFF] self.bAutoConnectStatus = %d \n", self.bAutoConnectStatus))
  }

  func FuncAutoConnectCheck()
  {
    if(self.bAutoConnectOn == FALSE)
    {
      return
    }
    // self.DbgPrint(String(format : "\t\t [AUTO] self.bAutoConnectStatus = %d \n", self.bAutoConnectStatus))
    
    if(self.bAutoConnectStatus  == TRUE)
    {
      self.iBleState = BLE_STATE_DISCONNECTED
      self.iViewId   = VIEW_ID_AUTO_CONNECTING
    }
  }
  
  func FuncAutoConnectInit()
  {
    self.bAutoConnectOn            = self.FuncJudReadSwitch(JUD_KEY_AUTO_CONNECT_ON)
    self.strAutoConnectName        = self.FuncJudRead(JUD_KEY_AUTO_CONNECT_NAME)
    self.bAutoConnectStatus        = self.FuncJudReadSwitch(JUD_KEY_AUTO_CONNECT_STATUS)
    self.bAutoMeasurementStatus    = self.FuncJudReadSwitch(JUD_KEY_AUTO_MEASUREMENT_STATUS)
    
    //----------------------------------------------------------------//
    // Removed DB functionality
  }
}
