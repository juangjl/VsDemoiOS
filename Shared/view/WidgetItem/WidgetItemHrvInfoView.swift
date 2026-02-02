//--------------------------------------------------------------------------------//
// @file  WidgetItemHrvInfoView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct WidgetItemHrvInfoView : View
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
  @State var strLabelHrvInfo          : String = ""  
  @State var strLabelHrvInfoRR        : String = ""  
  @State var strLabelHrvInfoSdnn      : String = ""  
  @State var strLabelHrvInfoRmssd     : String = ""  
  @State var strLabelHrvInfoLFHF      : String = ""  
  @State var strLabelHrvInfoLFTP      : String = ""  
  @State var strLabelHrvInfoHFTP      : String = ""  

  @State var strLabelMin              : String = ""  
  @State var strLabelAvg              : String = ""  
  @State var strLabelMax              : String = ""  

  @State var  strTagHrvRR    : String   = "HRV_RR"
  @State var  strTagHrvSdnn  : String   = "HRV_SDNN"
  @State var  strTagHrvRmssd : String   = "HRV_RMSSD"
  @State var  strTagHrvLFHF  : String   = "HRV_LFHF"
  @State var  strTagHrvLFTP  : String   = "HRV_LFTP"
  @State var  strTagHrvHFTP  : String   = "HRV_HFTP"

  //----------------------------------------------------------------//
  // Values
  //----------------------------------------------------------------//
  @State var strValueHrvRR              : String = "--"
  @State var strValueHrvRRMin           : String = "12.34"
  @State var strValueHrvRRAvg           : String = "23.45"
  @State var strValueHrvRRMax           : String = "45.67"
  
  @State var strValueHrvSdnn            : String = "--"
  @State var strValueHrvSdnnMin         : String = "12.34"
  @State var strValueHrvSdnnAvg         : String = "23.45"
  @State var strValueHrvSdnnMax         : String = "45.67"
  
  @State var strValueHrvRmssd           : String = "--"
  @State var strValueHrvRmssdMin        : String = "12.34"
  @State var strValueHrvRmssdAvg        : String = "23.45"
  @State var strValueHrvRmssdMax        : String = "45.67"

  @State var strValueHrvLFHF            : String = "--"
  @State var strValueHrvLFHFMin         : String = "12.34"
  @State var strValueHrvLFHFAvg         : String = "23.45"
  @State var strValueHrvLFHFMax         : String = "45.67"

  @State var strValueHrvLFTP            : String = "--"
  @State var strValueHrvLFTPMin         : String = "12.34"
  @State var strValueHrvLFTPAvg         : String = "23.45"
  @State var strValueHrvLFTPMax         : String = "45.67"

  @State var strValueHrvHFTP            : String = "--"
  @State var strValueHrvHFTPMin         : String = "12.34"
  @State var strValueHrvHFTPAvg         : String = "23.45"
  @State var strValueHrvHFTPMax         : String = "45.67"

  // View width / height
  @State var fViewWidth  : CGFloat = 400
  @State var fViewHeight : CGFloat = 370
 
  // Title
  @State var strTitle           : String = "HRV RR"
  @State var fTitleFontSize     : CGFloat = 18
  
  
  //------------------------------------------------------------------------------------------------//
  // TYPE1
  //------------------------------------------------------------------------------------------------//
  // Note
  @State var fNoteFontSize            : CGFloat = 14

  // Type1Value  
  @State var fType1ValueFontSize      : CGFloat = 18
  @State var colorType1Value          : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Type1Unit
  @State var strType1Unit             : String = "ms"
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
  @State var fType1Value0FontSize     : CGFloat = 14
  @State var colorType1Value0         : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
    
  // Type1Value1  
  @State var fValueAvgFontSize        : CGFloat = 14
  @State var colorValueAvg            : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  // Type1Value2  
  @State var fValueMaxFontSize        : CGFloat = 14
  @State var colorValueMax            : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)

  //--------------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //--------------------------------------------------------------------------------------------------------//   
  func DataUpdate()
  {
    let healthInfo    = self.vsSDK.healthInfo

    //----------------------------------------------------------------//
    // 1. HRV-RR
    //----------------------------------------------------------------//      
    self.strValueHrvRR  = String(format: "%0.0f", healthInfo.fHrvRRNow)
    if(healthInfo.fHrvRRCount == 0)
    {
      self.strValueHrvRRMin = "--"
      self.strValueHrvRRAvg = "--"
      self.strValueHrvRRMax = "--"        
    }
    else
    {
      self.strValueHrvRRMin = String(format: "%0.0f", healthInfo.fHrvRRMin)
      self.strValueHrvRRAvg = String(format: "%0.0f", healthInfo.fHrvRRAvg)
      self.strValueHrvRRMax = String(format: "%0.0f", healthInfo.fHrvRRMax)
    }

    //----------------------------------------------------------------//
    // 2. HRV-SDNN
    //----------------------------------------------------------------//      
    self.strValueHrvSdnn  = String(format: "%0.0f", healthInfo.fHrvSdnnNow)
    if(healthInfo.fHrvSdnnCount == 0)
    {
      self.strValueHrvSdnnMin = "--"
      self.strValueHrvSdnnAvg = "--"
      self.strValueHrvSdnnMax = "--"        
    }
    else
    {
      self.strValueHrvSdnnMin = String(format: "%0.0f", healthInfo.fHrvSdnnMin)
      self.strValueHrvSdnnAvg = String(format: "%0.0f", healthInfo.fHrvSdnnAvg)
      self.strValueHrvSdnnMax = String(format: "%0.0f", healthInfo.fHrvSdnnMax)
    }    
            
    //----------------------------------------------------------------//
    // 3. HRV-RMSSD
    //----------------------------------------------------------------//      
    self.strValueHrvRmssd  = String(format: "%0.0f", healthInfo.fHrvRmssdNow)
    if(healthInfo.fHrvRmssdCount == 0)
    {
      self.strValueHrvRmssdMin = "--"
      self.strValueHrvRmssdAvg = "--"
      self.strValueHrvRmssdMax = "--"        
    }
    else
    {
      self.strValueHrvRmssdMin = String(format: "%0.0f", healthInfo.fHrvRmssdMin)
      self.strValueHrvRmssdAvg = String(format: "%0.0f", healthInfo.fHrvRmssdAvg)
      self.strValueHrvRmssdMax = String(format: "%0.0f", healthInfo.fHrvRmssdMax)
    }  

    //----------------------------------------------------------------//
    // 4. HRV-LFHF
    //----------------------------------------------------------------//      
    self.strValueHrvLFHF  = String(format: "%0.2f", healthInfo.fHrvLFHFNow)
    if(healthInfo.fHrvLFHFCount == 0)
    {
      self.strValueHrvLFHFMin = "--"
      self.strValueHrvLFHFAvg = "--"
      self.strValueHrvLFHFMax = "--"        
    }
    else
    {
      self.strValueHrvLFHFMin = String(format: "%0.2f", healthInfo.fHrvLFHFMin)
      self.strValueHrvLFHFAvg = String(format: "%0.2f", healthInfo.fHrvLFHFAvg)
      self.strValueHrvLFHFMax = String(format: "%0.2f", healthInfo.fHrvLFHFMax)
    }

    //----------------------------------------------------------------//
    // 5. HRV-LFTP
    //----------------------------------------------------------------//      
    self.strValueHrvLFTP  =  String(format: "%0.2f", healthInfo.fHrvLFTPNow)
    if(healthInfo.fHrvLFTPCount == 0)
    {
      self.strValueHrvLFTPMin = "--"
      self.strValueHrvLFTPAvg = "--"
      self.strValueHrvLFTPMax = "--"        
    }
    else
    {
      self.strValueHrvLFTPMin = String(format: "%0.2f", healthInfo.fHrvLFTPMin)
      self.strValueHrvLFTPAvg = String(format: "%0.2f", healthInfo.fHrvLFTPAvg)
      self.strValueHrvLFTPMax = String(format: "%0.2f", healthInfo.fHrvLFTPMax)
    } 

    //----------------------------------------------------------------//
    // 6. HRV-HFTP
    //----------------------------------------------------------------//      
    self.strValueHrvHFTP  = String(format: "%0.2f", healthInfo.fHrvHFTPNow)    
    if(healthInfo.fHrvHFTPCount == 0)
    {
      self.strValueHrvHFTPMin = "--"
      self.strValueHrvHFTPAvg = "--"
      self.strValueHrvHFTPMax = "--"        
    }
    else
    {
      self.strValueHrvHFTPMin = String(format: "%0.2f", healthInfo.fHrvHFTPMin)
      self.strValueHrvHFTPAvg = String(format: "%0.2f", healthInfo.fHrvHFTPAvg)
      self.strValueHrvHFTPMax = String(format: "%0.2f", healthInfo.fHrvHFTPMax)
    }
  }

  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//    
    self.strLabelHrvInfo                  = "HRV information"
    self.strLabelHrvInfoRR                = "RR"
    self.strLabelHrvInfoSdnn              = "SDNN"
    self.strLabelHrvInfoRmssd             = "RMSSD"
    self.strLabelHrvInfoLFHF              = "LF/HF"
    self.strLabelHrvInfoLFTP              = "LF/TP"
    self.strLabelHrvInfoHFTP              = "HF/TP"
    
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
  var body : some View
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
            Text(self.strLabelHrvInfo)
              .frame(width: 280, height: 20,alignment: .leading)
              .font(.custom(APP_FONT_NAME, size: self.fTitleFontSize))
              .foregroundColor(.black)
            Spacer()
          }
            .frame(height: 20)            

          //------------------------------------------------------------------------------------------------//
          // 1. Value of HRV-RR
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()              
              .frame(width : 20)              
              
            VStack
            {
              Spacer()
              
              // Value title
              Text(self.strLabelHrvInfoRR)
                .frame(width: 120, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
               .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              HStack
              {
                // TYPE1-VALUE
                Text(self.strValueHrvRR)                  
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)
                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)  
              }
            }
              .frame(width: 100, alignment: .center)

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
              Text(self.strValueHrvRRMin)
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
              Text(self.strValueHrvRRAvg)
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
              Text(self.strValueHrvRRMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()              
             .frame(width : 20)       
          }
            .frame(height: 40)
          
          //------------------------------------------------------------------------------------------------//
          // 2. Value of HRV-SDNN
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()              
              .frame(width: 20)            

            VStack
            {
              Spacer()
              // Value title
              Text(self.strLabelHrvInfoSdnn)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
                .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    
              HStack
              {
                // TYPE1-VALUE
                Text(self.strValueHrvSdnn)                  
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)
                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)
              }
            }          
              .frame(width: 100, alignment: .center)            
            
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
              Text(self.strValueHrvSdnnMin)
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
              Text(self.strValueHrvSdnnAvg)
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
              Text(self.strValueHrvSdnnMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()              
              .frame(width: 20)     
          }
            .frame(height: 40)

          //------------------------------------------------------------------------------------------------//
          // 3. Value of HRV-RMSSD
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()              
              .frame(width: 20)     

            VStack
            {
              Spacer()
              // Value title
              Text(self.strLabelHrvInfoRmssd)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
               .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    
              HStack
              {
                // TYPE1-VALUE
                Text(self.strValueHrvRmssd)                  
                  .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                  .foregroundColor(self.colorType1Value)
                // TYPE1-UNIT
                Text(self.strType1Unit)
                  .font(.custom(APP_FONT_NAME, size: self.fType1UnitFontSize))
                  .foregroundColor(self.colorType1Unit)   
              }
            }    
              .frame(width: 100, alignment: .center)
            
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
              Text(self.strValueHrvRmssdMin)
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
              Text(self.strValueHrvRmssdAvg)
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
              Text(self.strValueHrvRmssdMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()           
              .frame(width: 20)        
          }
            .frame(height: 40)

          //------------------------------------------------------------------------------------------------//
          // 4. Value of HRV-LFHF
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()     
              .frame(width: 20)        

            VStack
            {
              Spacer()
              // Value title
              Text(self.strLabelHrvInfoLFHF)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
               .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              // TYPE1-VALUE
              Text(self.strValueHrvLFHF)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                .foregroundColor(self.colorType1Value)
            }
              .frame(width: 100, alignment: .center)
            
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
              Text(self.strValueHrvLFHFMin)
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
              Text(self.strValueHrvLFHFAvg)
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
              Text(self.strValueHrvLFHFMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()          
              .frame(width: 20)          
          }
            .frame(height: 40)  

          //------------------------------------------------------------------------------------------------//
          // 5. Value of HRV-LFTP
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()
              .frame(width : 20)

            VStack
            {
              Spacer()
              // Value title
              Text(self.strLabelHrvInfoLFTP)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
               .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              // TYPE1-VALUE
              Text(self.strValueHrvLFTP)
                .frame(width: 100, alignment: .center)
                .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                .foregroundColor(self.colorType1Value)
            }
              .frame(width: 100, alignment: .center)

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
              Text(self.strValueHrvLFTPMin)
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
              Text(self.strValueHrvLFTPAvg)
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
              Text(self.strValueHrvLFTPMax)
                .font(.custom(APP_FONT_NAME, size: self.fValueMaxFontSize))
                .foregroundColor(self.colorValueMax)
            }
              .frame(width : 70, alignment: .center)
                          
            Spacer()      
              .frame(width : 20)        
          }
            .frame(height: 40)  

          //------------------------------------------------------------------------------------------------//
          // 6. Value of HRV-HFTP
          //------------------------------------------------------------------------------------------------//                    
          Spacer()
            .frame(height : 10)
          HStack(alignment: .top, spacing: 0)
          {
            Spacer()              
              .frame(width: 20)      

            VStack
            {
              Spacer()
              // Value title
              Text(self.strLabelHrvInfoHFTP)                
                .font(.custom(APP_FONT_NAME, size: self.fNoteFontSize))
               .foregroundColor(self.colorTitleMin)
              
              Spacer()
                .frame(height: 5)    

              // TYPE1-VALUE
              Text(self.strValueHrvHFTP)                
                .font(.custom(APP_FONT_NAME, size: self.fType1ValueFontSize))
                .foregroundColor(self.colorType1Value)
            }
              .frame(width: 100, alignment: .center)

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
              Text(self.strValueHrvHFTPMin)
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
              Text(self.strValueHrvHFTPAvg)
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
              Text(self.strValueHrvHFTPMax)
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
