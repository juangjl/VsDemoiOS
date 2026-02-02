//--------------------------------------------------------------------------------//
// @file  ViewCanvas.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

let CHART_ID_BLE_ECG0                             : Int = 0
let CHART_ID_BLE_ECG2                             : Int = 1
let CHART_ID_BLE_GSEN_X                           : Int = 2
let CHART_ID_BLE_GSEN_Y                           : Int = 3
let CHART_ID_BLE_GSEN_Z                           : Int = 4
let CHART_ID_FILE_ECG0                            : Int = 5
let CHART_ID_FILE_ECG2                            : Int = 6
let CHART_ID_FILE_GSEN_X                          : Int = 7
let CHART_ID_FILE_GSEN_Y                          : Int = 8
let CHART_ID_FILE_GSEN_Z                          : Int = 9

let CHART_ID_REPORT_ECG_00_SETUP                  : Int = 10  //< REPORT_CHART_ID_SETUP               
let CHART_ID_REPORT_ECG_01_AF_HR_MIN              : Int = 11  //< REPORT_CHART_ID_AF_HR_MIN
let CHART_ID_REPORT_ECG_02_AF_HR_MAX              : Int = 12  //< REPORT_CHART_ID_AF_HR_MAX
let CHART_ID_REPORT_ECG_03_SVT                    : Int = 13  //< REPORT_CHART_ID_SVT
let CHART_ID_REPORT_ECG_04_VT                     : Int = 14  //< REPORT_CHART_ID_VT
let CHART_ID_REPORT_ECG_05_BLOCK                  : Int = 15  //< REPORT_CHART_ID_BLOCK
let CHART_ID_REPORT_ECG_06_SINUS_HR_MIN           : Int = 16  //< REPORT_CHART_ID_SINUS_HR_MIN
let CHART_ID_REPORT_ECG_07_SINUS_HR_MAX           : Int = 17  //< REPORT_CHART_ID_SINUS_HR_MAX
let CHART_ID_REPORT_ECG_08_ECTOPIC_ISOLATED       : Int = 18  //< REPORT_CHART_ID_ECTOPIC_ISOLATED
let CHART_ID_REPORT_ECG_09_ECTOPIC_COUPLET        : Int = 19  //< REPORT_CHART_ID_ECTOPIC_COUPLET
let CHART_ID_REPORT_ECG_10_ECTOPIC_TRIPLET        : Int = 20  //< REPORT_CHART_ID_ECTOPIC_TRILET
let CHART_ID_REPORT_ECG_11_ECTOPIC_MULTIPLE       : Int = 21  //< REPORT_CHART_ID_ECTOPIC_MULTIPLE
let CHART_ID_REPORT_ECG_12_PAUSE                  : Int = 22  //< REPORT_CHART_ID_PAUSE
let CHART_ID_REPORT_ECG_13_BRADY                  : Int = 23  //< REPORT_CHART_ID_BRADY
let CHART_ID_REPORT_ECG_14_TACHY                  : Int = 24  //< REPORT_CHART_ID_TACHY
let CHART_ID_REPORT_ECG_15_TRIGGER_1              : Int = 25  //< REPORT_CHART_ID_TRIGGER_1
let CHART_ID_REPORT_ECG_16_TRIGGER_2              : Int = 26  //< REPORT_CHART_ID_TRIGGER_2
let CHART_ID_REPORT_ECG_17_TRIGGER_3              : Int = 27  //< REPORT_CHART_ID_TRIGGER_3
let CHART_ID_REPORT_ECG_18_TRIGGER_4              : Int = 28  //< REPORT_CHART_ID_TRIGGER_4
let CHART_ID_REPORT_ECG_19_ADDITION_1             : Int = 29  //< REPORT_CHART_ID_ADDITION_1
let CHART_ID_REPORT_ECG_20_ADDITION_2             : Int = 30  //< REPORT_CHART_ID_ADDITION_2
let CHART_ID_REPORT_ECG_21_ADDITION_3             : Int = 31  //< REPORT_CHART_ID_ADDITION_3
let CHART_ID_REPORT_ECG_22_ADDITION_4             : Int = 32  //< REPORT_CHART_ID_ADDITION_4

let CHART_ID_REPORT_START                         : Int = CHART_ID_REPORT_ECG_00_SETUP
let CHART_ID_REPORT_END                           : Int = CHART_ID_REPORT_ECG_22_ADDITION_4

