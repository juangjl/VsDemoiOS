//--------------------------------------------------------------------------------//
// @file  WidgetItemGSensorInfoView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ViewStatistics : View
{
  //------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //------------------------------------------------------------------------------------------------//
  var vsSDK = VsSDK.shared
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  @State  var bShowGSensor : Bool = FALSE
  @State  var bShowHRV     : Bool = TRUE
  @State  var bShowPER     : Bool = FALSE
  //--------------------------------------------------------------------------------------------------------//
  // Background color
  //--------------------------------------------------------------------------------------------------------//
  @State var colorTitleBg : Color = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
      
  @State var fViewWidth  : CGFloat  = 0
  @State var fViewHeight : CGFloat  = 1024
 
  //------------------------------------------------------------------------------------------------//
  // Cell
  //------------------------------------------------------------------------------------------------//
  var colorCellHeaderBg   : Color = Color(red: 132/255,   green: 151/255,   blue: 176/255)
  var colorCellHeaderFont : Color = Color(red: 232/255,   green: 232/255,   blue: 232/255)
  
  var colorCellTitleBg    : Color = Color(red: 173/255,   green: 185/255,   blue: 202/255)
  var colorCellBg         : Color = Color(red: 251/255,   green: 229/255,   blue: 214/255)
  var colorCellFont       : Color = Color(red: 0/255,     green: 32/255,    blue: 96/255)
  
  
  @State var fCellFontSize : CGFloat = 16
  @State var fCellTitleFontSize : CGFloat = 18
  
  @State var fCellWidth  : CGFloat = 80
  @State var fCellHeight : CGFloat = 30
    
  var colorEmpty    : Color = Color(red:255/255, green: 255/255, blue: 255/255)
  var colorBgTitle  : Color = Color(red:249/255, green: 102/255, blue: 153/255)
  var colorValue    : Color = Color.black
  
  //------------------------------------------------------------------------------------------------//
  //
  // Function
  //
  //------------------------------------------------------------------------------------------------//
  func OnBtnGoBackClicked()
  {    
    self.vsSDK.iViewId = self.vsSDK.iViewIdPre
  }  

  //------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //------------------------------------------------------------------------------------------------//  
  var body: some View
  {
    ScrollView
    {     
      //----------------------------------------------------------------//
      // Widget
      //----------------------------------------------------------------//
      VStack(spacing: 1)
      {
        //------------------------------------------------------------------------------------------------//
        // Widgets
        //------------------------------------------------------------------------------------------------//
        Group
        {
          HStack
          {
            Spacer()
            WidgetItemMeasurementView()
            Spacer()
          }
          
          HStack
          {
            Spacer()
            WidgetItemHeartRateView()
            Spacer()
          }
        }

        Spacer()
      }
        .frame(alignment: .center)
    }
      
    // Timer
    .onReceive(timer)
    { time in

    }
    
    // onAppear
    .onAppear()
    {
      var fWidth: CGFloat  = UIScreen.main.bounds.width
      if(fWidth < SCREEN_WIDTH_SMALL)
      {
        fWidth = UIScreen.main.bounds.width - 40
      }
      else if(fWidth > SCREEN_WIDTH_MIDDLE)
      {
        //let fWidth: CGFloat  = UIScreen.main.bounds.width - 70
        fWidth = 640
      }
      if(fWidth > 680)
      {
        fWidth = 680
      }
      
      if(fWidth < 320)
      {
        self.fCellFontSize = 6
      }
      else if(fWidth < 420)
      {
        self.fCellFontSize = 10
      }
      else if(fWidth < 640)
      {
        self.fCellFontSize = 16
      }
      else
      {
        self.fCellFontSize = 18
      }
      self.fCellTitleFontSize = self.fCellFontSize + 2
      
      self.fViewWidth  = fWidth
      self.fViewHeight = 2048
      
      self.fCellWidth = (fWidth - 50) / 5
      
    }
  }
}

struct StatisticView_Previews: PreviewProvider
{
  static var previews: some View
  {
    ViewStatistics()
  }
}
