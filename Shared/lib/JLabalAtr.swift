//--------------------------------------------------------------------------------//
// @file  JLabelAtr.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

class JLabelAtr : NSObject, Identifiable, ObservableObject
{
  var x           : CGFloat = 0
  var y           : CGFloat = 0
  var strLabel    : String  = ""
  var colorLabel  : Color   = Color.blue
  
  override init()
  {
    super.init()
  }
    
  deinit
  {
  }
}