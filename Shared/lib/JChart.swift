//--------------------------------------------------------------------------------//
// @file  JChartType.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI
import UIKit
import CoreGraphics

class JChartType
{
  //----------------------------------------------------------------//
  //
  // Variabls
  //
  //----------------------------------------------------------------//
  var bUIAccess     : Bool = FALSE
  var bLineUpdate   : Bool = FALSE
  
  var fCanvasWidth  : CGFloat = 600
  var fCanvasHeight : CGFloat = 240
    
  var fChartWidth   : CGFloat = 600
  var fChartHeight  : CGFloat = 240

  var iColCnt       : Int = 30
  var iRowCnt       : Int = 12
  
  var fChartX0      : CGFloat = 0
  var fChartY0      : CGFloat = 0
  
  var fCellWidth    : CGFloat = 0
  var fCellHeight   : CGFloat = 0
  
  var pathFrame     : Path = Path()
  var pathGrid      : Path = Path()
  var pathLine      : Path = Path()

  var path          : UIBezierPath = UIBezierPath()
  
  var fEcgMVFixed   : Float = 6
  var fXValMax      : Float = 3000
  var fYValMin      : Float = -3
  var fYValMax      : Float = 3
  var fYValAvg      : Float = 0
  var fYValAmp      : Float = 6
  var xLabelArr     : [JLabel] = [JLabel]()
  var yLabelArr     : [JLabel] = [JLabel]()
  //----------------------------------------------------------------//
  // X Value Fixed
  //----------------------------------------------------------------//
  var fXValMinFixed : Double = 0
  var fXValMaxFixed : Double = 0

  //----------------------------------------------------------------//
  // Y Value Fixed
  //----------------------------------------------------------------//
  var fYValMinFixed : Float = 0
  var fYValMaxFixed : Float = 0
  
  var labelArr : [JLabel] = [JLabel]()

  //----------------------------------------------------------------//
  //
  // Functions
  //
  //----------------------------------------------------------------//
  init()
  {
  }
    
  deinit
  {
  }
  
  func CanvasSet(fWidth : CGFloat, fHeight : CGFloat)
  {
    self.fCanvasWidth  = fWidth
    self.fCanvasHeight = fHeight
    self.fChartWidth   = self.fCanvasWidth
    self.fChartHeight  = self.fCanvasHeight
    
    self.fCellWidth    = self.fChartWidth  / CGFloat(self.iColCnt)
    self.fCellHeight   = self.fChartHeight / CGFloat(self.iRowCnt)
     
    self.FrameDraw()
    self.GridDraw()    
  }
  
