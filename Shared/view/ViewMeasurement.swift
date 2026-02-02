//--------------------------------------------------------------------------------//
// @file  ViewMeasurement.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

let ALERT_TYPE_OK                   : Int       = 1
let ALERT_TYPE_YES_NO               : Int       = 2
let ALERT_TYPE_DOWNLOAD_FW          : Int       = 3

struct ViewMeasurement : View
{
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//
  @ObservedObject  var vsSDK   = VsSDK.shared
  
  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelBack                      : String = ""  
  @State var strLabelSystemMessage             : String = ""  
  @State var strLabelStopBeforeLeave           : String = ""  
  @State var strLabelStopFirst                 : String = ""  
  @State var strLabelMassProductionInvalid     : String = ""
    
  //--------------------------------------------------------------------------------------------------------//
  // Background color
  //--------------------------------------------------------------------------------------------------------//
  @State var colorTitleBg : Color = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
  
  //--------------------------------------------------------------------------------------------------------//
  // width and height
  //--------------------------------------------------------------------------------------------------------//
  @State var fViewWidth         : CGFloat = 420
  @State var fViewHeight        : CGFloat = 1024
  
  @State var fScreenWidth       : CGFloat = 420
  @State var fScreenHeight      : CGFloat = 1024

  let fAreaHeaderHeight         : CGFloat = 60  // 60  
  let fAreaButton0Height        : CGFloat = 35  // 65 + 35 
  let fAreaButton1Height        : CGFloat = 100 // 65 + 35 
  let fAreaButton2Height        : CGFloat = 165 // 65 + 65 + 35
  
  //--------------------------------------------------------------------------------------------------------//
  // Display
  //--------------------------------------------------------------------------------------------------------//
  @State var fDisplayAreaWidth  : CGFloat = 600
  @State var fDisplayAreaHeight : CGFloat = 580
  
  @State var fInfoAreaWidth     : CGFloat = 400
  @State var fInfoAreaHeight    : CGFloat = 340
  
  @State var fButtonAreaWidth   : CGFloat = 400

  let timer   = Timer.publish(every: 0.2, on: .current, in: .common).autoconnect()
  let timer1  = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
  let timer2  = Timer.publish(every: 0.2, on: .current, in: .common).autoconnect()
    
  // Widget: Meas
  @State var strWidgetMeasRunStatus  : String = "STOP"
  @State var strWidgetMeasRunTime    : String = "00:00:00"
  
  @State var bAreaMainOn        : Bool = TRUE
  @State var bAreaStatisticsOn  : Bool = FALSE
  
  // Button Area #0
  @State var strBtnBack         : String = "BACK"
  @State var strBtnStop         : String = "STOP"
  @State var strBtnPlay         : String = "PLAY"
  
  // Button Area #1
  @State var strBtnLeft1        : String = "LEFT"
  @State var strBtnMain         : String = "MAIN_ON"
  @State var strBtnStatistics   : String = "STATISTICS"

  // Canvas size
  @State var fCanvasWidth       : CGFloat = 0
  @State var fCanvasHeight      : CGFloat = 0
  
  @State var iBleState          : Int   = 0
  @State var bBleConnected      : Bool  = FALSE
  
  @State var fVscModeSec        : Float = 0
  
  @State var strCharTimeStart   : String = ""
  @State var strCharTimeEnd     : String = ""
  
  @State var iCharTimeMSStart   : Int64 = 0
  @State var iCharTimeMSEnd     : Int64 = 0
  
   // Alert
  @State var bAlertShow          : Bool   = FALSE
  @State var strAlertTitle       : String = "System Message"
  @State var strAlertInfo        : String = "Warning"
  @State var strAlertOK          : String = "OK"
  @State var strAlertCancel      : String = "Cancel"
  
  @State var iAlertType      : Int   = ALERT_TYPE_OK
  
