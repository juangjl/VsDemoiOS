//--------------------------------------------------------------------------------//
// @file  Func.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func DbgPrint(_ msg: String)
  {
    let date = Date()
    let dateFormatter = DateFormatter()
    var strTime : String = "";
      
    dateFormatter.timeZone   = TimeZone.current
    dateFormatter.locale     = NSLocale.current
    dateFormatter.dateFormat = "yyyy/MM/dd-HH:mm:ss.SSS"
    
    dateFormatter.date(from: String(describing: date))
    strTime = dateFormatter.string(from: date)

    //----------------------------------------------------------------//
    // Change \r\n to \r for log print (iOS only)
    //----------------------------------------------------------------//
    let normalized = msg.replacingOccurrences(of: "\r\n", with: "\r") 

    let strMsg : String = String(format :"[%@] %@", strTime, normalized)   
    print(strMsg, terminator: "");
  }
  
  func DataPrint(_ bDataArr : [UInt8])
  {
    var c        : UInt8 = 0x2E ///< "."
    var str      : String = ""
    var strAscii : String = ""
    str = String(format : "\r\n %@ Data Len = %d\r\n", str, bDataArr.count)
    for i in 0..<bDataArr.count
    {
      if((bDataArr[i] >= 48) && (bDataArr[i] <= 127))
			{
				c = bDataArr[i];
			}
			else
			{
				c = 0x2E ///< "."
			}

      if((i % 16) == 0)
      {
        strAscii = String(format:" %c", c)
      }
      else if((i % 16) == 8)
      {
        strAscii = String(format : "%@ %c", strAscii, c)
      }
      else
      {
        strAscii = String(format : "%@%c", strAscii, c)
      }

      if((i % 16) == 0)
      {
        str  = String(format : "%@\t\t %02X ", str, bDataArr[i])
        
      }
      else if((i % 16) == 8)
      {
        str = String(format : "%@- %02X ", str, bDataArr[i])
      }
      else if((i % 16) == 15)
      {
        str = String(format : "%@%02X %@\r\n", str, bDataArr[i], strAscii)
        strAscii = ""
      }
      else
      {
        str = String(format : "%@%02X ", str, bDataArr[i])
      }
    }
    
    //----------------------------------------------------------------//
    // padding space
    //----------------------------------------------------------------//
    let iCount1 : Int = (bDataArr.count % 16)
    if(iCount1 != 0)
    {
      for i in iCount1..<16
      {
        if(i == 8)
        {
          str = String(format : "%@%@", str, "- xx ")
        }
        else if(i == 15)
        {
          str = String(format : "%@%@", str, "xx")
          break
        }
        else
        {
          str = String(format : "%@%@ ", str, "xx")
        }
      }              
    }

    //----------------------------------------------------------------//
    // last line print
    //----------------------------------------------------------------//
    str = String(format : "%@ %@\r\n", str, strAscii);
    
    self.DbgPrint(str);
  }    
 	
  func FuncEcgDisplayAmpGet() ->Float
  {
    //let _ : Float = Float(self.iEcgChartRowCount)
    var fEcgDisplayAmp    : Float = Float(self.iEcgChartRowCount) / 2
  
    if(self.iEcgDisplayRange == ECG_DISPLAY_RANGE_2P5MM_MV)
    {
      fEcgDisplayAmp = fEcgDisplayAmp  * 4
    }
    else if(self.iEcgDisplayRange == ECG_DISPLAY_RANGE_5MM_MV)
    {
      fEcgDisplayAmp = fEcgDisplayAmp  * 2
    }
    else if(self.iEcgDisplayRange == ECG_DISPLAY_RANGE_10MM_MV)
    {
      //fEcgDisplayAmp = fEcgDisplayAmp
    }
    else if(self.iEcgDisplayRange == ECG_DISPLAY_RANGE_20MM_MV)
    {     
      fEcgDisplayAmp = fEcgDisplayAmp  * 0.5
    }
    else if(self.iEcgDisplayRange == ECG_DISPLAY_RANGE_40MM_MV)
    {
      fEcgDisplayAmp = fEcgDisplayAmp  * 0.25
    }
    
    //print(String(format : "\t\t [ECG][RANGE] ROW count = %0.0f, AMP = %0.2f, RANGE = %d", fEcgChartRowCount, fEcgDisplayAmp, self.iEcgDisplayRange))

    return fEcgDisplayAmp
  }

  func MainInit()
  {
    //----------------------------------------------------------------//
    // Init print
    //----------------------------------------------------------------//
    self.DbgPrint(String(format : "VS-SDK init version (%0.2f)\n", self.version));
    
    //----------------------------------------------------------------//
    // User Default Init
    //----------------------------------------------------------------//
    self.FuncJudInit()
    
    //----------------------------------------------------------------//
    // BLE Init
    //----------------------------------------------------------------//
    self.cbCentralManger = CBCentralManager(delegate: self, queue: nil);
   
    //----------------------------------------------------------------//
    // pDataSet Array init
    //----------------------------------------------------------------//
    for i in 0..<DATASET_COUNT
    {
      let dataSet = JDataSetType()
      dataSet.id = i
      self.pDataSet.append(dataSet)
    }
    
    //----------------------------------------------------------------//
    // Data Set time init
    //----------------------------------------------------------------//
    self.iDataSetTime = Array(repeating: Int(), count: DATASET_COUNT)
        
    //----------------------------------------------------------------//
    // create VS folder
    //----------------------------------------------------------------//
    self.FuncFolderInit()
    
    //----------------------------------------------------------------//
    // Auto-Connect
    //----------------------------------------------------------------//
    self.FuncAutoConnectInit()	    
  }
}

