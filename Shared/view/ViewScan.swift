//--------------------------------------------------------------------------------//
// @file  ViewScan.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ViewScan : View
{
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//
  @ObservedObject var vsSDK : VsSDK = VsSDK.shared
  
  //----------------------------------------------------------------//
  // Timer
  //----------------------------------------------------------------//
  var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  var timer1 = Timer.publish(every: 2,   on: .main, in: .common).autoconnect()

  //----------------------------------------------------------------//
  // Scan
  //----------------------------------------------------------------//
  @State var bScanStart: Bool = false;
  @State var iScanMS: Int = 0;
  
  @State var strBtnScanMsg: String = "";

  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelBack         : String = ""
  @State var strLabelTitleScan    : String = ""
  @State var strLabelScanning     : String = ""
  @State var strLabelSecLeft      : String = ""
  @State var strLabelClickToScan  : String = ""
  
  //--------------------------------------------------------------------------------------------------------//
  // Background color
  //--------------------------------------------------------------------------------------------------------//
  @State var colorTitleBg     : Color = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
  
  @State var colorScanning    : Color = Color(red: 172 / 256, green: 172 / 256, blue: 172 / 256)
  @State var colorScanStopped : Color = Color(red: 78 / 256,  green: 148 / 256, blue: 210 / 256)
  @State var colorFontMsg     : Color = Color(red: 142 / 256, green: 142 / 256, blue: 147 / 256)
  
  //--------------------------------------------------------------------------------------------------------//
  // width and height
  //--------------------------------------------------------------------------------------------------------//
  @State var fViewWidth  : CGFloat      = 0
  @State var fViewHeight : CGFloat      = 1024

  @State var fScreenWidth  : CGFloat      = 0
  @State var fScreenHeight : CGFloat      = 1024
    
  //--------------------------------------------------------------------------------------------------------//
  // Button name
  //--------------------------------------------------------------------------------------------------------//
  @State var strBtnBack = "BACK"
  @State var strBtnScan = "SCAN"
  
  //------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //------------------------------------------------------------------------------------------------//
  func OnBtnScanClicked()
  {
    if(self.vsSDK.bBleScanStart == FALSE)
    {
      vsSDK.BleScanStart();
      
      print(String(format : "scan start\r\n"));
    }
    else
    {
      vsSDK.BleScanStop();
      print(String(format : "scan stop\r\n"));
    }
  }
  
  func OnBtnBackClicked()
  {
    // action
    self.vsSDK.iViewId = VIEW_ID_ENTRY
    self.vsSDK.BleScanStop();
  }
  
  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//  
    self.strLabelBack          = "Back"
    self.strLabelTitleScan     = "Select and click on your device listed below:"
    self.strLabelScanning      = "Scanning"
    self.strLabelSecLeft       = "seconds left"
    self.strLabelClickToScan   = "Click to scan"
  }
  
  func OnTimer()
  {
    let SCAN_TIME_OUT : Int = 10000
    var fSec : Float = 0
    if(self.vsSDK.bBleScanStart == TRUE)
    {
      self.strBtnScan = "SCAN"
      self.iScanMS = self.iScanMS + 100
      if(self.iScanMS  >= SCAN_TIME_OUT)
      {
        self.iScanMS = 0;
        self.vsSDK.BleScanStop();
      }
      else
      {
        fSec = (Float(SCAN_TIME_OUT) - Float(self.iScanMS)) / 1000
        self.strBtnScanMsg = String(format :"%@.. %0.1f %@", self.strLabelScanning, fSec, self.strLabelSecLeft)
      }
      self.colorFontMsg = self.colorScanning
    }
    else
    {
      self.iScanMS        = 0;
      self.strBtnScan     = "SCAN_ON"
      self.strBtnScanMsg  = self.strLabelClickToScan
      self.colorFontMsg   = self.colorScanStopped
    }
    
    if(self.vsSDK.iBleState == BLE_STATE_CONNECTED)
    {
      self.vsSDK.iBleState = BLE_STATE_DISCONNECTED
    }

    self.UIUpdate()
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
        //print(String(format : "\t [AUTO][!!!] SM Paired connected item  = %d, SM-paired auto-connection is not enabled", vsSDK.vsPeripheralConnectedArr.count))
      }
    }
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
      //----------------------------------------------------------------//
      // Header
      //----------------------------------------------------------------//
      VStack(spacing: 1)
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
            Text(self.strLabelBack)
              .font(.custom(APP_FONT_NAME, size: 18))
              .foregroundColor(Color(red: 143 / 255, green: 170 / 255, blue: 220 / 255))
          }

          Spacer()
        }
        Spacer()
          .frame(height: 20)
      }
        .frame(width: self.fScreenWidth, height: 60, alignment: .center)
        .background(self.colorTitleBg)
      
      Group
      {
        Spacer()
          .frame(height: 10)
        
        HStack
        {
          Spacer()
          
          Text(self.strLabelTitleScan )
            .frame(width: self.fViewWidth, height: 40, alignment: .leading)
            //.multilineTextAlignment(.leading)
            .font(.custom(APP_FONT_NAME, size: 16))
            .foregroundColor(Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255))
          
          Spacer()
        }
          .frame(width: self.fViewWidth, height: 40, alignment: .leading)
        
        Spacer()
          .frame(height: 10)
        
        Divider()
        
        Spacer()
          .frame(height: 20)
      }
      
      Group
      {
        ViewScanItemList()
      }
                  
      HStack
      {
        Spacer()
        
        //----------------------------------------------------------------//
        // Button: Scan
        //----------------------------------------------------------------//
        Button(action: self.OnBtnScanClicked)
        {
          Image(self.strBtnScan)
            .resizable()
            .interpolation(.high)
            .antialiased(true)
            .frame(width: 60, height: 60)
        }
        
        Spacer()
      }
      
      Text(self.strBtnScanMsg)
        .font(.custom(APP_FONT_NAME, size: 18))
        .padding()
        .foregroundColor(self.colorFontMsg)
        .frame(width: 600, height: 20)

      Spacer()
        .frame(height: 20)
    } 
      .background(Color.white)
      // Timer
      .onReceive(timer)
      { time in
        self.OnTimer()
      }
      // Timer1
      .onReceive(timer1)
      { time in      
        self.OnTimer1()      
      }    
      .onAppear()
      {
        self.OnAppear()
      }

  }
}