// Multiple Chart Constant
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE   : Int = 33  //REPORT_CHART_ID_AF_HR_MAX_MULTI_BASE
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_0      : Int = 33  // REPORT_CHART_ID_AF_HR_MAX_MULTI_0
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_1      : Int = 34  // REPORT_CHART_ID_AF_HR_MAX_MULTI_1
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_2      : Int = 35  // REPORT_CHART_ID_AF_HR_MAX_MULTI_2
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_3      : Int = 36  // REPORT_CHART_ID_AF_HR_MAX_MULTI_3
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_4      : Int = 37  // REPORT_CHART_ID_AF_HR_MAX_MULTI_4
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_5      : Int = 38  // REPORT_CHART_ID_AF_HR_MAX_MULTI_5
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_6      : Int = 39  // REPORT_CHART_ID_AF_HR_MAX_MULTI_6
let CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_7      : Int = 40  // REPORT_CHART_ID_AF_HR_MAX_MULTI_7

struct ViewCanvas : View
{
  let timer = Timer.publish(every: 0.05, on: .current, in: .common).autoconnect()

  //-------------------------------------------//
  // Variable passed in
  //-------------------------------------------//
  var iChartId  : Int
  var fCanvasWidth  : CGFloat
  var fCanvasHeight : CGFloat
  
  var vsSDK = VsSDK.shared
  
  var iColCnt  : Int = 30
  var iRowCnt  : Int = 12

  var iColSubCnt  : Int = 30 * 5
  var iRowSubCnt  : Int = 12 * 5
 
  var fChartX0  : CGFloat = 0
  var fChartY0  : CGFloat = 0
      
  var fChartWidth  : CGFloat
  {
    let fWidth : CGFloat = self.fCanvasWidth
    return fWidth
  }
  
  var fChartHeight : CGFloat
  {
    let fHeight : CGFloat = self.fCanvasHeight
    return fHeight
  }    
  
  var pathFrame  : Path
  {
    if(self.iChartId == CHART_ID_BLE_ECG0)
    {
      return  self.vsSDK.chartBleEcg0.pathFrame
    }
    if(self.iChartId == CHART_ID_FILE_ECG0)
    {
      return  self.vsSDK.chartFileEcg0.pathFrame
    }
    
    //----------------------------------------------------------------//
    // Draw Report line for Single Chart (10 - 32)
    //----------------------------------------------------------------//
    if((self.iChartId >= CHART_ID_REPORT_ECG_00_SETUP) && (self.iChartId <= CHART_ID_REPORT_END))
    {
      let id : Int = self.iChartId - CHART_ID_REPORT_ECG_00_SETUP
      return  self.vsSDK.chartReportEcgArr[id].pathFrame
    }
    
    //----------------------------------------------------------------//
    // Draw Report line for Multiple Chart (33 - 40)
    //----------------------------------------------------------------//
//    if (self.iChartId >= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE) && (self.iChartId <= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_7)
//    {
//      // 33-37 → 0-4
//      let iChartIndex = self.iChartId - CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE
//      // 0-4 → 23-27
//      let id = REPORT_CHART_ID_AF_HR_MAX_MULTI_BASE + iChartIndex
//      return self.vsSDK.chartReportEcgArr[id].pathFrame
//    }
    
    return  self.vsSDK.chartBleEcg0.pathFrame
  }
  
  var pathGridSub  : Path
  {   
    var path : Path = Path()     
      
    var x0   : CGFloat = 0
    var y0   : CGFloat = 0
    
    var x1   : CGFloat = 0
    var y1   : CGFloat = 0
    
    let fChartWidth   : CGFloat = self.fChartWidth
    
    var iRowCnt: Int = 12
    var iColCnt: Int = 30
     
    //----------------------------------------------------------------//
    // Handle Single Chart (10 - 32)
    //----------------------------------------------------------------//
    if((self.iChartId >= CHART_ID_REPORT_ECG_00_SETUP) && (self.iChartId  <= CHART_ID_REPORT_END))
    {
      let id = iChartId - CHART_ID_REPORT_ECG_00_SETUP
      iRowCnt = self.vsSDK.chartReportEcgArr[id].iRowCnt
      iColCnt = self.vsSDK.chartReportEcgArr[id].iColCnt
    }    
    else
    {
      return Path()  
    }
   
    let iRowSubCnt: Int = iRowCnt * 5
    let iColSubCnt: Int = iColCnt * 5
    
    let fSubCellWidth: CGFloat = fChartWidth / CGFloat(iColSubCnt)
    let fSubCellHeight: CGFloat = fSubCellWidth
        
    // draw horizontal line
    for i : Int in 0..<iRowSubCnt
    {
      x0 = self.fChartX0
      y0 = self.fChartY0  + CGFloat(i) * fSubCellHeight
      x1 = self.fChartX0  + self.fChartWidth
      y1 = y0
      path.move(to: CGPoint(x: x0, y: y0))
      path.addLine(to: CGPoint(x: x1, y: y1))
    }
    
    // draw vertical line
    for i : Int in 0..<iColSubCnt
    {
      x0 = self.fChartX0  + CGFloat(i) * fSubCellWidth
      y0 = self.fChartY0
      x1 = x0
      y1 = self.fChartY0 + CGFloat(iRowSubCnt) * fSubCellHeight
      path.move(to: CGPoint(x: x0, y: y0))
      path.addLine(to: CGPoint(x: x1, y: y1))
    }            
    return path
  }

