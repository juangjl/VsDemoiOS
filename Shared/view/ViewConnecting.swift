//--------------------------------------------------------------------------------//
// @file  ViewConnecting.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ViewConnecting: View
{  
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//
  var vsSDK = VsSDK.shared
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  @State var fConnectingSec: Float = 0;

  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelConnectingTo         : String = ""
  @State var strLabelSecEclapsed          : String = ""
  @State var strLabelCancel               : String = ""

  //----------------------------------------------------------------//
  // Background color
  //----------------------------------------------------------------//
  @State var colorTitleBg     : Color = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
  
  //--------------------------------------------------------------------------------------------------------//
  // width and height
  //--------------------------------------------------------------------------------------------------------//
  @State var fViewWidth  : CGFloat      = 0
  @State var fViewHeight : CGFloat      = 1024
  
  //------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //------------------------------------------------------------------------------------------------//
  func OnBtnBackClicked()
  {
    self.vsSDK.BleDisconnect();
    self.vsSDK.iViewId = VIEW_ID_SCAN;
  }

  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Direct English strings
    //----------------------------------------------------------------//  
    self.strLabelConnectingTo           = "Connecting to"
    self.strLabelSecEclapsed            = "seconds eclapsed"
    self.strLabelCancel                 = "Cancel"
  }

  func OnAppear()
  {
    var fWidth: CGFloat  = UIScreen.main.bounds.width
      
    if(fWidth < SCREEN_WIDTH_SMALL)
    {
      fWidth = UIScreen.main.bounds.width
    }
    else if(fWidth > SCREEN_WIDTH_MIDDLE)
    {      
      fWidth = 640
    }
              
    self.fViewWidth  = fWidth - 40
    self.fViewHeight = 2048
  }
  
  func OnTimer()
  {
    //--------------------------------------------------------//
    // Check connected
    //--------------------------------------------------------//
    self.fConnectingSec = self.fConnectingSec + 0.1;
      
    if(self.vsSDK.iBleState == BLE_STATE_CONNECTED)
    {
      self.vsSDK.SReg.iCmdState = SREG_CMD_STATE_IDLE;
      self.vsSDK.iViewId = VIEW_ID_MEASUREMENT;
    }

    //--------------------------------------------------------//
    // UI Update
    //--------------------------------------------------------//
    self.UIUpdate()
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
      VStack
      {
        Spacer()
   
        Text(self.strLabelConnectingTo)
          .font(.custom(APP_FONT_NAME, size: 20))
          .padding()
          .foregroundColor(.gray)
          .frame(width: 400 , height: 32, alignment: .center)
        Text(String(format : "%@", self.vsSDK.vsPeripheralSelected.strDeviceName))
          .font(.custom(APP_FONT_NAME, size: 20))
          .padding()
          .foregroundColor(.blue)
          .frame(width: 400, height: 60, alignment: .center)
               
        Text(String(format : "%0.1f %@", self.fConnectingSec, self.strLabelSecEclapsed))
          .font(.custom(APP_FONT_NAME, size: 24))
          .padding()
          .foregroundColor(.gray)
          .frame(width: 400, height: 60, alignment: .center)
        
        //-------------------------------- Button : START-------------------------------------//
        Button(action:self.OnBtnBackClicked)
        {
          Text(self.strLabelCancel)
            .frame(width: 150 , height: 40, alignment: .center)
        }
          .background(Color.blue)
          .foregroundColor(Color.white)
          .cornerRadius(5)
          .frame(width: 150, height: 40)
        //-------------------------------- Button : END --------------------------------------//
        Spacer()
      }
      Text("vsdemo")
        .font(.subheadline)
        .foregroundColor(Color.gray)
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
