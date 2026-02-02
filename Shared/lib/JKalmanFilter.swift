//--------------------------------------------------------------------------------//
// @file  JKalmanFilter.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI

class JKalmanFilter
{
  var x : CGFloat = 0
  var y : CGFloat = 0
  var strLabel   : String = ""
  var colorLabel : Color  = Color.blue
  var fFontSize  : CGFloat = 12


  var xEst : Float = 0 
  var P : Float = 0    
  var Q : Float = 0    
  var R : Float = 0    
  
  init()
  {    
    self.KalmanInit()
  }
    
  deinit
  {
  }

  func KalmanInit()
  {
    // Kalman Filter Init
    xEst = 0.0;
    P = 1.0;   
    Q = 0.0001;
    R = 0.01;  
  }
  
  func KalmanQSet(_ fQ : Float)
  {
    self.Q = fQ
  }
  
  func KalmanRSet(_ fR : Float)
  {
    self.R = fR
  }

  func KalmanFilter(_ z : Float) -> Float
  {
    // Prediction
    let x_hat_minus : Float = xEst
    let P_minus     : Float = P + Q

    // Update
    let K : Float = P_minus / (P_minus + R)
    self.xEst = x_hat_minus + K * (z - x_hat_minus)
    self.P = (1 - K) * P_minus

    return self.xEst
  }
}
