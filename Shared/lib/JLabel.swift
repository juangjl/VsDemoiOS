//--------------------------------------------------------------------------------//
// @file  JLabel.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI

class JLabel : NSObject, Identifiable
{
  var x : CGFloat = 0
  var y : CGFloat = 0
  var strLabel   : String = ""
  var colorLabel : Color  = Color.blue
  var fFontSize  : CGFloat = 12
  
  override init()
  {
    super.init()
  }
    
  deinit
  {
  }
  
  func Copy(_ item : JLabel)
  {
    self.x = item.x
    self.y = item.y
    self.strLabel   = item.strLabel
    self.colorLabel = item.colorLabel
  }
}