  var pathGrid  : Path
  {        
    if(self.iChartId == CHART_ID_BLE_ECG0)
    {
      return self.vsSDK.chartBleEcg0.pathGrid
    }
    if(self.iChartId == CHART_ID_FILE_ECG0)
    {
      return self.vsSDK.chartFileEcg0.pathGrid
    }
        
    //----------------------------------------------------------------//
    // Handle Single Chart (10 - 32)
    //----------------------------------------------------------------//
    if((self.iChartId >= CHART_ID_REPORT_ECG_00_SETUP) && (self.iChartId <= CHART_ID_REPORT_END))
    {
      let  id : Int = iChartId - CHART_ID_REPORT_ECG_00_SETUP
      return self.vsSDK.chartReportEcgArr[id].pathGrid
    }
      
//    //----------------------------------------------------------------//
//    // Handle Multiple Chart (33 - 40)
//    //----------------------------------------------------------------//
//    if (self.iChartId >= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE) && (self.iChartId <= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_7)
//    {
//      // 33-37 → 0-4
//      let iChartIndex = self.iChartId - CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE
//      // 0-4 → 23-27
//      let id = REPORT_CHART_ID_AF_HR_MAX_MULTI_BASE + iChartIndex
//      return self.vsSDK.chartReportEcgArr[id].pathGrid
//    }

    return self.vsSDK.chartBleEcg0.pathGrid
  }
  
  var strUnitLabel : String
  {
    var strUnit : String = ""
    
    if((self.iChartId == CHART_ID_BLE_ECG0) || (self.iChartId == CHART_ID_FILE_ECG0))
    {
      strUnit = ECG_DISPLAY_RANGE_LABEL_ARR[self.vsSDK.iEcgDisplayRange]
    }
    return strUnit
  }

  var strModeLabel : String
  {
    var strMode : String = ""
    
    if((self.iChartId == CHART_ID_BLE_ECG0) || (self.iChartId == CHART_ID_FILE_ECG0))
    {
      if(self.vsSDK.bVscFileModeEnable == TRUE)
      {
        strMode = "+"
      }
      else
      {
        strMode = ""
      }
    }

    return strMode
  }
  
  @State var pathLine0 : Path = Path()
  
  // 30 labels at most
  @State var labelAtrArr0 : [JLabelAtr] = [JLabelAtr]()  //< label 00-09
  @State var labelAtrArr1 : [JLabelAtr] = [JLabelAtr]()  //< label 10-19
  @State var labelAtrArr2 : [JLabelAtr] = [JLabelAtr]()  //< label 20-29
  
  @State var xLabelArr : [JLabelAtr] = [JLabelAtr]()
  @State var yLabelArr : [JLabelAtr] = [JLabelAtr]()
  
  @State var fValueFontSize     : CGFloat = 12
  
  var fLabelFontSize    : CGFloat = 12
  var fLabelFontSizeXS  : CGFloat = 6
  
  
  var pathLineEcg1 : Path
  {
    return self.vsSDK.chartBleEcg1.pathLine
  }

  //----------------------------------------------------------------//
  //
  // Functions
  //
  //----------------------------------------------------------------//
  func LabelGet()
  {

  }
  
  func OnAppear()
  {
    let fViewWidth  : CGFloat = UIScreen.main.bounds.width
    if(fViewWidth < 420)
    {
      self.fValueFontSize = self.fLabelFontSizeXS
    }
    else if(fViewWidth > 640)
    {
      self.fValueFontSize = self.fLabelFontSize
    }
  }

