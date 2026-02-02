//--------------------------------------------------------------------------------//
// @file  WidgetItemGSensorInfoView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct WidgetItemGSensorInfoView : View
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
  @State var strLabelGSensorInfo      : String = ""  

  @State var strLabelGSensorInfoNote1 : String = ""
  
  @State var strLabelGSensorAxisX     : String = ""
  @State var strLabelGSensorAxisY     : String = ""
  @State var strLabelGSensorAxisZ     : String = ""
  
  @State var strLabelGSenXNow         : String = ""  
  @State var strLabelGSenYNow         : String = ""  
  @State var strLabelGSenZNow         : String = ""  

  @State var strLabelMin              : String = ""  
  @State var strLabelAvg              : String = ""  
  @State var strLabelMax              : String = ""  

  //----------------------------------------------------------------//
  // Values
  //----------------------------------------------------------------//
  @State var strValueGSenG            : String = ""
  @State var strValueGSenPowerMin     : String = ""
  @State var strValueGSenPowerAvg     : String = ""
  @State var strValueGSenPowerMax     : String = ""  

  @State var strValueGSenXNow         : String = ""  
  @State var strValueGSenXNowMin      : String = ""  
  @State var strValueGSenXNowAvg      : String = ""  
  @State var strValueGSenXNowMax      : String = ""  

  @State var strValueGSenYNow         : String = ""  
  @State var strValueGSenYNowMin      : String = ""  
  @State var strValueGSenYNowAvg      : String = ""  
  @State var strValueGSenYNowMax      : String = ""  

  @State var strValueGSenZNow         : String = ""  
  @State var strValueGSenZNowMin      : String = ""  
  @State var strValueGSenZNowAvg      : String = ""  
  @State var strValueGSenZNowMax      : String = ""  

  // Axis title
  @State var fAxisFontSize     : CGFloat = 16
    
  // View width / height
  @State var fViewWidth  : CGFloat = 400
  @State var fViewHeight : CGFloat = 260
 
  // Title  
  @State var fTitleFontSize     : CGFloat = 18
  
  
  //------------------------------------------------------------------------------------------------//
  // TYPE1
  //------------------------------------------------------------------------------------------------//
  // Yype1MainTitle
  @State var fType1MainTitleFontSize  : CGFloat = 14

  // Type1Value
  @State var strValueNow              : String = "23.5"
  @State var fType1ValueFontSize      : CGFloat = 20
  @State var colorType1Value          : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Type1Unit
  @State var strType1Unit             : String = "mG"
  @State var fType1UnitFontSize       : CGFloat = 10
  @State var colorType1Unit           : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // TitleMin
  @State var fTitleMinFontSize        : CGFloat = 14
  @State var colorTitleMin            : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // Type1Title1
  @State var fTitleAvgFontSize        : CGFloat = 14
  @State var colorTitleAvg            : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // TitleMax  
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

  //--------------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //--------------------------------------------------------------------------------------------------------// 
  func DataUpdate()
  {    
    let healthInfo   = self.vsSDK.healthInfo

    //----------------------------------------------------------------//
    // GSEN_X_NOW
    //----------------------------------------------------------------//
    self.strValueGSenXNow  = String(format: "%0.0f", healthInfo.fGSenXNow)
    if(healthInfo.fGSenXCount == 0)
    {
      self.strValueGSenXNowMin = "--"
      self.strValueGSenXNowAvg = "--"
      self.strValueGSenXNowMax = "--"      
    }
    else
    {
      self.strValueGSenXNowMin = String(format: "%0.0f", healthInfo.fGSenXMin)
      self.strValueGSenXNowAvg = String(format: "%0.0f", healthInfo.fGSenXAvg)
      self.strValueGSenXNowMax = String(format: "%0.0f", healthInfo.fGSenXMax)
    }

    //----------------------------------------------------------------//
    // GSEN_Y_NOW
    //----------------------------------------------------------------//
    self.strValueGSenYNow  = String(format: "%0.0f", healthInfo.fGSenYNow)
    if(healthInfo.fGSenYCount == 0)
    {
      self.strValueGSenYNowMin = "--"
      self.strValueGSenYNowAvg = "--"
      self.strValueGSenYNowMax = "--"      
    }
    else
    {
      self.strValueGSenYNowMin = String(format: "%0.0f", healthInfo.fGSenYMin)
      self.strValueGSenYNowAvg = String(format: "%0.0f", healthInfo.fGSenYAvg)
      self.strValueGSenYNowMax = String(format: "%0.0f", healthInfo.fGSenYMax)
    }

    //----------------------------------------------------------------//
    // GSEN_Z_NOW
    //----------------------------------------------------------------//
    self.strValueGSenZNow  = String(format: "%0.0f", healthInfo.fGSenZNow)
    if(healthInfo.fGSenZCount == 0)
    {
      self.strValueGSenZNowMin = "--"
      self.strValueGSenZNowAvg = "--"
      self.strValueGSenZNowMax = "--"      
    }
    else
    {
      self.strValueGSenZNowMin = String(format: "%0.0f", healthInfo.fGSenZMin)
      self.strValueGSenZNowAvg = String(format: "%0.0f", healthInfo.fGSenZAvg)
      self.strValueGSenZNowMax = String(format: "%0.0f", healthInfo.fGSenZMax)
    }
  }

  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//    
    self.strLabelGSensorInfo              = "G-sensor Information"
    self.strLabelGSensorInfoNote1         = "A G-sensor contains gravity and tilt information in X, Y and Z axis"

    self.strLabelGSensorAxisX             = "X-axis"
    self.strLabelGSensorAxisY             = "Y-axis"
    self.strLabelGSensorAxisZ             = "Z-axis"

    self.strLabelMin                      = "Min"
    self.strLabelAvg                      = "Avg"   
    self.strLabelMax                      = "Max"   
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
            Text(self.strLabelGSensorInfo)
              .frame(width: 280, height: 20,alignment: .leading)
              .font(.custom(APP_FONT_NAME, size: self.fTitleFontSize))
              .foregroundColor(.black)
            Spacer()
          }
            .frame(height: 20)              
          Spacer()
            .frame(height:10)

          //------------------------------------------------------------------------------------------------//
          // Value of X-Axis
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()  
              .frame(width: 20)

            //----------------------------------------------------------------//
            // TITLE / VALUE #MAIN
            //----------------------------------------------------------------//            
            VStack
            {
              // Axis
              Text(self.strLabelGSensorAxisX)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fType1MainTitleFontSize))
                .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              HStack
              {                
                Spacer()
                // TYPE1-VALUE
                Text(self.strValueGSenXNow)
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)

                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)
                Spacer()
              }
                .frame(width : 100, alignment: .center)
              
              Spacer()
            }
              .frame(width : 100, alignment: .center)
            
            Spacer() 

            //----------------------------------------------------------------//
            // TITLE / VALUE # 0
            //----------------------------------------------------------------//
            VStack
            {
              // TYPE1-TITLE0
              Text(self.strLabelMin)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMinFontSize))
                .foregroundColor(self.colorTitleMin)
                            
              Spacer()
                .frame(height: 5)    

              // TYPE1-VALUE0
              Text(self.strValueGSenXNowMin)
                .font(.custom(APP_FONT_NAME, size: self.fType1Value0FontSize))
                .foregroundColor(self.colorType1Value0)

              Spacer()
            }
              .frame(width :70, alignment: .center)

            Spacer()   
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 1
            //----------------------------------------------------------------//
            VStack
            {
              // TYPE1-TITLE1
              Text(self.strLabelAvg)
                .font(.custom(APP_FONT_NAME, size: self.fTitleAvgFontSize))
                .foregroundColor(self.colorTitleAvg)
                                          
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE1
              Text(self.strValueGSenXNowAvg)
                .font(.custom(APP_FONT_NAME, size: self.fValueAvgFontSize))
                .foregroundColor(self.colorValueAvg)

              Spacer()
            }
              .frame(width : 80, alignment: .center)
            
            Spacer()   
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 2
            //----------------------------------------------------------------//
            VStack
            {
              // TYPE1-TITLE2
              Text(self.strLabelMax)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMaxFontSize))
                .foregroundColor(self.colorTitleMax)
                                          
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE2
              Text(self.strValueGSenXNowMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)

              Spacer()
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()     
              .frame(width : 20)
          }
            .frame(height: 50)

          Spacer()
            .frame(height:10)

          //------------------------------------------------------------------------------------------------//
          // Value of Y-Axis
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()
              .frame(width: 20)

            //----------------------------------------------------------------//
            // TITLE / VALUE # MAIN
            //----------------------------------------------------------------//            
            VStack
            {
              // Axis
              Text(self.strLabelGSensorAxisY)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fType1MainTitleFontSize))
                .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              HStack
              {                
                Spacer()
                // TYPE1-VALUE
                Text(self.strValueGSenYNow)
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)

                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)
                Spacer()
              }
                 .frame(width : 100, alignment: .center)
              
              Spacer()
            }
              .frame(width : 100, alignment: .center)

            Spacer()  
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 0
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE0
              Text(self.strLabelMin)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMinFontSize))
                .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE0
              Text(self.strValueGSenYNowMin)
                .font(.custom(APP_FONT_NAME, size: self.fType1Value0FontSize))
                .foregroundColor(self.colorType1Value0)
              Spacer()  
            }
              .frame(width : 70, alignment: .center)

            Spacer()  
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 1
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE1
              Text(self.strLabelAvg)
                .font(.custom(APP_FONT_NAME, size: self.fTitleAvgFontSize))
                .foregroundColor(self.colorTitleAvg)
                                                        
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE1
              Text(self.strValueGSenYNowAvg)
                .font(.custom(APP_FONT_NAME, size: self.fValueAvgFontSize))
                .foregroundColor(self.colorValueAvg)

              Spacer()
            }
              .frame(width : 80, alignment: .center)

            Spacer()  
            
            //----------------------------------------------------------------//
            // TITLE / VALUE # 2
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE2
              Text(self.strLabelMax)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMaxFontSize))
                .foregroundColor(self.colorTitleMax)
                                                        
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE2
              Text(self.strValueGSenYNowMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)

              Spacer()
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()    
              .frame(width: 20)
          }
            .frame(height: 50)

          Spacer()
            .frame(height: 10)

          //------------------------------------------------------------------------------------------------//
          // Value of Z-Axis
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()
              .frame(width : 20)

            //----------------------------------------------------------------//
            // TITLE / VALUE # MAIN
            //----------------------------------------------------------------//            
            VStack
            {
              // Axis
              Text(self.strLabelGSensorAxisZ)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fType1MainTitleFontSize))
                .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              HStack
              {                
                Spacer()
                // TYPE1-VALUE
                Text(self.strValueGSenZNow)
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)

                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)
                Spacer()
              }
                 .frame(width : 100, alignment: .center)
              
              Spacer()
            }
              .frame(width : 100, alignment: .center)
            
            Spacer()

            //----------------------------------------------------------------//
            // TITLE / VALUE # 0
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE0
              Text(self.strLabelMin)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMinFontSize))
                .foregroundColor(self.colorTitleMin)
                                                                    
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE0
              Text(self.strValueGSenZNowMin)
                .font(.custom(APP_FONT_NAME, size: self.fType1Value0FontSize))
                .foregroundColor(self.colorType1Value0)
            }
              .frame(width :70, alignment: .center)
            
            Spacer()

            //----------------------------------------------------------------//
            // TITLE / VALUE # 1
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE1
              Text(self.strLabelAvg)
                .font(.custom(APP_FONT_NAME, size: self.fTitleAvgFontSize))
                .foregroundColor(self.colorTitleAvg)
              
              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE1
              Text(self.strValueGSenZNowAvg)
                .font(.custom(APP_FONT_NAME, size: self.fValueAvgFontSize))
                .foregroundColor(self.colorValueAvg)
              Spacer()
            }
              .frame(width : 80, alignment: .center)
            
            Spacer()

            //----------------------------------------------------------------//
            // TITLE / VALUE # 2
            //----------------------------------------------------------------//
            VStack
            {              
              // TYPE1-TITLE2
              Text(self.strLabelMax)
                .font(.custom(APP_FONT_NAME, size: self.fTitleMaxFontSize))
                .foregroundColor(self.colorTitleMax)

              Spacer()
                .frame(height: 5)  

              // TYPE1-VALUE2
              Text(self.strValueGSenZNowMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)

              Spacer()  
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()              
              .frame(width : 20)
          }
            .frame(height: 50)                
            
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
