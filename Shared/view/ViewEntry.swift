//--------------------------------------------------------------------------------//
// @file  ViewEntry.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI
struct ViewEntry: View
{
  //-----------------------------------------------------------------//
  // Alert
  //-----------------------------------------------------------------//
  @State var bAlertShow    : Bool   = FALSE
  @State var bAlertShowEn  : Bool   = TRUE
  @State var strAlertTitle : String = "Warning"
  @State var strAlertInfo  : String = "Warning"
  @State var strAlertOK    : String = "Got it"
	
  //----------------------------------------------------------------//
  //
  // Variables
  //
  //----------------------------------------------------------------//
  
  //----------------------------------------------------------------//
  // VSSDK
  //----------------------------------------------------------------//
  @ObservedObject var vsSDK : VsSDK = VsSDK.shared
  
  //----------------------------------------------------------------//
  // Timer
  //----------------------------------------------------------------//
  var timer  = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  var timer1 = Timer.publish(every: 2,   on: .main, in: .common).autoconnect()

  @State var fSec             : Float   = 0
  @State var iSec             : Int     = 0

  //----------------------------------------------------------------//
  // Area Show
  //----------------------------------------------------------------//  
  @State var bAreaShow        : Bool  = FALSE
  @State var bAreaShowReport  : Bool  = FALSE

  @State var fOpacity         : Double = 1
  @State var fOpacityDir      : Double = 0
 

  //----------------------------------------------------------------//
  // dict
  //----------------------------------------------------------------//
  @State var iDictType : Int = 0
  
  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelClickToStart : String = ""
  @State var strLabelMore         : String = ""
  @State var strLabelSetup        : String = ""
  @State var strLabelInfo         : String = ""
  
  @State var strLabelSlogan       : String = "Health Check Everyday"

  //----------------------------------------------------------------//
  // Banner size
  //----------------------------------------------------------------//
  @State var fBannerMainWidth     : CGFloat = 380
  @State var fBannerMainHeight    : CGFloat = 110

  //----------------------------------------------------------------//
  // Background color
  //----------------------------------------------------------------//
  @State var colorMainLabelFont   : Color = Color(red: 78 / 256,  green: 148 / 256, blue: 210 / 256)
  @State var colorSubLabelFont    : Color = Color(red: 142 / 256, green: 142 / 256, blue: 147 / 256)
    
  //------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //------------------------------------------------------------------------------------------------//
  // Button event
  func onBtnStartClick()
  {    
    self.vsSDK.BleScanStart()

    // action
    self.vsSDK.iViewIdPre = VIEW_ID_ENTRY
    self.vsSDK.iViewId    = VIEW_ID_SCAN
  }
  
  func onBtnGoUPClick()
  {
    self.bAreaShow = TRUE
  }
  
  func OnBtnGoDownClick()
  {
    self.bAreaShow = FALSE
  }
  
  func onBtnAboutClick()
  {
    // action
    self.vsSDK.iViewIdPre = VIEW_ID_ENTRY
    self.vsSDK.iViewId = VIEW_ID_ABOUT
  }

  func UIUpdate()
  {
    let fOpacityMax   : Double = 1
    let fOpacityMin   : Double = 0.6
    let fOpacityHZ    : Double = 1.5
    let fOpacityDelta : Double = (fOpacityMax - fOpacityMin) / (10 / fOpacityHZ)
    if(self.fOpacityDir == 0)
    {
      self.fOpacity  = self.fOpacity - fOpacityDelta
      if(self.fOpacity < fOpacityMin)
      {        
        self.fOpacityDir = 1
      }
    }
    else
    {
      self.fOpacity  = self.fOpacity + fOpacityDelta
      if(self.fOpacity > fOpacityMax)
      {        
        self.fOpacityDir = 0
      }
    }

    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//  
    self.strLabelClickToStart = "Click to start"
    self.strLabelMore         = "More"

    self.strLabelSetup        = "Setup"
    self.strLabelInfo         = "Info"
    
    self.strLabelSlogan       = "Health Check Everyday"
  }

  func OnTimer()
  {
    self.fSec = self.fSec + 0.1
    if(self.fSec >= 3)
    {
      self.vsSDK.FuncAutoConnectCheck()
    }          
    
    self.UIUpdate()

    let strEnabled : String = self.vsSDK.FuncJudRead(JUD_KEY_REPORT_ON)   
    if(strEnabled == "ON")
    {
      self.bAreaShowReport = TRUE
    }    
    else
    {
      self.bAreaShowReport = FALSE
    }
 
  }