  func OnTimer()
  {
    var labels : [JLabel]? = [JLabel]()
    var xLabels : [JLabel]? = [JLabel]()
    var yLabels : [JLabel]? = [JLabel]()
    
    if(self.iChartId == CHART_ID_BLE_ECG0)
    {            
      if(self.vsSDK.chartBleEcg0.bLineUpdate == FALSE)
      {
        return
      }
      self.vsSDK.chartBleEcg0.bLineUpdate = FALSE
      self.vsSDK.chartBleEcg0.bUIAccess = TRUE

      let pathline : Path? = self.vsSDK.chartBleEcg0.pathLine
      if let pathline
      {
        let copiedPathLine = Path { path in
            path.addPath(pathline)
        }
        self.pathLine0 = copiedPathLine
        //self.pathLine0 = pathline
      }
      
      let labelArr : [JLabel]? = self.vsSDK.chartBleEcg0.labelArr
      let xLabelArr : [JLabel]? = self.vsSDK.chartBleEcg0.xLabelArr
      let yLabelArr : [JLabel]? = self.vsSDK.chartBleEcg0.yLabelArr
      if let labelArr
      {
        labels = labelArr
      }

      if let xLabelArr
      {
        xLabels = xLabelArr
      }
      if let yLabelArr
      {
        yLabels = yLabelArr
      }
    }
    
    if(self.iChartId == CHART_ID_FILE_ECG0)
    {
      self.vsSDK.chartFileEcg0.bUIAccess = TRUE
      self.pathLine0 = self.vsSDK.chartFileEcg0.pathLine
      labels = self.vsSDK.chartFileEcg0.labelArr
      xLabels = self.vsSDK.chartFileEcg0.xLabelArr
      yLabels = self.vsSDK.chartFileEcg0.yLabelArr
    }
    
    //----------------------------------------------------------------//
    // Handle Single Chart (10 - 32)
    //----------------------------------------------------------------//
    if((self.iChartId >= CHART_ID_REPORT_ECG_00_SETUP) && (self.iChartId  <= CHART_ID_REPORT_END))
    {
      let iChartReportId : Int = self.iChartId  - CHART_ID_REPORT_ECG_00_SETUP
        
      self.pathLine0 = self.vsSDK.chartReportEcgArr[iChartReportId].pathLine
      labels         = self.vsSDK.chartReportEcgArr[iChartReportId].labelArr
      xLabels = self.vsSDK.chartReportEcgArr[iChartReportId].xLabelArr
      yLabels = self.vsSDK.chartReportEcgArr[iChartReportId].yLabelArr
    }
    
    //----------------------------------------------------------------//
    // Handle Multiple Chart (33 - 40)
    //----------------------------------------------------------------//
//    if (self.iChartId >= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE) && (self.iChartId <= CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_7)
//    {
//
//      let iChartIndex = self.iChartId - CHART_ID_REPORT_ECG_02_AF_HR_MAX_MULTI_BASE  // 33-37 → 0-4
//      let iChartReportId = REPORT_CHART_ID_AF_HR_MAX_MULTI_BASE + iChartIndex  // 0-4 → 23-27
//      
//      self.pathLine0 = self.vsSDK.chartReportEcgArr[iChartReportId].pathLine
//      labels         = self.vsSDK.chartReportEcgArr[iChartReportId].labelArr
//      xLabels = self.vsSDK.chartReportEcgArr[iChartReportId].xLabelArr
//      yLabels = self.vsSDK.chartReportEcgArr[iChartReportId].yLabelArr
//    }

    if let labels
    {
      self.labelAtrArr0.removeAll()
      self.labelAtrArr1.removeAll()
      self.labelAtrArr2.removeAll()
      
      for i in 0..<labels.count
      {
        let labelObj = JLabelAtr()
        labelObj.x          = labels[i].x
        labelObj.y          = labels[i].y
        labelObj.strLabel   = labels[i].strLabel
        labelObj.colorLabel = labels[i].colorLabel
        
        if(i < 10)
        {
          self.labelAtrArr0.append(labelObj)
        }
        else if(i < 20)
        {
          self.labelAtrArr1.append(labelObj)
        }
        else if(i < 30)
        {
          self.labelAtrArr2.append(labelObj)
        }
      }   
    }
 
    if(self.iChartId != CHART_ID_BLE_ECG0 && self.iChartId != CHART_ID_FILE_ECG0)
    {
      if let xLabels
      {
        var isSame : Bool = FALSE;
        if(xLabels.count > 0 && self.xLabelArr.count > 0)
        {
          for i : Int in 0..<min(self.xLabelArr.count, xLabels.count)
          {
            if(self.xLabelArr[i].strLabel != xLabels[0].strLabel)
            {
              isSame = TRUE
              break
            }
          }
        }
        else
        {
          isSame = TRUE
        }
        
        if(isSame)
        {
          self.xLabelArr = [JLabelAtr]()
          
          for i in 0..<min(xLabels.count, 10)
          {
            let labelObj = JLabelAtr()
            labelObj.x = xLabels[i].x
            labelObj.y = xLabels[i].y
            labelObj.strLabel = xLabels[i].strLabel
            labelObj.colorLabel = Color.gray
            self.xLabelArr.append(labelObj)
          }
        }
      }
    }
    
    if let yLabels
    {
      var isSame : Bool = FALSE;
      if(yLabels.count > 0 && self.yLabelArr.count > 0)
      {
        for i : Int in 0..<min(self.yLabelArr.count, yLabels.count)
        {
          if(self.yLabelArr[i].strLabel != yLabels[i].strLabel)
          {
            isSame = TRUE
            break
          }
        }
      }
      else
      {
        isSame = TRUE
      }
      
      if(isSame)
      {
        self.yLabelArr = [JLabelAtr]()
        
        for i in 0..<min(yLabels.count, 10)
        {
          let labelObj = JLabelAtr()
          labelObj.x = yLabels[i].x
          labelObj.y = yLabels[i].y
          
          labelObj.strLabel = yLabels[i].strLabel
          labelObj.colorLabel = Color.gray
          self.yLabelArr.append(labelObj)
        }
      }
    }
    
    if(self.iChartId == CHART_ID_BLE_ECG0)
    {       
      self.vsSDK.chartBleEcg0.bUIAccess = FALSE      
    }
    
    if(self.iChartId == CHART_ID_FILE_ECG0)
    {       
      self.vsSDK.chartFileEcg0.bUIAccess = FALSE        
    }  
  }
  
