//--------------------------------------------------------------------------------//
// @file  ConfigItemDeviceResetView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ConfigItemDeviceResetView : View
{
  var vsSDK = VsSDK.shared
  let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

  //--------------------------------------------------------------------------------------------------------//
  // Title
  //--------------------------------------------------------------------------------------------------------//
  @State var strTitle        : String   = "Device Reset"
  @State var strDescription  : String   = "Device will reset!!"

  //--------------------------------------------------------------------------------------------------------//
  // SREG_NAME
  //--------------------------------------------------------------------------------------------------------//
  @State var strSRegName  : String = SREG_DEVICE_RESET
  
  //--------------------------------------------------------------------------------------------------------//
  // Textfield
  //--------------------------------------------------------------------------------------------------------//
  @State var strWriteValue      : String = ""
  @State var strReadValue       : String = ""
  @State var strWriteNote       : String = "Enter value here"
  
  //--------------------------------------------------------------------------------------------------------//
  // Alert
  //--------------------------------------------------------------------------------------------------------//
  @State var bAlertShow  = FALSE
  @State var strAlertTitle = "Warning"
  @State var strAlertInfo  = "Warning"
  @State var strAlertOK    = "Got it"
  
  //--------------------------------------------------------------------------------------------------------//
  // SREG READ
  //--------------------------------------------------------------------------------------------------------//
  @State var bSRegReadOn  : Bool = FALSE
  @State var bSRegWriteOn : Bool = FALSE
  
  //--------------------------------------------------------------------------------------------------------//
  // iSecond
  //--------------------------------------------------------------------------------------------------------//
  @State var iSec : Int = 0
  
  //--------------------------------------------------------------------------------------------------------//
  // Color
  //--------------------------------------------------------------------------------------------------------//
  @State var colorTitleFontColor  : Color = Color(red: 113 / 256, green: 113 / 256, blue: 113 / 256)
  
  @State var colorFieldBgColor    : Color = Color(red: 250 / 256, green: 250 / 256, blue: 250 / 256)
  @State var colorFieldBorder     : Color = Color(red: 120 / 256, green: 120 / 256, blue: 120 / 256)
  
  @State var colorReadFontColor   : Color = Color(red: 120 / 256, green: 120 / 256, blue: 120 / 256)
  
  @State var colorBtnWriteBg      : Color = Color(red: 170 / 256, green: 170 / 256, blue: 170 / 256)
  @State var colorBtnReadBg       : Color = Color(red: 180 / 256, green: 180 / 256, blue: 180 / 256)
  
  //--------------------------------------------------------------------------------------------------------//
  // Font
  //--------------------------------------------------------------------------------------------------------//
  @State var cgReadFontSize  : CGFloat    = 14
  
  //--------------------------------------------------------------------------------------------------------//
  // width and height
  //--------------------------------------------------------------------------------------------------------//
  @State var fViewWidth  : CGFloat        = 400
  @State var fViewHeight : CGFloat        = 1024
  
  
  @State var fTitleWidth  : CGFloat       = 380
  
  @State var fScreenWidth  : CGFloat      = 400
  @State var fScreenHeight : CGFloat      = 1024
      
  @State var fFieldWidth  : CGFloat       = 200
  @State var fFieldHeight : CGFloat       = 40
  
  @State var fButtonWidth  : CGFloat      = 100
  @State var fButtonHeight : CGFloat      = 32

  //--------------------------------------------------------------------------------------------------------//
  // Function
  //--------------------------------------------------------------------------------------------------------//
  func OnBtnGoBackClicked()
  {
    self.vsSDK.iViewId = self.vsSDK.iViewIdPre
  }
  
  func onBtnWriteClicked()
  {
    var bRet  : Bool = FALSE
    
    self.strWriteValue = "ON"
    
    if(self.strWriteValue == "")
    {
      print(String(format : "\t\t [SREG][UI] WRTTE '%@' write value is empty\n",self.strSRegName))
      return
    }
    
    bRet = self.vsSDK.FuncSRegWrite(self.strSRegName, self.strWriteValue)
    if(bRet == FALSE)
    {
      print(String(format : "\t\t [SREG][UI] WRTTE '%@' Failed\n",self.strSRegName))
    }
    else
    {
      print(String(format : "\t\t [SREG][UI] WRTTE '%@' OK \n",self.strSRegName))
    }
    self.bSRegWriteOn = TRUE
  }
  
  func onBtnReadClicked()
  {
    let bRet  : Bool = self.vsSDK.FuncSRegRead(self.strSRegName)
    if(bRet == FALSE)
    {
      print(String(format : "\t\t [SREG][UI] READ '%@'Failed\n",self.strSRegName))
    }
    else
    {
      print(String(format : "\t\t [SREG][UI] READ '%@' OK\n",self.strSRegName))
    }
    
    self.bSRegReadOn = TRUE
  }
  
  func UIUpdate()
  {
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//
    self.strTitle         = "Device reset function"
    self.strDescription   = "The device will reset!!"
  }

  func OnTimer()
  {
    // time update
    iSec = iSec + 1

    // set the data
    if(self.vsSDK.SReg.iCmdState == SREG_CMD_STATE_DONE)
    {
      if(self.bSRegReadOn == TRUE)
      {
        self.strReadValue = self.vsSDK.SReg.strSRegDeviceName
        if(self.strWriteValue == "")
        {
          self.strWriteValue  =  self.strReadValue
        }
        self.vsSDK.SReg.iCmdState  = SREG_CMD_STATE_IDLE
        self.bSRegReadOn = FALSE
      }

      if(self.bSRegWriteOn == TRUE)
      {
        self.vsSDK.SReg.iCmdState  = SREG_CMD_STATE_IDLE
        self.bSRegWriteOn = FALSE
      }
    }
    self.UIUpdate()
  }

  var body: some View
  {
    //----------------------------------------------------------------//
    // SET : Device Name
    //----------------------------------------------------------------//
    ZStack
    {
      // round rectagle
      RoundedRectangle(cornerRadius: 25)
        .inset(by: 10)
        .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: 2)
        .frame(width: self.fViewWidth, height: 180, alignment: .leading)
                      
      VStack
      {
        HStack
        {
          Spacer()
            .frame(width: 20)
          Text(self.strTitle)
            .font(.custom(APP_FONT_NAME, size: 18))
            .foregroundColor(self.colorTitleFontColor)
            .frame(width: self.fTitleWidth, height: 40, alignment: .leading)
          Spacer()
        }
          .frame(width: self.fViewWidth, height: 40, alignment: .center)
        HStack
        {
          Spacer()
            .frame(width:20)
                
          Button(action: self.onBtnWriteClicked)
          {
            Text("Reset")
              .font(.custom(APP_FONT_NAME, size: 12))
              .foregroundColor(.white)
              .frame(width: self.fButtonWidth , height: self.fButtonHeight, alignment: .center)
          }
            .background(self.colorBtnWriteBg)
            .frame(width: self.fButtonWidth, height: self.fButtonHeight)
          Spacer()
        }
          .frame(width: self.fViewWidth, height: 40, alignment: .center)
        
        HStack
        {
          Spacer()
            .frame(width:20)

          Text(self.strDescription)
            .font(.custom(APP_FONT_NAME, size: cgReadFontSize))
            .foregroundColor(self.colorReadFontColor)
            .frame(width: self.fFieldWidth , height: 40, alignment: .leading)
						
          Spacer()
        }
          .frame(width: self.fViewWidth, height: 40, alignment: .center)
      }
    }
      .frame(width: self.fViewWidth, height: 180, alignment: .center)
      
    // Timer
    .onReceive(timer)
    { time in
      self.OnTimer()
    }
    // onAppear
    .onAppear()
    {
      var fWidth: CGFloat  = UIScreen.main.bounds.width
      
      if(fWidth < SCREEN_WIDTH_SMALL)
      {
        fWidth = UIScreen.main.bounds.width
      }
      else if(fWidth > SCREEN_WIDTH_MIDDLE)
      {
        //let fWidth: CGFloat  = UIScreen.main.bounds.width - 70
        fWidth = 640
      }
                 
      self.fViewWidth  = fWidth - 40
      self.fViewHeight = 2048
      
      self.fTitleWidth =  self.fViewWidth  - 40
      
      self.fButtonWidth  = 100
      self.fButtonHeight = 32
      
      self.fFieldWidth  = self.fViewWidth  - fButtonWidth - 60
      self.fFieldHeight = 40
    }
  }
}

