//--------------------------------------------------------------------------------//
// @file  WidgetItemBatteryLevelView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct WidgetItemBatteryLevelView : View
{
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//
  var vsSDK   = VsSDK.shared;
  let timer1  = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelBattSoc                        : String = ""  
  @State var strLabelMin                            : String = ""  
  @State var strLabelAvg                            : String = ""  
  @State var strLabelMax                            : String = ""  
  
  // State id  
  @State var  strNowTag  : String   = VS_INFO_LABEL_BATT_SOC
  
  // View width / height
  @State var fViewWidth  : CGFloat = 400
  @State var fViewHeight : CGFloat = 120
  
  // Title  
  @State var fTitleFontSize     : CGFloat = 20
  
  
  //------------------------------------------------------------------------------------------------//
  // TYPE1
  //------------------------------------------------------------------------------------------------//
  // Type1Value
  @State var strValueNow              : String = "23.5"
  @State var fType1ValueFontSize      : CGFloat = 20
  @State var colorType1Value          : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Type1Unit
  @State var strType1Unit             : String = "%"
  @State var fType1UnitFontSize       : CGFloat = 10
  @State var colorType1Unit           : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // TitleMin
  @State var strTitleMin              : String = "min"
  @State var fTitleMinFontSize        : CGFloat = 14
  @State var colorTitleMin            : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // Type1Title1
  @State var strTitleAvg              : String = "avg"
  @State var fTitleAvgFontSize        : CGFloat = 14
  @State var colorTitleAvg            : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // TitleMax
  @State var strTitleMax              : String = "max"
  @State var fTitleMaxFontSize        : CGFloat = 14
  @State var colorTitleMax            : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // Type1Value0
  @State var strValueMin              : String = "12.34"
  @State var fType1Value0FontSize     : CGFloat = 14
  @State var colorType1Value0         : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
    
  // Type1Value1
  @State var strValueAvg              : String = "23.45"
  @State var fValueAvgFontSize        : CGFloat = 14
  @State var colorValueAvg            : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Type1Value2
  @State var strValueMax              : String = "45.67"
  @State var fValueMaxFontSize        : CGFloat = 14
  @State var colorValueMax            : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Removed Trend functionality

  func DataUpdate()
  {
    let healthInfo = self.vsSDK.healthInfo
    self.strValueNow  = String(format: "%0.0f", healthInfo.fBattSocNow)
    if(healthInfo.fBattSocCount == 0)
    {
      self.strValueMin = "--"
      self.strValueAvg = "--"
      self.strValueMax = "--"      
    }
    else
    {
      self.strValueMin = String(format: "%0.0f", healthInfo.fBattSocMin)
      self.strValueAvg = String(format: "%0.0f", healthInfo.fBattSocAvg)
      self.strValueMax = String(format: "%0.0f", healthInfo.fBattSocMax)
    }
  }
    
  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//    
    self.strLabelBattSoc                   = "Battery level"   
    self.strLabelMin                       = "Min"   
    self.strLabelAvg                       = "Avg"   
    self.strLabelMax                       = "Max"   
  }
  
  func OnAppear()
  {
    let fScreenWidth = UIScreen.main.bounds.width
    if(fScreenWidth > WIDGET_WIDTH_MAX)
    {
      self.fViewWidth = WIDGET_WIDTH_MAX
    }
    else
    {
      self.fViewWidth = fScreenWidth - 40
    }
  }

  func OnTimer()
  {
    //--------------------------------------------------------//
    // UI Update
    //--------------------------------------------------------//
    self.UIUpdate()
    
    //--------------------------------------------------------//
    // Data Update
    //--------------------------------------------------------//
    self.DataUpdate()    
  }
  
  //--------------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //--------------------------------------------------------------------------------------------------------//
  var body: some View
  {
    VStack
    {
      ZStack
      {
        VStack(alignment: .leading, spacing: 0)
        {
          //------------------------------------------------------------------------------------------------//
          // padding-top
          //------------------------------------------------------------------------------------------------//
          Spacer()
            .frame(height:10)

          //------------------------------------------------------------------------------------------------//
          // Header
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 10)
          {
            Spacer()
              .frame(width:20)
            // icon
            Image("HEART")
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 20, height: 20)
            
            // title
            Text(self.strLabelBattSoc)
              .frame(width: 200, height: 20,alignment: .leading)
              .font(.custom(APP_FONT_NAME, size: self.fTitleFontSize))
              .foregroundColor(.black)
            Spacer()
              .frame(width: 20)
          }
            .frame(height: 20)
            
          
          //------------------------------------------------------------------------------------------------//
          // Value area
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()              
              .frame(width: 20)

            VStack
            {
              Spacer()
              HStack
              {
                // TYPE1-VALUE
                Text(self.strValueNow)
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)
                Text(self.strType1Unit)
                .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                .foregroundColor(self.colorType1Unit)
              }
            }
              .frame(width: 100)
            
            Spacer()
                        
            //----------------------------------------------------------------//
            // TITLE / VALUE # 0
            //----------------------------------------------------------------//
            VStack
            {
              Spacer()
              // TYPE1-TITLE0
              Text(self.strLabelMin)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMinFontSize))
                .foregroundColor(self.colorTitleMin)
              // TYPE1-VALUE0
              Text(self.strValueMin)
                .font(.custom(APP_FONT_NAME, size: self.fType1Value0FontSize))
                .foregroundColor(self.colorType1Value0)
            }
              .frame(width : 70, alignment: .center)

            Spacer()  
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 1
            //----------------------------------------------------------------//
            VStack
            {
              Spacer()
              // TYPE1-TITLE1
              Text(self.strLabelAvg)
                .font(.custom(APP_FONT_NAME, size: self.fTitleAvgFontSize))
                .foregroundColor(self.colorTitleAvg)
              // TYPE1-VALUE1
              Text(self.strValueAvg)
                .font(.custom(APP_FONT_NAME, size: self.fValueAvgFontSize))
                .foregroundColor(self.colorValueAvg)
            }
              .frame(width : 80, alignment: .center)

            Spacer()  
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 2
            //----------------------------------------------------------------//
            VStack
            {
              Spacer()
              // TYPE1-TITLE2
              Text(self.strLabelMax)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMaxFontSize))
                .foregroundColor(self.colorTitleMax)
              // TYPE1-VALUE2
              Text(self.strValueMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()              
              .frame(width: 20)
          }
            .frame(height: 40)
          Spacer()
            .frame(height:10)
        }
                          
        // round rectagle
        RoundedRectangle(cornerRadius: 25)
          .inset(by: 10)
          .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: 2)
          .frame(width: self.fViewWidth, height: self.fViewHeight, alignment: .leading)
      }
    }
      .frame(width: self.fViewWidth, height: self.fViewHeight, alignment: .center)
      // Appear
      .onAppear()
      {
        self.OnAppear()
      }
      // Timer
      .onReceive(timer1)
      { time in
        self.OnTimer()
      }   
  }
}