  //----------------------------------------------------------------//
  //
  // Views
  //
  //----------------------------------------------------------------//
  var body : some View
  {
    VStack
    {      
      ZStack
      {
        self.pathGridSub
          .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), style: StrokeStyle(lineWidth: 0.2, dash: [4, 2]))

        self.pathGrid
          .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: 0.5)
                      
        self.pathLine0
          .stroke(Color.green, lineWidth: 1)
        
        self.pathFrame
          .stroke(Color(red: 200/255, green: 200/255, blue: 200/255), lineWidth: 1)       
        
        Group
        {          
          ForEach(self.labelAtrArr0)
          { item in
            let labelObj = item
            Text(labelObj.strLabel)
              .position(x: labelObj.x , y: labelObj.y)
              .font(.custom(APP_FONT_NAME, size: self.fLabelFontSize))
              .foregroundColor(labelObj.colorLabel)
          }
        }
        
        Group
        {
          ForEach(self.labelAtrArr1)
          { item in
            let labelObj = item
            Text(labelObj.strLabel)
              .position(x: labelObj.x , y: labelObj.y)
              .font(.custom(APP_FONT_NAME, size: self.fLabelFontSize))
              .foregroundColor(labelObj.colorLabel)
          }
        }
        
        Group
        {
          ForEach(self.labelAtrArr2)
          { item in
            let labelObj = item
            Text(labelObj.strLabel)
              .position(x: labelObj.x , y: labelObj.y)
              .font(.custom(APP_FONT_NAME, size: self.fLabelFontSize))
              .foregroundColor(labelObj.colorLabel)
          }          
        }
        
        Group
        {
          if(self.iChartId != CHART_ID_BLE_ECG0 && self.iChartId != CHART_ID_FILE_ECG0)
          {
            ForEach(self.xLabelArr)
            { item in
              Text(item.strLabel)
                .position(x: item.x , y: item.y)
                .font(.custom(APP_FONT_NAME, size: self.fValueFontSize))
                .foregroundColor(item.colorLabel)
            }
          }
        }

        Group
        {
          ForEach(self.yLabelArr)
          { item in
            Text(item.strLabel)
              .position(x: item.x , y: item.y)
              .font(.custom(APP_FONT_NAME, size: self.fValueFontSize))
              .foregroundColor(item.colorLabel)
          }
        }

        //----------------------------------------------------------------//
        // ADDITION label
        //----------------------------------------------------------------//
        Group
        {
          Text(self.strUnitLabel)
            .position(x:  self.fCanvasWidth - 40 , y: self.fCanvasHeight - 20)
            .font(.custom(APP_FONT_NAME, size: self.fLabelFontSize))
            .foregroundColor(Color.gray)
          
          Text(self.strModeLabel)
            .position(x: 20 , y: self.fCanvasHeight - 20)
            .font(.custom(APP_FONT_NAME, size: APP_FONT_SIZE_XS))
            .foregroundColor(Color.gray)
        }
      }
        .frame(width: self.fCanvasWidth, height: self.fCanvasHeight)

      Spacer()        
    }      
      .onAppear()
      {
        self.OnAppear()
      }    
      // Timer
      .onReceive(timer)
      { time in      
        self.OnTimer() 
      }
  }
}
