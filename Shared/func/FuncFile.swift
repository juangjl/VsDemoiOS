//--------------------------------------------------------------------------------//
// @file  FuncFile.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{      
  func FuncFileDocumentPathGet() -> String
  {
    guard let dirUrl  : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else
    {
      return ""
    }
    return  dirUrl.path
  }

  func FuncFolderInit()
  {
    //----------------------------------------------------------------//
    // Init folders for file save and load
    //----------------------------------------------------------------//
    var strFolderName : String = "/VS"
    self.fileCtl.FolderCreate(strFolderName)    

    //----------------------------------------------------------------//
    // Init folders for temp file and data
    //----------------------------------------------------------------//
    strFolderName = "/.TMP"
    self.fileCtl.FolderCreate(strFolderName)    
  }
}
