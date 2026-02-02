//--------------------------------------------------------------------------------//
// @file  ViewLaunch.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI
struct ViewLaunch : View
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
  var timer1 = Timer.publish(every: 1,   on: .main, in: .common).autoconnect()

  @State var fSec             : Float   = 0
  @State var iSec             : Int     = 0

  //----------------------------------------------------------------//
  // Area Show
  //----------------------------------------------------------------//      
  @State var fOpacity         : Double = 1
   

  //----------------------------------------------------------------//
  // dict
  //----------------------------------------------------------------//
  @State var iDictType : Int = 0
  
  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------// 
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

  func UIUpdate()
  {
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//      
    self.strLabelSlogan       = "Health Check Everyday"
  }

  func OnTimer()
  {
    self.fSec = self.fSec + 0.1    
  }

  func OnTimer1()
  {
    self.iSec = self.iSec + 1
    if(self.iSec >= 3)
    {
      self.vsSDK.iViewIdPre = VIEW_ID_LAUNCH
      self.vsSDK.iViewId    = VIEW_ID_ENTRY
    }
  }

  func OnAppear()
  {
    // Removed DB functionality
//    self.LanguageInit()

    let fWidth  : CGFloat = UIScreen.main.bounds.width
    let fHeight : CGFloat = UIScreen.main.bounds.height

    //--------------------------------------------------------//
    // BANNER-MAIN
    //--------------------------------------------------------//
    let fBannerWidth  : CGFloat = fWidth  * 0.6
    let fBannerHeight : CGFloat = fBannerWidth  *  self.fBannerMainHeight /  self.fBannerMainWidth

    self.fBannerMainWidth        = fBannerWidth
    self.fBannerMainHeight       = fBannerHeight

    print(String(format : "[LAUNCH][SCREEN] width = %0.0f, height = %0.0f", fWidth, fHeight))
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
      VStack
      {
        HStack
        {
          Spacer()
          Image("VS-MedHUB")
            .resizable()
            .frame(width: 106, height: 106)
          Spacer()
        }
        HStack
        {
          Spacer()
          Image("APP_NAME")
            .resizable()
            .frame(width: 186, height: 30)
          Spacer()
        }
      }

      Spacer()
      HStack
      {
        Spacer()
        Image("VS_LOGO")
          .resizable()
          .frame(width: 151, height: 30)
        Spacer()
      }

      Spacer() 
        .frame(height: 50)
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