  func OnTimer1()
  {
    let bAutoConnectSMPairedOn            = self.vsSDK.FuncJudReadSwitch(JUD_KEY_AUTO_CONNECT_SM_PAIR_ON)

    //----------------------------------------------------------------//
    // Check connected device count
    //----------------------------------------------------------------//
    self.vsSDK.BleConnectedDeviceGet()

    //----------------------------------------------------------------//
    // Conencted (SM Paired) device automatically connect
    //----------------------------------------------------------------//
    if(self.vsSDK.vsPeripheralConnectedArr.count > 0)
    {
      if(bAutoConnectSMPairedOn == TRUE)
      {
        let vsPeripheral = self.vsSDK.vsPeripheralConnectedArr[0]
        self.vsSDK.BleSMDeviceConnect(vsPeripheral)
        self.vsSDK.iViewId = VIEW_ID_CONNECTING
      }
      else
      {
        
      }
    }
    
    // Disk size check
    if((self.iSec % 100) == 0)
    {      
      self.DiskSizeCheck()      
    }    

    self.iSec = self.iSec + 2
    if(self.iSec >= 600)
    {
      self.iSec = 0
    }
  }

  func OnAppear()
  {
    let fWidth  : CGFloat = UIScreen.main.bounds.width    

    //--------------------------------------------------------//
    // BANNER-MAIN
    //--------------------------------------------------------//
    let fBannerWidth  : CGFloat = fWidth  * 0.6
    let fBannerHeight : CGFloat = fBannerWidth  *  self.fBannerMainHeight /  self.fBannerMainWidth

    self.fBannerMainWidth        = fBannerWidth
    self.fBannerMainHeight       = fBannerHeight
  }


  func DiskSizeCheck()
  {
    let diskFree : Int64 = UIDevice.current.freeDiskSpaceInBytes
    let diskData : Float = Float(diskFree/1000000000)
    /// display the disk space wrong
    if ((self.bAlertShow == FALSE) && (self.bAlertShowEn == TRUE) && (diskData < 1))
    {
      self.bAlertShowEn = FALSE;
      self.strAlertInfo = String(format : "Insufficient Storage Available %.2f GBytes",  diskData);
      self.bAlertShow  = TRUE;
    }         
  }
	
  //------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //------------------------------------------------------------------------------------------------//
  var body: some View
  {
    VStack
    {      
      Spacer()
      Spacer()
      VStack
      {
        HStack
        {
          Spacer()
          Image("BANNER-MAIN")
            .resizable()
            .frame(width: self.fBannerMainWidth, height: self.fBannerMainHeight)
          Spacer()
        }
        Text(self.strLabelSlogan)
          .font(.custom(APP_FONT_NAME, size: 18))
          .padding()
          .foregroundColor(self.colorMainLabelFont)
          .frame(width: 400, height: 20)
          .opacity(self.fOpacity)
      }

      Spacer()
      Spacer()
      Spacer()
      Spacer()
      Spacer() 
      
      HStack
      {
        Spacer()
        //-------------------------------- Button : START------------------------------------//
        Button(action: self.onBtnStartClick)
        {
          Image("POWER_ON")
            .resizable()
            .interpolation(.high)
            .antialiased(TRUE)
            .frame(width: 80, height: 80)
            .opacity(self.fOpacity)
        }
        //-------------------------------- Button : END --------------------------------------//
        Spacer()
      }
      Text(self.strLabelClickToStart)
        .font(.custom(APP_FONT_NAME, size: 18))
        .padding()
        .foregroundColor(self.colorMainLabelFont)
        .frame(width: 400, height: 20)
        .opacity(self.fOpacity)

      Spacer()

      Group
      {
        Spacer()

        HStack
        {
          Spacer()
          VStack
          {
            //-------------------------------- Button : START------------------------------------//
            Button(action: self.onBtnAboutClick)
            {
              Image("INFO")
                .resizable()
                .interpolation(.high)
                .antialiased(TRUE)
                .frame(width: 60, height: 60)
            }
            //-------------------------------- Button : END --------------------------------------//
            Text(self.strLabelInfo)
              .font(.custom(APP_FONT_NAME, size: 12))
              .padding()
              .foregroundColor(self.colorSubLabelFont)
              .frame(width: 80, height: 16)
          }

          Spacer()
        }
        .frame(width: 400, height: 80)
      }
      
      Spacer()
        .frame(height: 20)      
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
    // alert
    .alert(isPresented: $bAlertShow)
    {
      Alert(title: Text(self.strAlertTitle), message: Text(self.strAlertInfo), dismissButton: .default(Text(self.strAlertOK)))
    }
  }
}
