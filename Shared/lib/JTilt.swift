//--------------------------------------------------------------------------------//
// @file  JTilt.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

class JTilt
{
  let PI : Float = 3.14159237
  var fPitch : Float = 0
  var fRoll  : Float = 0

  var kfX : JKalmanFilter = JKalmanFilter()
  var kfY : JKalmanFilter = JKalmanFilter()
  var kfZ : JKalmanFilter = JKalmanFilter()
  
  init()
  {    
    
  }
    
  deinit
  {
  }

  func TiltGet( _ fGsenX : Float, _ fGsenY : Float, _ fGsenZ : Float)  
  {
    var fN : Float = 0;
    var fD : Float = 0;
    
    let fAX : Float = self.kfX.KalmanFilter(fGsenX)
    let fAY : Float = self.kfX.KalmanFilter(fGsenY)
    let fAZ : Float = self.kfX.KalmanFilter(fGsenZ)

    var fPitchPI : Float = 0;
    var fRollPI : Float  = 0; 

    var p : Float = 0;
    var r : Float = 0; 

    ///------------------------------------------------------------------------///
    /// PITCH
    ///------------------------------------------------------------------------///
    fN = fAX * -1;
    fD = sqrtf(fAY * fAY + fAZ * fAZ);
    if(fD != 0)
    {
      p = atan2f(fN , fD); 
      fPitchPI = p;
    }

    ///------------------------------------------------------------------------///
    /// ROLL
    ///------------------------------------------------------------------------///
    fN = fAY;
    fD = fAZ;
    r = atan2f(fN, fD) * -1;
    fRollPI = r;

    self.fPitch = fPitchPI * 180 / self.PI;
    self.fRoll  = fRollPI  * 180 / self.PI;
  }
}