  // View display
  var bShowMap     : Bool
  {
    let bShow : Bool = self.vsSDK.jud.OnGet(JUD_KEY_VIEW_MEASUREMENT_MAP_ID)
    return bShow
  }
  
  var bShowPER     : Bool
  {
    let bShow : Bool = self.vsSDK.jud.OnGet(JUD_KEY_PACKET_ERROR_RATE_ON)
    return bShow
  }
    
  //--------------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //--------------------------------------------------------------------------------------------------------//
  // On-Clicked
  func AreaMainOn()
  {
    self.strBtnMain  = "MAIN_ON"
    self.bAreaMainOn = TRUE
  }
  
  func AreaMainOff()
  {
    self.strBtnMain  = "MAIN"
    self.bAreaMainOn = FALSE
  }
  
  func AreaStatisticsOn()
  {
    self.strBtnStatistics   = "STATISTICS_ON"
    self.bAreaStatisticsOn  = TRUE
  }
  
  func AreaStatisticsOff()
  {
    self.strBtnStatistics   = "STATISTICS"
    self.bAreaStatisticsOn  = FALSE
  }

  func AreaConfigOn()
  {
    self.vsSDK.iViewIdPre   = self.vsSDK.iViewId
    self.vsSDK.iViewId      = VIEW_ID_CONFIG
  }
  
  func AreaConfigOff()
  {
    // self.strBtnConfig       = "CONFIG"
    // self.bAreaConfigOn      = FALSE
  }

  func OnBtnStartClicked()
  {
    // add check the FW Version then alart message
    if(self.vsSDK.iDeviceVersion > MASS_PRODUCTION_INVALID_VALUE)
    {
      self.iAlertType    = ALERT_TYPE_OK
      self.bAlertShow    = TRUE
      self.strAlertTitle = self.strLabelSystemMessage
      self.strAlertInfo  = self.strLabelMassProductionInvalid
      return
    }

    if(self.iBleState == BLE_STATE_VSC_MODE)
    {
      self.iAlertType    = ALERT_TYPE_OK
      self.bAlertShow    = TRUE
      self.strAlertTitle = self.strLabelSystemMessage
      self.strAlertInfo  = self.strLabelStopFirst
      return
    }
  
    //------------------------------------------------------------//
    // Auto Measurment : Start
    //------------------------------------------------------------//
    self.vsSDK.FuncAutoMeasurementOn()
    self.vsSDK.FuncVscModeInit()
  }
  
  func OnBtnStopClicked()
  {
    if(self.iBleState == BLE_STATE_VSC_MODE)
    {
      //------------------------------------------------------------//
      // Auto Measurment : Start
      //------------------------------------------------------------//
      self.vsSDK.FuncAutoMeasurementOff()
      
      self.vsSDK.iBleState = BLE_STATE_VSC_MODE_END
    }
  }
  
  func OnBtnMainClicked()
  {
    if(self.bAreaMainOn == FALSE)
    {
      self.AreaMainOn()
      self.AreaStatisticsOff()
    }
    else
    {
      self.AreaMainOff()
      self.AreaStatisticsOn()
    }
  }
    
  func OnBtnStatisticsClicked()
  {
    if(self.bAreaStatisticsOn == FALSE)
    {
      self.AreaMainOff()
      self.AreaConfigOn()
    }
    else
    {
      self.AreaMainOn()
      self.AreaConfigOff()
    }
  }
  
  func OnBtnBackClickEnable()
  {
    self.vsSDK.BleDisconnect()
    self.vsSDK.iBleState = BLE_STATE_DISCONNECTED
    self.vsSDK.vsPeripheralArr.removeAll()
    self.vsSDK.FuncAutoConnectOff()
    self.vsSDK.iViewId = VIEW_ID_ENTRY
  }
	
