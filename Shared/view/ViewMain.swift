//--------------------------------------------------------------------------------//
// @file  ViewMain.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI
import CoreGraphics

struct ViewMain: View
{
  //----------------------------------------------------------------//
  // setting the update FW version
  //----------------------------------------------------------------//
  let iFWVersion           : Int = 290
  let dwFWCheckSum         : Int = 39890808

  //--------------------------------------------------------------------------------------------------------//
  // Alert
  //--------------------------------------------------------------------------------------------------------//
  @State var bAlertShow    : Bool = FALSE
  @State var bAlertShowEn  : Bool = TRUE
  @State var strAlertTitle : String = "Warning"
  @State var strAlertInfo  : String = "Warning"
  @State var strAlertOK    : String = "Got it"
	
  //--------------------------------------------------------------------------------------------------------//
  //
  // Variables
  //
  //--------------------------------------------------------------------------------------------------------//

  let timer1 = Timer.publish(every:  0.5,  on: RunLoop.main,       in: .common).autoconnect()
  let timer2 = Timer.publish(every:  0.1,  on: RunLoop.current,    in: .common).autoconnect()
  let timer3 = Timer.publish(every:  0.5,  on: RunLoop.current,    in: .common).autoconnect()
  
  @State var iTimeMS : Int = 0;
  @State var iTimeSec : Int = 0;
  
  @State private  var hideStatusBar = true
  @ObservedObject var vsSDK       : VsSDK = VsSDK.shared;
  @State var iViewId              : Int               = VIEW_ID_ENTRY
  
  
  @State var orientation  : UIDeviceOrientation = UIDeviceOrientation.unknown
  
  let queueSub = DispatchQueue(label: "QueueSub",
                                        qos: .background,
                                        attributes: .concurrent,
                                        autoreleaseFrequency: .workItem,
                                        target: nil)
  //--------------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //--------------------------------------------------------------------------------------------------------//
  var viewActive: AnyView
  {   
    if(self.iViewId == VIEW_ID_ENTRY)
    {
      // ap enable sleep mode
      UIApplication.shared.isIdleTimerDisabled = false
      return AnyView(ViewEntry())
    }
    if(self.iViewId ==  VIEW_ID_SCAN)
    {
      // ap disable  sleep mode
      UIApplication.shared.isIdleTimerDisabled = true
      return AnyView(ViewScan())
    }
    if(self.iViewId == VIEW_ID_CONNECTING)
    {
      return  AnyView(ViewConnecting())
    }
    if(self.iViewId == VIEW_ID_CONFIG)
    {
      return  AnyView(ViewConfig())
    }
    if(self.iViewId == VIEW_ID_MEASUREMENT)
    {
      UIApplication.shared.isIdleTimerDisabled = true
      return  AnyView(ViewMeasurement())
    }
    if(self.iViewId == VIEW_ID_STATISTICS)
    {
      return  AnyView(ViewStatistics())
    }
    if(self.iViewId == VIEW_ID_ABOUT)
    {
      return AnyView(ViewAbout())
    }

    return AnyView(ViewEntry())
  }

  func OnAppear()
  {
    #if os(iOS)
      self.vsSDK.DbgPrint("[INIT] OS: iOS\n")
    #elseif os(watchOS)
      self.vsSDK.DbgPrint("[INIT] OS: macOS\n")
    #elseif os(tvOS)
      self.vsSDK.DbgPrint("[INIT] OS: macOS\n")
    #elseif os(macOS)
      self.vsSDK.DbgPrint("[INIT] OS: macOS\n")
    #else //< for os(iOS)
      self.vsSDK.DbgPrint("[INIT] OS: OMG, it's that mythical new Apple product!!!\n")
    #endif
    AppDelegate.orientationLock = .portrait

    // Removed DB functionality

    //----------------------------------------------------------------//
    // setting the update FW version
    //----------------------------------------------------------------//
    self.vsSDK.FWVersionSet(Int32(iFWVersion))
    self.vsSDK.FWCheckSumSet(UInt32(dwFWCheckSum))

    // not phone sleep
    UIApplication.shared.isIdleTimerDisabled = true
  }

  var body: some View
  {
    ZStack
    {
      Color.white
      VStack(spacing: 0)
      {
        self.viewActive
      }
      // Timer
      .onReceive(timer1)
      { time in       

        if(self.vsSDK.bTaskLoopOn == FALSE)
        {          
          let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
          dispatchQueue.async
          {           
            self.vsSDK.TaskLoopOn()
          }          
        }        
      }
      
      // Timer
      .onReceive(timer2)
      { time in
        
        self.iTimeMS  =  self.iTimeMS  + 100
        
        if(self.iTimeMS == 200)
        {
          if(self.vsSDK.bSubLoopOn == FALSE)
          {
            // Slow subloop
            let dispatchQueueSub = DispatchQueue(label: "QUEUE_SUB", qos: .background)
            dispatchQueueSub.async
            {
              self.vsSDK.SubLoop()
            }
          }
        }
        self.iTimeMS = self.iTimeMS  % 1000
      }      
           
      .onReceive(timer3)
      { time in
        
        if(self.iViewId != self.vsSDK.iViewId)
        {
          self.iViewId = self.vsSDK.iViewId;
        }
      }
    }
    .statusBar(hidden: hideStatusBar)
    .onAppear
    {
      OnAppear()
    }
    .onDisappear
    {
      AppDelegate.orientationLock = .all
      UIApplication.shared.isIdleTimerDisabled = false
    }
  }
}

struct MainView_Previews: PreviewProvider
{
  static var previews: some View
  {
    ViewMain()
  }
}