  func FrameDraw()
  {
    var path : Path = Path()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.fCanvasWidth, y: 0))
    path.addLine(to: CGPoint(x: self.fCanvasWidth, y: self.fCanvasHeight))
    path.addLine(to: CGPoint(x: 0, y: self.fCanvasHeight))
    path.addLine(to: CGPoint(x: 0, y: 0))
    self.pathFrame = path
  }
  
  func GridDraw()
  {
    var path : Path = Path()
    var x0 : CGFloat = 0
    var y0 : CGFloat = 0
    
    var x1 : CGFloat = 0
    var y1 : CGFloat = 0
    
    // draw horizontal line
    for i : Int in 1..<self.iRowCnt 
    {
      x0 = self.fChartX0
      y0 = self.fChartY0  + CGFloat(i) * self.fCellHeight
      x1 = self.fChartX0  + self.fChartWidth
      y1 = y0
      path.move(to: CGPoint(x: x0, y: y0))
      path.addLine(to: CGPoint(x: x1, y: y1))
    }
    
    // draw vertical line
    for i in 1..<self.iColCnt 
    {
      x0 = self.fChartX0  + CGFloat(i) * self.fCellWidth
      y0 = self.fChartY0
      x1 = x0
      y1 = self.fChartY0  +  self.fChartHeight
      path.move(to: CGPoint(x: x0, y: y0))
      path.addLine(to: CGPoint(x: x1, y: y1))
    }
    
    self.pathGrid = path
  }
  
  func LineDraw(pDataSet : JDataSetType)
  {
    var path = Path()
    // Start and end coordinates of line
    var x0 : CGFloat = 0
    var y0 : CGFloat = 0
    
    var x1 : CGFloat = 0
    var y1 : CGFloat = 0
    
    var fYValMin : Float  =  100000000
    var fYValMax : Float  = -100000000
    var fYValSum : Float  = 0
    var fYValAvg : Float  = 0
    
    var fYValFixedMax : Float  = 0
    var fYValFixedMin : Float  = 0
    
    var fYVal : Float  = 0
    var fXVal : Float  = 0
    // ECG data point count
    let iDataCnt : Int = pDataSet.data.count
    // X-axis starting value (data starting point)
    let fXValMin   : Float = 0
    // X-axis ending value (data endpoint: 3000 points, 500Hz * 6s = 3000 (6 seconds of data))
    let fXValMax   : Float = self.fXValMax
    // X-axis width (data range)
    let fXValWidth : Float = fXValMax - fXValMin
    
    var fYValAmp : Float  = 0
    var fAmpHigh : Float  = 0
    var fAmpLow  : Float  = 0
    
    
    let fEcgAmpMV   : Float  = self.fEcgMVFixed
    let fEcgAmpHalf : Float  = fEcgAmpMV / 2
    
   
    if(iDataCnt == 0)
    {
      print("\t\t [CHART] no data")
      self.pathLine = Path()
      return
    }
    
    // Find Max and Min
    for i in 0..<iDataCnt
    {
      fYVal = pDataSet.data[i]
      
      if(fYVal < fYValMin)
      {
        fYValMin = fYVal
      }
      
      if(fYVal > fYValMax)
      {
        fYValMax = fYVal
      }
      fYValSum  = fYValSum + fYVal
    }
    
    // Get Y value average
    fYValAvg = fYValSum / Float(iDataCnt)
        
    fAmpHigh = (fYValMax  - fYValAvg);
    fAmpLow  = (fYValAvg  - fYValMin);
    
    if((fAmpHigh < fEcgAmpHalf) && (fAmpLow < fEcgAmpHalf))
    {
      fYValFixedMax = fEcgAmpHalf + fYValAvg;
      fYValFixedMin = fYValAvg - fEcgAmpHalf;
    }
    else
    {
      fYValFixedMax = fEcgAmpHalf + fYValAvg;
      fYValFixedMin = fYValAvg - fEcgAmpHalf;
    }
    
    fYValMax = fYValFixedMax
    fYValMin = fYValFixedMin
    
    fYValAmp = fYValFixedMax - fYValFixedMin
    
    self.fYValMin = fYValMin
    self.fYValMax = fYValMax
    self.fYValAvg = fYValAvg
    self.fYValAmp = fYValAmp   
    
    for i : Int in 0..<iDataCnt
    {
      fYVal = pDataSet.data[i]
      fXVal = Float(i)
      x0 = x1
      y0 = y1
      
      //----------------------------------------------------------------//
      // Assume data range = 6000 points, chart width = 600 pixels
      // 6000 data points → compressed to → 600 pixel width, ratio = 600 ÷ 6000 = 0.1
      //        ECG data points:    0    1000   2000   3000   4000   5000   6000
      //                            ↓      ↓      ↓      ↓      ↓      ↓      ↓
      //        Screen X coordinates: 0   100    200    300    400    500    600
      //                            │      │      │      │      │      │      │
      //        Chart position:  Left     1/6    2/6   Center  4/6    5/6  Right border
      //----------------------------------------------------------------//
      x1 = CGFloat(fXVal - fXValMin) * self.fChartWidth / CGFloat(fXValWidth) + self.fChartX0
      // Y-axis applies the same scaling conversion as X-axis
      y1 = self.fChartHeight - CGFloat(fYVal - fYValMin) * self.fChartHeight / CGFloat(fYValAmp) + self.fChartY0;
      
      // avoid draw out of the chart
      if(x1 <= 0)
      {
        x1 = 0
      }
      if(x1 > fChartWidth)
      {
        x1 = fChartWidth
      }
      
      if(y1 <= 0)
      {
        y1 = 0
      }
      if(y1 > fChartHeight)
      {
        y1 = fChartHeight
      }
           
      if(i == 0)
      {
        path.move(to: CGPoint(x: x0, y: y0))
        continue
      }
      path.addLine(to: CGPoint(x: x1, y: y1))
    }
    
    self.pathLine = path
  }
  
  func LineMaxMinDraw(_ fYValMinArr : [Float], _ fYValAvgArr : [Float], _ fYValMaxArr : [Float], _ fXValArr : [Double])
  {
    var path : Path = Path()
    
    var x0   : CGFloat = 0
    var y0   : CGFloat = 0
    
    var x1   : CGFloat = 0
    var y1   : CGFloat = 0
    
    let iDataCount : Int = fXValArr.count

    let fYValWidth : Float  = (self.fYValMaxFixed - self.fYValMinFixed)
    
    let fXValMin   : Double  = self.fXValMinFixed
    let fXValWidth : Double  = self.fXValMaxFixed - self.fXValMinFixed
    
    var iLineCount : Int     = 0
        
    //print(String(format : "%@", "-------- CHART MAX / MIN INFO [START] --------"))
    //print(String(format : "\t COUNT             = %d",    iDataCount))
    //print(String(format : "\t X-VAL-MAX-FIXED   = %0.2f", self.fXValMaxFixed))
    //print(String(format : "\t X-VAL-MIN-FIXED   = %0.2f", self.fXValMinFixed))
    //print(String(format : "\t Y-VAL-MAX-FIXED   = %0.2f", self.fYValMaxFixed))
    //print(String(format : "\t Y-VAL-MIN-FIXED   = %0.2f", self.fYValMinFixed))
    //print(String(format : "\t CANVAS_WIDTH      = %0.2f", self.fCanvasWidth))
    //print(String(format : "\t CANVAS_HEIGHT     = %0.2f", self.fCanvasHeight))
    //print(String(format : "\t CHART_WIDTH       = %0.2f", self.fChartWidth))
    //print(String(format : "\t CHART_HEIGHT      = %0.2f", self.fChartHeight))
    //print(String(format : "\t CHART_X0          = %0.2f", self.fChartX0))
    //print(String(format : "\t CHART_Y0          = %0.2f", self.fChartY0))
    //print(String(format : "%@", "-------- CHART CHART MAX / MIN INFO [END] --------"))
            
    for i : Int in 0..<iDataCount
    {
      let fYValMin   : Float = fYValMinArr[i]
      let fYValAvg   : Float = fYValAvgArr[i]
      let fYValMax   : Float = fYValMaxArr[i]

      let fXVal      : Double = fXValArr[i]
      
      let fXValDelta : Double = fXVal - fXValMin
      
      //----------------------------------------------------------------//
      // Draw a verticle line
      //----------------------------------------------------------------//
      x0 = CGFloat(fXValDelta) / CGFloat(fXValWidth) *  self.fChartWidth + self.fChartX0
      y0 = self.fChartHeight - CGFloat(fYValMax - self.fYValMinFixed) * self.fChartHeight / CGFloat(fYValWidth) + self.fChartY0

      x1 = x0
      y1 = self.fChartHeight - CGFloat(fYValMin - self.fYValMinFixed) * self.fChartHeight / CGFloat(fYValWidth) + self.fChartY0
      
      //----------------------------------------------------------------//
      // Avoid to draw out of the chart
      //----------------------------------------------------------------//
      if(x0 <= 0)
      {
        x0 = 0
      }
      if(x0 > fChartWidth)
      {
        x0 = fChartWidth
      }

      if(y0 <= 0)
      {
        y0 = 0
      }
      if(y0 > fChartHeight)
      {
        y0 = fChartHeight
      }

      if(x1 <= 0)
      {
        x1 = 0
      }
      if(x1 > fChartWidth)
      {
        x1 = fChartWidth
      }
      
      if(y1 <= 0)
      {
        y1 = 0
      }
      if(y1 > fChartHeight)
      {
        y1 = fChartHeight
      }
            
      path.move(to : CGPoint(x : x0, y : y0))
      path.addLine(to : CGPoint(x : x1, y : y1))
      
      iLineCount = iLineCount + 1
      //print(String(format : "\t\t LINE %02d : (%0.1f, %0.1f) -> (%0.1f, %0.1f)", iLineCount, x0, y0, x1, y1))

      //----------------------------------------------------------------//
      // Draw filled circle at Avg Val position
      //----------------------------------------------------------------//
      let fRadius     : CGFloat = 4
      let fRadiusHalf : CGFloat = fRadius / 2
      var x2 : CGFloat = x0
      var y2 : CGFloat = self.fChartHeight - CGFloat(fYValAvg - self.fYValMinFixed) * self.fChartHeight / CGFloat(fYValWidth) + self.fChartY0
      
      if(x2 <= 0)
      {
        x2 = 0
      }
      if(x2 > fChartWidth)
      {
        x2 = fChartWidth
      }
            
      if(y2 <= 0)
      {
        y2 = 0
      }
      if(y2 > fChartHeight)
      {
        y2 = fChartHeight
      }            

      var subPath : Path = Path()
      subPath.addEllipse(in: CGRect(x: x2 - fRadiusHalf, y: y2 - fRadiusHalf, width: fRadius, height: fRadius))
                              
      path.addPath(subPath)
    }
    
    self.pathLine = path 
  }  

  func LabelClear()
  {
    if(self.bUIAccess == FALSE)
    {
      self.labelArr = [JLabel]()
    }
  }
  
  func LabelAdd(_ fXRatio : Float, _ fYRatio : Float, _ strLabel : String)
  {
    let labelObj :JLabel = JLabel()
    let fWidth  : CGFloat = self.fChartWidth
    let fHeight : CGFloat = self.fChartHeight
    
    labelObj.x = fWidth  * CGFloat(fXRatio) + self.fChartX0
    labelObj.y = fHeight * (1 -  CGFloat(fYRatio)) + self.fChartY0
    
    labelObj.strLabel = strLabel
    if(strLabel != ABBREV_NORMAL)
    {
      labelObj.colorLabel = Color.red
    }

    self.labelArr.append(labelObj)
  }

  func LabelXDraw(_ iTimeStart: Int64, _ iTimeEnd: Int64)
  {
    var fX0         : CGFloat = 0
    var fY0         : CGFloat = 0
    var strTimeLabel: String = ""
    let fYMargin    : CGFloat = 10
    
    self.xLabelArr = [JLabel]()
    
    // Date formatter setup
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    
    // Grid alignment calculations
    let fGridCellWidth : CGFloat = self.fChartWidth / CGFloat(self.iColCnt)
    let iTimePerCell   : Int64 = (iTimeEnd - iTimeStart) / Int64(self.iColCnt)
    
    // Define target positions: 0 and 30
    let iTargetPositions : [Int] = [0, self.iColCnt]
    
    for iGridIndex : Int in iTargetPositions
    {
      // Time calculation for current grid position
      let iCurrentTime : Int64 = iTimeStart + Int64(iGridIndex) * iTimePerCell
      
      // X coordinate calculation
      fX0 = self.fChartX0 + CGFloat(iGridIndex) * fGridCellWidth
      fY0 = self.fChartY0 + self.fChartHeight + fYMargin
      
      // Time string formatting
      let timeInterval : TimeInterval = TimeInterval(iCurrentTime / 1000)
      let dateObject   : Date = Date(timeIntervalSince1970 : timeInterval)
      strTimeLabel = dateFormatter.string(from : dateObject)
      
      // Create and configure label
      let labelObject : JLabel = JLabel()
      labelObject.x = fX0
      labelObject.y = fY0
      labelObject.strLabel = strTimeLabel
      self.xLabelArr.append(labelObject)
    }
  }
  
  func LabelYDraw()
  {
    var x0        : CGFloat = 0
    var y0        : CGFloat = 0
    var str       : String = ""
    let iXMargin  : CGFloat = 15
    let iRow      : Int = self.iRowCnt
    var i         : Int = 0
    let fDeltaVal : Float = (self.fYValMax - self.fYValMin) / Float(iRow)
    
    self.yLabelArr = [JLabel]()
    
    //----------------------------------------------------------------//
    // start label (min)
    //----------------------------------------------------------------//
    i = 0
    str = String(format : "%.2f", self.fYValMin + Float(i) * fDeltaVal)
    x0 = self.fChartX0 - iXMargin
    y0 = self.fChartY0 + self.fChartHeight
    
    let label1 = JLabel()
    label1.x = x0
    label1.y = y0
    label1.strLabel = str
    self.yLabelArr.append(label1)
    
    //----------------------------------------------------------------//
    // center label (middle)
    //----------------------------------------------------------------//
    i = iRow / 2
    str = String(format: "%.2f", self.fYValMin + Float(i) * fDeltaVal)
    x0 = self.fChartX0 - iXMargin
    y0 = self.fChartY0 + self.fChartHeight / 2
    
    let label2 = JLabel()
    label2.x = x0
    label2.y = y0
    label2.strLabel = str
    self.yLabelArr.append(label2)
    
    //----------------------------------------------------------------//
    // end label (max)
    //----------------------------------------------------------------//
    str = String(format: "%.2f", self.fYValMax)
    x0 = self.fChartX0 - iXMargin
    y0 = self.fChartY0
    
    let label3 = JLabel()
    label3.x = x0
    label3.y = y0
    label3.strLabel = str
    self.yLabelArr.append(label3)
  }
}

