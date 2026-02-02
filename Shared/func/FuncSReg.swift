//--------------------------------------------------------------------------------//
// @file  FuncSReg.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth

extension VsSDK
{
  func FuncSRegRead(_ strSRegName : String ) -> Bool
  {
    if(self.SReg.iCmdState != SREG_CMD_STATE_IDLE)
    {
      return FALSE
    }
    
    // clear data
    self.SReg.CleanData()
    
    // Command Set
    self.SReg.NameSet(strSRegName)
    
    // Action Set
    self.SReg.bAction = SREG_ACT_READ
    
    // set Cmd ON
    self.SReg.bCmdOn = TRUE
    self.SReg.iCmdUtcMS = Date().millisecondsSince1970
    
    // set issue
    self.SReg.iCmdState = SREG_CMD_STATE_ISSUE
    
    return TRUE
  }
  
  func FuncSRegWrite(_ strSRegName : String, _ strData : String) -> Bool
  {
    if(self.SReg.iCmdState != SREG_CMD_STATE_IDLE)
    {
      return FALSE
    }
    
    // clear data
    self.SReg.CleanData()
    
    // Command Set
    self.SReg.NameSet(strSRegName)
    
    // Data Set
    self.SReg.DataSet(strData)
    
    // Action Set
    self.SReg.bAction = SREG_ACT_WRITE
    
    // set Cmd ON
    self.SReg.bCmdOn = TRUE
    self.SReg.iCmdUtcMS = Date().millisecondsSince1970
        
    // set issue
    self.SReg.iCmdState = SREG_CMD_STATE_ISSUE
    
    return TRUE
  }
  
  func FuncSRegSend()
  {
    if(self.SReg.bAction == SREG_ACT_READ)
    {
      self.CmdSBleSRegRead(self.SReg)
    }
    else
    {
      self.CmdSBleSRegWrite(self.SReg)
    }
  }    
}