  func OnBtnBackClicked()
  {
    if(self.iBleState == BLE_STATE_VSC_MODE)
    {
      self.bAlertShow = TRUE
			
      self.iAlertType = ALERT_TYPE_OK
      if((self.vsSDK.VscModeCtl.iVscFileEnableStatus == 1) || (self.vsSDK.bVscFileModeEnable == TRUE))
      {
        self.strAlertInfo  = "Please confirm if you would like to leave  the measurement "
        self.iAlertType    = ALERT_TYPE_YES_NO
      }
      else
      {
        self.strAlertInfo  = self.strLabelStopBeforeLeave
      }
			
      self.strAlertTitle   = self.strLabelSystemMessage
      self.strAlertInfo    = self.strLabelStopBeforeLeave
      return
    } 
    
    // You can leave
    self.vsSDK.BleDisconnect()
    self.vsSDK.iBleState = BLE_STATE_DISCONNECTED
    self.vsSDK.vsPeripheralArr.removeAll()
    self.vsSDK.FuncAutoConnectOff()
    self.vsSDK.iViewId = VIEW_ID_ENTRY
  }
  
  func OnBtnMarkerAdd()
  {
    if(self.vsSDK.iBleState == BLE_STATE_VSC_MODE)
    {
      // Removed DB functionality
      self.bAlertShow         = TRUE
      self.iAlertType         = ALERT_TYPE_OK
      self.strAlertTitle      = self.strLabelSystemMessage
      self.strAlertInfo       = "Trigger added"
    }
    else
    {
      self.iAlertType         = ALERT_TYPE_OK
      self.bAlertShow         = TRUE
      self.strAlertTitle      = self.strLabelSystemMessage
      self.strAlertInfo       = "Failed to add the trigger Please start the measurement first"
    }
  }
    
