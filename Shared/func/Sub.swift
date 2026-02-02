//--------------------------------------------------------------------------------//
// @file  Sub.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{ 
  //------------------------------------------------------------------------------------------------//
  // Sub Routines
  //------------------------------------------------------------------------------------------------//
  func SubVscModeFileSave()
  {
    var iCount : Int = 0
    var vscMode : VscModeCtlType? = VscModeCtlType()

    self.QueueFileVscMode.sync
    {
      iCount  = self.vscModeSaveQueue.count
    }

    if(self.bVscModeSave == FALSE)
    {
      return
    }
    
    if(iCount == 0)
    {
      return
    }
    for _ in 0..<iCount
    {
      self.QueueFileVscMode.sync  
      {
        vscMode = self.vscModeSaveQueue.removeFirst()
      }
      
      if let pVscMode = vscMode
      {
        self.FuncVscModeSave(pVscMode)
      }
    }
  }

  @objc func SubLoop()
  {
    if(self.bSubLoopOn == TRUE)
    {      
      return
    }
    self.bSubLoopOn = TRUE

    self.SubVscModeFileSave()

    self.bSubLoopOn = FALSE
  }
}
