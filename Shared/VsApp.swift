//--------------------------------------------------------------------------------//
// @file  VsApp.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

// For the orientation lock
class AppDelegate: NSObject, UIApplicationDelegate
{
  static var orientationLock = UIInterfaceOrientationMask.all             //By default you want all your views to rotate freely
  // static var orientationLock = UIInterfaceOrientationMask.portrait     //By default you want all your views to landscape
  // static var orientationLock = UIInterfaceOrientationMask.landscape    //By default you want all your views to landscape
  
  var vsSDK = VsSDK.shared 
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
  {
    return AppDelegate.orientationLock
  }
}

@main
struct VsApp: App
{
  // AppDelegate for the orientation lock
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  init()
  {
    print("[APP] INIT")    
  }
  
  var body: some Scene
  {
    WindowGroup
    {
      ViewMain()      
    }
  }
}
