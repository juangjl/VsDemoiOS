//--------------------------------------------------------------------------------//
// @file  ViewConfig.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ViewConfig : View
{
  //------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //------------------------------------------------------------------------------------------------//
  var vsSDK = VsSDK.shared
  let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelBack  : String = ""
 
  //----------------------------------------------------------------//
  // Second
  //----------------------------------------------------------------//
  @State var iSec : Int = 0
    
  //----------------------------------------------------------------//
  // Background color
  //----------------------------------------------------------------//
  @State var colorTitleBg   : Color      = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
  
  //----------------------------------------------------------------//
  // width and height
  //----------------------------------------------------------------//
  @State var fViewWidth     : CGFloat    = 420
  @State var fViewHeight    : CGFloat    = 1024
  
  @State var fScreenWidth   : CGFloat    = 420
  @State var fScreenHeight  : CGFloat    = 1024

  //------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //------------------------------------------------------------------------------------------------//  
  func OnBtnBackClicked()
  {    
    self.vsSDK.iViewId = VIEW_ID_MEASUREMENT
  }

  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//    
    self.strLabelBack                 = "Back"    
  }

  func OnTimer()
  {
    if(self.vsSDK.iBleState == BLE_STATE_CLOSE)
    {
      self.vsSDK.BleScanStop()
      self.vsSDK.BleScanStart()
      self.vsSDK.iViewId = VIEW_ID_SCAN
    }
    iSec = iSec + 1

    self.UIUpdate()
  }

  func OnAppear()
  {
    var fWidth: CGFloat  = UIScreen.main.bounds.width
      
    if(fWidth < SCREEN_WIDTH_SMALL)
    {
      fWidth = UIScreen.main.bounds.width
    }
            
    self.fViewWidth  = fWidth - 40
    self.fViewHeight = 2048

                    
    self.fScreenWidth  = UIScreen.main.bounds.width
    self.fScreenHeight = UIScreen.main.bounds.height

    self.UIUpdate()
  }  

  //------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //------------------------------------------------------------------------------------------------// 
  var body: some View
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
      .frame(width: self.fScreenWidth, height: 60, alignment: .center)
      .background(self.colorTitleBg)

    ScrollView
    {      
      Spacer()
        .frame(height: 10)
      
      Group
      {
        //----------------------------------------------------------------//
        // CONFIG_ITEM : Version
        //----------------------------------------------------------------//
        ConfigItemVersionView()

        //----------------------------------------------------------------//
        // CONFIG_ITEM : Device Name
        //----------------------------------------------------------------//
        ConfigItemDeviceNameView()        
        
        //----------------------------------------------------------------//
        // CONFIG_ITEM : Reset
        //----------------------------------------------------------------//
        ConfigItemDeviceResetView()
      }
      
      //----------------------------------------------------------------//
      // Rest Space
      //----------------------------------------------------------------//
      Spacer()
    }      
      // Timer
      .onReceive(timer)
      { time in                
        self.OnTimer()
      }    
      // onAppear
      .onAppear()
      {
        self.OnAppear()    
      }
  }
}

