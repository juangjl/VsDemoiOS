//--------------------------------------------------------------------------------//
// @file  WidgetItemMeasurementView.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

public let WIDGET_WIDTH_MAX : CGFloat = 600

struct WidgetItemMeasurementView: View
{
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//
  var vsSDK   = VsSDK.shared;
  let timer1  = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()

  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelMeasurementStatus            : String = ""  
  @State var strLabelStopped                      : String = ""
  @State var strLabelRunning                      : String = ""
  @State var strLabelTotalTime                    : String = ""

  //----------------------------------------------------------------//
  // opacity
  //----------------------------------------------------------------//
  @State var fOpacity       : Double = 1
  @State var fOpacityDir    : Double = 0
  
  //----------------------------------------------------------------//
  // View width / height
  //----------------------------------------------------------------//
  @State var fViewWidth  : CGFloat = 400
  @State var fViewHeight : CGFloat = 120
  
  //----------------------------------------------------------------//
  // Title
  //----------------------------------------------------------------//  
  @State var fTitleFontSize     : CGFloat = 20 
  
  //------------------------------------------------------------------------------------------------//
  // TYPE0
  //------------------------------------------------------------------------------------------------//
  // RunStatus
  @State var strRunStatus               : String = "--"
  @State var fRunStatusFontSize         : CGFloat = 22
  @State var colorRunStatus             : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
      
  // Type0Title  
  @State var fTitleRunTimeFontSize      : CGFloat = 14
  @State var colorTitleRunTime          : Color = Color(red: 96 / 255, green: 96 / 255, blue: 120 / 255)
  
  // RunStatus
  @State var strRunTime                 : String = "00:12:34"
  @State var fRunTimeFontSize           : CGFloat = 18
  @State var colorRunTime               : Color = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
  
  //--------------------------------------------------------------------------------------------------------//
  //
  // Functions
  //
  //--------------------------------------------------------------------------------------------------------//
  func UIUpdate()
  {    
    //----------------------------------------------------------------//
    // Opacity
    //----------------------------------------------------------------//        
    let fOpacityMax   : Double = 1
    let fOpacityMin   : Double = 0.3
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
    self.strLabelMeasurementStatus    = "Measurement status"
    self.strLabelStopped              = "Stopped"
    self.strLabelRunning              = "Running"
    self.strLabelTotalTime            = "Total time"
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
    // Running status
    //--------------------------------------------------------//
    var iTimeDeltaMS : Int  = Int(self.vsSDK.iVscModeMSEnd -  self.vsSDK.iVscModeMSStart)
    var iMS  : Int = 0
    var iSec : Int = 0
       
    let iTimeNowMSEnd      : Int64 =  Int64(Date().timeIntervalSince1970) * 1000
    let iTimeNowDeltaMS    : Int   =  Int(iTimeNowMSEnd -  self.vsSDK.iVscModeMSStart)

    //----------------------------------------------------------------//
    // Time adjust
    //----------------------------------------------------------------//
    if(self.vsSDK.iBleState == BLE_STATE_VSC_MODE)
    {
      if((abs(iTimeNowDeltaMS - iTimeDeltaMS) > 3000) && (iTimeDeltaMS > 12000))
      {
        iTimeDeltaMS = iTimeNowDeltaMS
      }
    }

    iMS  = iTimeDeltaMS % 1000
    iSec = (iTimeDeltaMS - iMS) / 1000
    

    // Run Status
    if(self.vsSDK.iBleState == BLE_STATE_VSC_MODE)
    {
      if((self.vsSDK.VscModeCtl.iVscFileEnableStatus == 1) || (self.vsSDK.bVscFileModeEnable == TRUE))
      {
        self.strRunStatus   = self.strLabelRunning
      }
      else
      {
        self.strRunStatus   = self.strLabelRunning
      }
      self.colorRunStatus = Color(red: 143/255, green: 170/255, blue: 220/255)
    }
    else
    {
      self.fOpacity = 1
      self.strRunStatus   = self.strLabelStopped
      self.colorRunStatus = Color(red: 47 / 255, green: 85 / 255, blue: 151 / 255)
    }
     
    //--------------------------------------------------------//
    // Run time
    //--------------------------------------------------------//
    var strEclapsed : String = self.vsSDK.util.TimeStringGet(iSec, 0)
    let idx = strEclapsed.index(strEclapsed.startIndex, offsetBy: strEclapsed.count - 4)
    strEclapsed = String(strEclapsed.prefix(upTo: idx))

    self.strRunTime   = strEclapsed
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
        VStack(alignment: .center, spacing: 0)
        {
          //------------------------------------------------------------------------------------------------//
          // padding-top
          //------------------------------------------------------------------------------------------------//
          Spacer()
            .frame(height:20)
          
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
            Text(self.strLabelMeasurementStatus)
              .frame(width: 200, height: 20,alignment: .leading)
              .font(.custom(APP_FONT_NAME, size: self.fTitleFontSize))
              .foregroundColor(.black)              
            Spacer()
          }
            .frame(width: self.fViewWidth, height: 20)
            
          
          //------------------------------------------------------------------------------------------------//
          // Value area
          //------------------------------------------------------------------------------------------------//
          HStack(alignment: .top, spacing: 10)
          {
            Spacer()
              .frame(width : 20)
            VStack
            {
              Spacer()
              // TYPE0-VALUE
              Text(self.strRunStatus)
                .font(.custom(APP_FONT_NAME, size: self.fRunStatusFontSize))
                .foregroundColor(self.colorRunStatus)
                .opacity(self.fOpacity)
              Spacer()
                .frame(height : 20)
            }
              .frame(width : 140, alignment: .leading)
            Spacer()
            VStack
            {
              Spacer()
              
              // TYPE0-TITLE1
              Text(self.strLabelTotalTime)
                .font(.custom(APP_FONT_NAME, size: self.fTitleRunTimeFontSize))
                .foregroundColor(self.colorTitleRunTime)
                   
              // TYPE0-VALUE1
              Text(self.strRunTime)
                .font(.custom(APP_FONT_NAME, size: self.fRunTimeFontSize))
                .foregroundColor(self.colorRunTime)
              Spacer()
                .frame(height : 20)
            }
              .frame(width : 140, alignment: .trailing)
            Spacer()
              .frame(width : 20)
          }
            .frame(width: self.fViewWidth, height: 60)
            //.background(Color.blue)
        }
        // round rectagle
        RoundedRectangle(cornerRadius: 25)
          .inset(by: 10)
          .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: 2)
          .frame(width: self.fViewWidth, height: self.fViewHeight, alignment: .leading)
      }
        .frame(width: self.fViewWidth, height: self.fViewHeight, alignment: .center)
        //.background(Color.orange)
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
