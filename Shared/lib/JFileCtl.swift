//--------------------------------------------------------------------------------
// @file  JFileCtlType.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation
class JFileCtlType
{
  //----------------------------------------------------------------------------------------------------------------//
  //  URL of the app
  //  Ex:
  //    rootUrl = /var/mobile/Containers/Data/Application/F66C5338-D58A-4471-9641-745235BEE3A4/Documents
  //----------------------------------------------------------------------------------------------------------------//
  var  rootUrl : URL = URL(fileURLWithPath: "")
  let  fileManager : FileManager  = FileManager.default
  
  init()
  {
    self.RootUrlGet()
  }
    
  deinit
  {
  }
  
  //----------------------------------------------------------------//
  // FOLDER
  //----------------------------------------------------------------//
  func RootUrlGet()
  {
    // get path of directory
    guard let dirUrl  : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
        return
    }
    self.rootUrl = dirUrl
  }
  
  func RootFolderPrint()
  {
    print(self.rootUrl.path)
  }
  
  func FolderExisted(_ strFolderPath : String) -> Bool
  {
    var isDir   : ObjCBool = false
    let strPath : String   = self.rootUrl.path.appending(strFolderPath)
    let bRet    : Bool     = self.fileManager.fileExists(atPath : strPath, isDirectory: &isDir)
            
    if((isDir.boolValue == TRUE) && (bRet == TRUE))
    {
      return TRUE
    }
    else
    {
      return FALSE
    }
  }
  
  func FolderCreate(_ strFolderName: String)
  {
    let strPath = self.rootUrl.path.appending(strFolderName)
        
    if(self.FolderExisted(strFolderName) == TRUE)
    {
      return
    }
    
    do
    {
      try FileManager.default.createDirectory(atPath: strPath, withIntermediateDirectories: true, attributes: nil)
    }
    catch let error as NSError
    {
      print("[ERROR][FILE_CTL] Unable to create directory \(error.debugDescription)")
      return
    }
    //print(String("\t [FILE_CTL] Folder created\n"))
  }

  func FolderDelete(_ strFolderPath : String)
  {    
    let strPath : String  = self.rootUrl.path.appending(strFolderPath)
    do
    {
      try fileManager.removeItem(atPath: strPath)
      print("Folder delete OK：\(strPath)")
    }
    catch
    {
      print("Folder delete failed：\(error)")
    }
  }    
    
  //----------------------------------------------------------------//
  // FILE
  //----------------------------------------------------------------//
  func FileExisted(_ strFilePath: String) -> Bool
  {
    var isDir   : ObjCBool = false
    let strPath : String   = self.rootUrl.path.appending(strFilePath)
    let bRet    : Bool     = self.fileManager.fileExists(atPath : strPath, isDirectory: &isDir)
    
    if((isDir.boolValue == FALSE) && (bRet == TRUE))
    {
      return TRUE
    }
    else
    {
      return FALSE
    }    
  }
  
  func FileExistedUrl(_ strPath: String) -> Bool
  {
    var isDir   : ObjCBool = false
    let strPath : String   = strPath
    let bRet    : Bool     = self.fileManager.fileExists(atPath : strPath, isDirectory: &isDir)
    
    if((isDir.boolValue == FALSE) && (bRet == TRUE))
    {
      return TRUE
    }
    else
    {
      return FALSE
    }
  }

  func FileCopy(from sourceURL: URL, to destinationURL: URL)
  {
    let fileManager = FileManager.default
    
    do
    {
      //  check if file existed or remove it
      if fileManager.fileExists(atPath: destinationURL.path)
      {
        try fileManager.removeItem(at: destinationURL)
      }
      
      // copy file
      try fileManager.copyItem(at: sourceURL, to: destinationURL)
      print("\t [FILE] file copy done")
    }
    catch
    {      
      print("\t [FILE] file copy error")
    }
  }
  
  func FileSize(_ strFilePath : String) -> UInt64
  {
    var fileSize : UInt64 = 0
    let strPath = self.rootUrl.path.appending(strFilePath)
    do
    {
      let attr = try self.fileManager.attributesOfItem(atPath: strPath)
      fileSize = attr[FileAttributeKey.size] as! UInt64
    }
    catch
    {
      print("Error: \(error)")
    }
    return fileSize
  }
  
  func FileReadLineAll(_ strFileName : String) ->[String]
  {
    var strArr : [String]? = [String]()
    let strPath = self.rootUrl.path.appending(strFileName)
    do
    {
      let content = try String(contentsOfFile: strPath, encoding: String.Encoding.utf8)
      
      strArr = content.components(separatedBy: "\n")
      if(strArr == nil)
      {
        return [String]()
      }
      else
      {
        return strArr!
      }
    }
    catch
    {
      return [String]()
    }
  }
  
  func FileReadLine(_ fp : FileHandle) -> String
  {
    var strValue : String = ""
    let iCount : Int = 1
    while(TRUE)
    {
      let pbData : [UInt8] = self.FileRead(fp, iCount)
      if(pbData.count == 0)
      {
        break
      }
      if(pbData[0] == 0x0A) //< \n
      {
        break
      }
      strValue = String(format : "%@%c", strValue, pbData[0])
    }
    return strValue
  }
  
  func FileRead(_ fp: FileHandle, _ iCount : Int) -> [UInt8]
  {
    let data : Data = fp.readData(ofLength: iCount)
    let pbData : [UInt8]? = Array(data)
    if(pbData == nil)
    {
      return []
    }
    else
    {
      return pbData!
    }
  }
  
  func FileDeletrUrl(at urlFile: URL)
  {
    let fileManager = FileManager.default
    do
    {
      if fileManager.fileExists(atPath: urlFile.path)
      {
        try fileManager.removeItem(at: urlFile)
        print("File has been deleted")
      }
      else
      {
        print("File not existed")
      }
    }
    catch
    {
      print("Failed to delete the file: \(error)")
    }
  }

  func FileDataSave(to urlFileOutput: URL,  _ data: Data)
  {
    do
    {
      // 將 Data 寫入指定的 URL
      try data.write(to: urlFileOutput)
      print("Data successfully written to \(urlFileOutput)")
    }
    catch
    {
      print("Error writing data to file: \(error)")
    }
 }  

  func FileDataLoad(from urlFile: URL) -> Data?
  {
    do
    {
      // load data from a file URL
      let data = try Data(contentsOf: urlFile)           
      return data
    }
    catch
    {
      print("Error loading data: \(error)")
      return nil
    }
  }  
  
  func FileList(_ strFilePath: String) ->[String]
  {
    let strPath : String  = self.rootUrl.path.appending(strFilePath)
    print(String(format : "\t\t LIST: %@ -> %@\n", strFilePath, strPath))
    
    let enumerator        = FileManager.default.enumerator(atPath: strPath)
    let strFilePathArr    = enumerator?.allObjects as! [String]
    
    var filePathArr : [String] = [String]()
    
    for(index, value) in strFilePathArr.enumerated()
    {
      // Display indexes and values.
      print("\(index) = \(value)\n")
      filePathArr.append(value)
    }
    return filePathArr
  }
  
  func FolderList(_ strFolderPath: String) ->[String]
  {
    let strPath : String  = self.rootUrl.path.appending(strFolderPath)
    do
    {
      let filePathArr = try self.fileManager.contentsOfDirectory(atPath : strPath)
      return filePathArr
    }
    catch
    {
      return []
    }
  }
    
  func FileOpen(_ strFilePath: String, _ strFormat : String) ->FileHandle?
  {
    let fp : FileHandle?
    let strPath = self.rootUrl.path.appending(strFilePath)
    var bAppend : Bool = FALSE
                    
    ///
    if(strFormat == "a+")
    {
      if(self.FileExisted(strFilePath) == FALSE)
      {
        // Create file
        self.fileManager.createFile(atPath: strPath, contents: nil, attributes: nil)
      }
      fp = FileHandle(forWritingAtPath: strPath)
      bAppend = TRUE
    }
    else if(strFormat == "w+")
    {
      // Create file
      self.fileManager.createFile(atPath: strPath, contents: nil, attributes: nil)
      fp = FileHandle(forWritingAtPath: strPath)
    }
    else if(strFormat == "a")
    {
      fp = FileHandle(forWritingAtPath: strPath)
      bAppend = TRUE
    }
    else if(strFormat == "w")
    {
      fp = FileHandle(forWritingAtPath: strPath)
    }
    else if(strFormat == "r")
    {
      fp = FileHandle(forReadingAtPath: strPath)
    }
    else
    {
      return nil
    }
        
    if(fp == nil)
    {
      print(String(format : "[FILE_CTL] file open failed -> %@, format - %@", strFilePath, strFormat))
      return nil
    }
    
    // append
    if(bAppend == TRUE)
    {
      do
      {
        try fp!.seekToEnd()
      }
      catch
      {
        print("[ERROR][FILE_CTL] failed to seek to end\n")
        return  fp
      }      
    }
    
    return fp
  }
  
  func FileOpenUrl(_ urlFilePath: URL, _ strFormat : String) ->FileHandle?
  {
    let fp : FileHandle?
    let strPath :String = urlFilePath.path
    var bAppend : Bool = FALSE
                    
    ///
    if(strFormat == "a+")
    {
      if(self.FileExistedUrl(strPath) == FALSE)
      {
        // Create file
        self.fileManager.createFile(atPath: strPath, contents: nil, attributes: nil)
      }
      fp = FileHandle(forWritingAtPath: strPath)
      bAppend = TRUE
    }
    else if(strFormat == "w+")
    {
      // Create file
      self.fileManager.createFile(atPath: strPath, contents: nil, attributes: nil)
      fp = FileHandle(forWritingAtPath: strPath)
    }
    else if(strFormat == "a")
    {
      fp = FileHandle(forWritingAtPath: strPath)
      bAppend = TRUE
    }
    else if(strFormat == "w")
    {
      fp = FileHandle(forWritingAtPath: strPath)
    }
    else if(strFormat == "r")
    {
      fp = FileHandle(forReadingAtPath: strPath)
    }
    else
    {
      return nil
    }
        
    if(fp == nil)
    {
      print(String(format : "[FILE_CTL] file open failed -> %@, format - %@", strPath, strFormat))
      return nil
    }
    
    // append
    if(bAppend == TRUE)
    {
      do
      {
        try fp!.seekToEnd()
      }
      catch
      {
        print("[ERROR][FILE_CTL] failed to seek to end\n")
        return  fp
      }      
    }
    
    return fp
  }
  
  func FileClose(_ fp: FileHandle)
  {
    fp.closeFile()
  }
  
  func FileWrite(_ fp: FileHandle, _ bDataArr: [UInt8])
  {
    fp.write(Data( _ : bDataArr))
  }
    
  func FilePrint(_ fp: FileHandle, _ strValue: String)
  {
    let bDataArr = [UInt8](strValue.utf8)
    self.FileWrite(fp, bDataArr)
  }
}