  // On-Orientation
  func changeOrientation(to orientation: UIInterfaceOrientation)
  {
    // tell the app to change the orientation
    UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    //print("Changing to", orientation.isPortrait ? "Portrait" : "Landscape")
  }

  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//    
    self.strLabelBack                   = "Back"  
    self.strLabelSystemMessage          = "system message"
    self.strLabelStopBeforeLeave        = "Please stop the measurement before leaving" 
    self.strLabelStopFirst              = "Please stop the measurement first"   
    self.strLabelMassProductionInvalid  = "This device has not undergone mass production and cannot be measured"
  }

  func OnAppear()
  {
    let fWinWidth  : CGFloat = UIScreen.main.bounds.width
    let fWinHeight : CGFloat = UIScreen.main.bounds.height

    var fWidth     : CGFloat = UIScreen.main.bounds.width
    var fHeight    : CGFloat = 0
    
    if(fWidth < SCREEN_WIDTH_SMALL)
    {
      fWidth = UIScreen.main.bounds.width
    }
    else if(fWidth > SCREEN_WIDTH_MIDDLE)
    {
      //let fWidth: CGFloat  = UIScreen.main.bounds.width - 70
      fWidth = 640
    }

    self.fScreenWidth  = UIScreen.main.bounds.width
    self.fScreenHeight = UIScreen.main.bounds.height

    self.fViewWidth  = fWidth - 40
    self.fViewHeight = fWinHeight           

    fWidth = fWinWidth - 40
        
    if(fWidth > 690)
    {
      fWidth = 690
    }
    
    let fChartRatio : CGFloat = CGFloat(self.vsSDK.iEcgChartRowCount) / CGFloat(self.vsSDK.iEcgChartColCount)
    fHeight = fWidth * fChartRatio
    
    self.fCanvasWidth  = fWidth
    self.fCanvasHeight = fHeight
    self.vsSDK.chartBleEcg0.iRowCnt = self.vsSDK.iEcgChartRowCount
    self.vsSDK.chartBleEcg0.iColCnt = self.vsSDK.iEcgChartColCount
    self.vsSDK.chartBleEcg0.CanvasSet(fWidth: fWidth, fHeight: fHeight)
    
    self.vsSDK.chartBleEcg1.iRowCnt = self.vsSDK.iEcgChartRowCount
    self.vsSDK.chartBleEcg1.iColCnt = self.vsSDK.iEcgChartColCount
    self.vsSDK.chartBleEcg1.CanvasSet(fWidth: fWidth, fHeight: fHeight)
    
    // display area height
    self.fDisplayAreaWidth  = fWidth
    self.fDisplayAreaHeight = self.fViewHeight - self.fAreaHeaderHeight - self.fAreaButton1Height
  } 
  
  func OnTimer()
  {
    let strFWinfo      = String(format: ": %d < %d)", self.vsSDK.iDeviceVersion, self.vsSDK.iFwVersion)
    self.iBleState     = self.vsSDK.iBleState
    self.bBleConnected = self.vsSDK.bBleConnected
    
    self.fVscModeSec   = self.vsSDK.fVscModeSec

    // Removed OTA functionality
    if(FALSE)
    {
      // check the FW version need update
      if((self.vsSDK.iFwVersion > self.vsSDK.iDeviceVersion) && ( self.vsSDK.iVsh101Module == 1))
      {
        self.strAlertTitle  = "Firmware Update Available"
        self.strAlertInfo   = "A new firmware version is available. Would you like to update now? (Version" + strFWinfo
        self.iAlertType     = ALERT_TYPE_DOWNLOAD_FW;
        self.strAlertOK     = "OK"
        self.strAlertCancel = "Cancel"
        self.bAlertShow     = TRUE;
      }
    }

    // button check
    if(self.vsSDK.iBleState == BLE_STATE_VSC_MODE)
    {
      self.strBtnPlay  = "PLAY_ON"
      self.strBtnStop  = "STOP"
    }
    else
    {
      self.strBtnPlay  = "PLAY"
      self.strBtnStop  = "STOP_ON"
    } 
  }

  func OnTimer1()
  {
    //--------------------------------------------------------//
    // UI Update
    //--------------------------------------------------------//
    self.UIUpdate()
  }

  func OnTimer2()
  {
    var iTimeMSStart : Int64 = 0
    var iTimeMSEnd   : Int64 = 0
   
    let iTimeNowMSEnd   : Int64 =  Int64(Date().timeIntervalSince1970) * 1000
    let iTimeNowMSStart : Int64 = iTimeNowMSEnd - 6000
                
    
    if((self.vsSDK.iVscModeMSEnd - self.vsSDK.iVscModeMSStart) < 6000)
    {
      iTimeMSStart  = self.vsSDK.iVscModeMSStart
      iTimeMSEnd    = self.vsSDK.iVscModeMSStart + 6000
    }
    else
    {
      iTimeMSStart  = self.vsSDK.iVscModeMSEnd - 6000
      iTimeMSEnd    = self.vsSDK.iVscModeMSEnd
    }

    //----------------------------------------------------------------//
    // Real-time time display
    //----------------------------------------------------------------//
    if((abs(iTimeNowMSEnd - iTimeMSEnd) > 3000) && ((self.vsSDK.iVscModeMSEnd - self.vsSDK.iVscModeMSStart) > 12000))
    {
      self.strCharTimeStart   = self.vsSDK.util.TimeStampTimeGet(iTimeNowMSStart)
      self.strCharTimeEnd     = self.vsSDK.util.TimeStampTimeGet(iTimeNowMSEnd)      
    }
    else
    {
      self.strCharTimeStart   = self.vsSDK.util.TimeStampTimeGet(iTimeMSStart)
      self.strCharTimeEnd     = self.vsSDK.util.TimeStampTimeGet(iTimeMSEnd)       
    }   
    
    if(self.vsSDK.iBleState == BLE_STATE_CONNECTED)
    {
      if(self.vsSDK.FuncAutoMeasurementCheck() == TRUE)
      {
        self.OnBtnStartClicked()
      }
    }
  }
  
  func OnTimer3()
  {

  }

  func OnTimer4()
  {
    if(self.vsSDK.iBleState != BLE_STATE_VSC_MODE)
    {
      return
    }

    let iMeasurementPeriod = self.vsSDK.jud.IntGet(JUD_KEY_MEASUREMENT_PERIOD)
    if(iMeasurementPeriod == 0)
    {
      return
    }

    // Removed DB functionality
    let tNow    : Int64 = Int64(Date().timeIntervalSince1970)
    let iPeriod : Int64 = Int64(iMeasurementPeriod)
    let iT0     : Int64 = 0  // Removed DB functionality
    let iT1     : Int64 = iT0 + iPeriod
    
    let iDelta  : Int64 = iT1 - tNow
    
    //self.vsSDK.DbgPrint(String(format : "NOW = %d, T0 = %d, T1 = %d, PERIOD = %d, DELTA = %d\n", tNow, iT0, iT1, iPeriod, iDelta))
    
    if(iDelta <= 0)
    {
      self.vsSDK.DbgPrint(String(format : "[END] NOW = %d, T0 = %d, T1 = %d, PERIOD = %d, DELTA = %d\n", tNow, iT0, iT1, iPeriod, iDelta))
      self.OnBtnStopClicked()
    }
  }
  
 
  //--------------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //--------------------------------------------------------------------------------------------------------//
  var body : some View
  {
    VStack(spacing: 0)
    {
      //----------------------------------------------------------------//
      // Header
      //----------------------------------------------------------------//
      VStack(spacing: 0)
      {
        Spacer()
          .frame(height: 20)
        HStack
        {
          Spacer()
            .frame(width: 20)
          Button(action: self.OnBtnBackClicked)
          {
            Image("GO-LEFT")
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 20, height: 20)
            Text(String(format : "%@", self.strLabelBack))
              .font(.custom(APP_FONT_NAME, size: 18))
              .foregroundColor(Color(red: 143 / 255, green: 170 / 255, blue: 220 / 255))
          }
          Spacer()

          Spacer()
            .frame(width: 20)
        }
          
        Spacer()
          .frame(height: 20)
      }
        .frame(width: self.fScreenWidth, height: self.fAreaHeaderHeight, alignment: .center)
        .background(self.colorTitleBg)

      //----------------------------------------------------------------//
      // Main Area
      //----------------------------------------------------------------// 
      ScrollView
      {
        if(self.bAreaMainOn == TRUE)
        {
          Spacer(minLength: 10)
          //----------------------------------------------------------------------------------------------------------------//
          // Main View
          //----------------------------------------------------------------------------------------------------------------//
          HStack
          {
            Spacer()
            ViewCanvas(iChartId: CHART_ID_BLE_ECG0, fCanvasWidth: self.fCanvasWidth, fCanvasHeight: self.fCanvasHeight)
            Spacer()
          }
          .frame(width:  UIScreen.main.bounds.width, height: (self.fCanvasHeight), alignment: .center)
          HStack
          {
            Text(String(format : "%@", self.strCharTimeStart))
              .font(.custom(APP_FONT_NAME, size: 12))
              .padding()
              .foregroundColor(.gray)
              .frame(width: 120, height: 20, alignment: .leading)
            Spacer()
            Text(String(format : "%@", self.strCharTimeEnd))
              .font(.custom(APP_FONT_NAME, size: 12))
              .padding()
              .foregroundColor(.gray)
              .frame(width: 120, height: 20, alignment: .trailing)
          }
          .frame(width: self.fCanvasWidth, height: 20, alignment: .center)
          
          Spacer()
          
          HStack
          {
            Spacer()
            WidgetItemMeasurementView()
            Spacer()
          }
          .frame(width: self.fCanvasWidth, alignment: .center)
          
          HStack
          {
            Spacer()
            WidgetItemHeartRateView()
            Spacer()
          }
          .frame(width: self.fCanvasWidth, alignment: .center)                  
                    
          HStack
          {
            Spacer()
            WidgetItemTemperatureView()
            Spacer()
          }
            .frame(width: self.fCanvasWidth, alignment: .center)

          HStack
          {
            Spacer()
            WidgetItemBatteryLevelView()
            Spacer()
          }
          .frame(width: self.fCanvasWidth, alignment: .center)

          HStack
          {
            Spacer()
            WidgetItemGSensorPowerView()
            Spacer()
          }
          .frame(width: self.fCanvasWidth, alignment: .center)

          HStack
          {
            Spacer()
            WidgetItemGSensorInfoView()
            Spacer()
          }
            .frame(width: self.fCanvasWidth, alignment: .center)
          HStack
          {
            Spacer()
            WidgetItemHrvInfoView()
            Spacer()
          }
            .frame(width: self.fCanvasWidth, alignment: .center)
        }
        
        if(self.bAreaStatisticsOn == TRUE)
        {
          //----------------------------------------------------------------------------------------------------------------//
          // Statistics View
          //----------------------------------------------------------------------------------------------------------------//
          ViewStatistics()
            .frame(width: self.fDisplayAreaWidth , height: self.fDisplayAreaHeight, alignment: .center)
          Spacer()
        }
      }
        .frame(width: self.fDisplayAreaWidth, height: (self.fDisplayAreaHeight), alignment: .center)

      //----------------------------------------------------------------//
      // AREA : 1 ROW
      //----------------------------------------------------------------//
      VStack(spacing: 0)
      {
        //----------------------------------------------------------------//
        // ROW#1
        //----------------------------------------------------------------//
        HStack
        {
          Button(action: self.OnBtnStopClicked)
          {
            Image(self.strBtnStop)
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 60, height: 60)
          }
          
          // Button: Start
          Button(action: self.OnBtnStartClicked)
          {
            Image(self.strBtnPlay)
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 60, height: 60)
          }
          
          // Button: Main View
          Button(action: self.OnBtnMainClicked)
          {
            Image(self.strBtnMain)
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 60, height: 60)
          }
          
          // Button: Statistics View
          Button(action: self.OnBtnStatisticsClicked)
          {
            Image(self.strBtnStatistics)
              .resizable()
              .interpolation(.high)
              .antialiased(true)
              .frame(width: 60, height: 60)
          }

        }
          .frame(width: self.fButtonAreaWidth, height: 65, alignment: .center)
      }
        .frame(height: 95, alignment: .center)
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
      // Timer
      .onReceive(timer1)
      { time in
        self.OnTimer1()
      }

      // Timer
      .onReceive(timer2)
      { time in
        self.OnTimer2()
      }
    
      // alert
      .alert(isPresented: $bAlertShow)
      {
      
        if(self.iAlertType == ALERT_TYPE_OK)
        {
          return Alert(title: Text(self.strAlertTitle),
                       message: Text(self.strAlertInfo),
                       dismissButton: .default(Text(self.strAlertOK)))
        }
        else if(self.iAlertType == ALERT_TYPE_DOWNLOAD_FW)
        {
          return Alert(title: Text(self.strAlertTitle),
                       message: Text(self.strAlertInfo),
                       primaryButton: .default(Text(self.strAlertCancel), action:
                       {
                         print("\t [BUTTON] Download Give up to leave")
                         // Removed OTA functionality
                       }),
                       secondaryButton: .cancel(Text(self.strAlertOK), action: {
                          // Removed OTA functionality
                       }))
        }
        else
        {
          return Alert(title: Text(self.strAlertTitle),
                       message: Text(self.strAlertInfo),
                       primaryButton: .default(Text(self.strAlertCancel), action:
                       {
                         print("\t [BUTTON] Give up to leave")
                       }),
                       secondaryButton: .cancel(Text(self.strAlertOK), action: {
                         self.vsSDK.BleDisconnect()
                         self.vsSDK.iBleState = BLE_STATE_DISCONNECTED
                         self.vsSDK.vsPeripheralArr.removeAll()
                         self.vsSDK.FuncAutoConnectOff()
                         self.vsSDK.iViewId = VIEW_ID_ENTRY
                       }))
        }				
      }
  }
}
