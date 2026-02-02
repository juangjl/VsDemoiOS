//--------------------------------------------------------------------------------//
// @file  VsSDK.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension Date
{
  var millisecondsSince1970 : Int64
  {
    return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
  }

  init(milliseconds : Int)
  {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
  }
}

extension UIDevice {
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }

    //MARK: Get String Value
    var totalDiskSpaceInGB : String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }

    var freeDiskSpaceInGB : String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }

    var usedDiskSpaceInGB : String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }

    var totalDiskSpaceInMB : String {
        return MBFormatter(totalDiskSpaceInBytes)
    }

    var freeDiskSpaceInMB : String {
        return MBFormatter(freeDiskSpaceInBytes)
    }

    var usedDiskSpaceInMB : String {
        return MBFormatter(usedDiskSpaceInBytes)
    }

    //MARK: Get raw value
    var totalDiskSpaceInBytes :Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }

    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes : Int64
    {
        if #available(iOS 11.0, *)
        {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
              return space
            } else {
                return 0
            }
        }
        else
        {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }

    var usedDiskSpaceInBytes : Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
}

public class VsSDK: NSObject, ObservableObject
{
  //------------------------------------------------------------------------------------------------//
  //
  // Variable Area
  //
  //------------------------------------------------------------------------------------------------//
  
  //----------------------------------------------------------------//
  // VsSDK is a global variable
  //----------------------------------------------------------------//
  static let shared : VsSDK = VsSDK()
  
  //----------------------------------------------------------------//
  // Task
  //----------------------------------------------------------------//
  var bTaskMainLoopOn : Bool = FALSE
  var bTaskSubLoopOn  : Bool = FALSE
    
  //----------------------------------------------------------------//
  // version
  //----------------------------------------------------------------//
  let version : Float = 1.01

  
  //----------------------------------------------------------------//
  // Timer and System control
  //----------------------------------------------------------------//
  var timer         : Timer    = Timer()
  var dwSysCtl2     : UInt32   = 0
  var dwSecLoop     : UInt32   = 0
	
  //----------------------------------------------------------------//
  // Task Control
  //----------------------------------------------------------------//
  var bTaskLoopOn   : Bool     = FALSE
  var bSubLoopOn    : Bool     = FALSE
    

  //----------------------------------------------------------------//
  // Mainloop
  //----------------------------------------------------------------//
  var iLoopCoount   : Int64    = 0
  var iLoopMSSum    : Int64    = 0
  var fLoopMSAvg    : Float64  = 0
  var iLoopT0       : Int64    = 0
  var iLoopT1       : Int64    = 0
  var iLoopMS       : Int64    = 0
  var iLoopMSMax    : Int64    = 0

  //----------------------------------------------------------------//
  // Time Control
  //----------------------------------------------------------------//
  var fTimer1Period : Float    = 10
  
  var iTimeMS       : Int      = 0
  
  var iTime10MS     : Int      = 0
  var iTime50MS     : Int      = 0
  var iTime100MS    : Int      = 0
  var iTimeSec      : Int      = 0
  
  var iTime10MSPre  : Int      = -1
  var iTime50MSPre  : Int      = -1
  var iTime100MSPre : Int      = -1
  var iTimeSecPre   : Int      = -1
  
  var iTimeTick     : Int64    = 0
  var iTimeTickPre  : Int64    = -1

  //----------------------------------------------------------------//
  // View
  //----------------------------------------------------------------//
  var iViewId             :Int = VIEW_ID_ENTRY
  var iViewIdPre          :Int = VIEW_ID_ENTRY
  
  //----------------------------------------------------------------//
  // SReg Control
  //----------------------------------------------------------------//
  var SReg          : SRegType = SRegType()

  //----------------------------------------------------------------//
  // Device information
  //----------------------------------------------------------------//
  var iDeviceVersion : Int32  = 0
  var iVsh101Module  : Int    = 0
  var iBatteryLevel  : Int    = 0
  var iBatteryVolt   : Int    = 0
  var strDeviceName  : String = ""
  var strDeviceSsn   : String = ""
  var iFwVersion     : Int32  = 0
  var dwCheckSum     : UInt32 = 0
  var bChkFWSum      : Bool   = false

  //----------------------------------------------------------------//
  let QueueVscMode        = DispatchQueue(label: "QUEUE_VSC_MODE")
  let QueueFileVscMode    = DispatchQueue(label: "QUEUE_FILE_VSC_MODE")
  let QueueVscAtr         = DispatchQueue(label: "QUEUE_VSC_ATR")
  let QueueFileAtr        = DispatchQueue(label: "QUEUE_FILE_ATR")    

  //----------------------------------------------------------------//
  // Trend Queue
  //----------------------------------------------------------------//  
  let QueueFileTrend      = DispatchQueue(label: "QUEUE_FILE_TREND")
  let QueueReportTrend    = DispatchQueue(label: "QUEUE_REPORT_TREND")

  //----------------------------------------------------------------//
  // Packet
  //----------------------------------------------------------------//
  var bPacketCmdOn          : Bool         = FALSE
  var packetCmdArr          : [PacketCmd]  = [PacketCmd]()
  var packetOut             : PacketCmd    = PacketCmd()
  var packetIn              : PacketAck    = PacketAck()
  var bPacketReadDataArr    : [UInt8]      = [UInt8]()
  var iBleReSendCnt         : Int          = 0
  var iBleWaitT0            : Int64        = 0
  var iBleWaitT1            : Int64        = 0
    
  //----------------------------------------------------------------//
  // BLE : CentralManager & Peripheral
  //----------------------------------------------------------------//
  public var cbCentralManger : CBCentralManager!
  var cbPeripheral           : CBPeripheral!
  var vsPeripheralSelected   : VsPeripheral!
  var vsPeripheralConnected  : VsPeripheral!
  
  public var vsPeripheralArr :[VsPeripheral] = [VsPeripheral]()
  
  //----------------------------------------------------------------//
  // BLE Characteristics
  //----------------------------------------------------------------//
  // TX / RX
  var charTX                : CBCharacteristic!
  var charRX                : CBCharacteristic!
  
  var bDiskAlartEn          : Bool = TRUE;

  //----------------------------------------------------------------//
  // BLE Connected Devices
  //----------------------------------------------------------------//
  var vsPeripheralConnectedArr : [VsPeripheral] = []

  //----------------------------------------------------------------//
  // BLE
  //----------------------------------------------------------------//
  var iBleInitStep  : Int   = BLE_INIT_STEP0
  var bBleScanStart : Bool  = FALSE
  var bBleConnected : Bool  = FALSE
  var iBleState     : Int   = BLE_STATE_CLOSE
  var iBleTxEn      : Bool   = FALSE
  var iBleRxEn      : Bool   = FALSE

  //----------------------------------------------------------------//
  // BLE PACKET ERROR RATE
  //----------------------------------------------------------------//
  var tPacketT0MS              : Int64  = 0
  var bBlePERStart             : Bool   = FALSE
  var tBlePacketStartTime      : Double = 0
  var tBlePacketEndTime        : Double = 0
  var iBlePacketTotalCount     : Int64  = 0
  var iBlePackerErrorCount     : Int64  = 0

  //----------------------------------------------------------------//
  // VSC_MODE
  //----------------------------------------------------------------//
  var dwVscModeType     : UInt32 = UInt32(VSC_MODE_TYPE1)
  
  var iVscModeWaitT0    : Int64 = 0                         //< Init step wait
  var iVscModeWaitT1    : Int64 = 0                         //< Init step wait
  var iVscModeInitStep  : Int = VSC_MODE_INIT_STEP0
  
  var VscModeCtl        : VscModeCtlType = VscModeCtlType()
  var bVscModeReadOn    : Bool = FALSE
  var fVscModeSec       : Float = 0
  var bVscModeAdded     : Bool = FALSE
  var vscModeQueue              : [VscModeCtlType] = [VscModeCtlType]()
  var VscTimet0 : Int64 = 0
  var VscTimet1 : Int64 = 0
  
  var vscModeSaveQueue          : [VscModeCtlType] = [VscModeCtlType]()
  
  var iVscModeIdxNotFoundCnt    : Int       = 0
  var iVscModeStartUtc          : Int64     = 0
  var iVscModeEndUtc            : Int64     = 0
  var iVscModeEclapsedSec       : Int64     = 0
  
  var iVscModeMSStart           : Int64     = 0  //< VSC_MODE measurement start time in MS from 1970
  var iVscModeMSEnd             : Int64     = 0  //< VSC_MODE measurement end time in MS from 1970
      
  //----------------------------------------------------------------//
  // VSC_MODE FILE
  //----------------------------------------------------------------//
  var bVscModeSave              : Bool = TRUE

  var strVscBaseFolder          : String   = ""
  var strVscDateFolder          : String   = ""
  var strVscHourFolder          : String   = ""
  
  var bHourFolderCreate         : Bool    = FALSE
  
  var strVscFileNameEcgBin      : [String] = [String]()
  var strVscFileNameEcgCsv      : [String] = [String]()
  var strVscFileNameInfoCsv     : String = ""
  var strVscFileNameGSensorCsv  : String = ""
  var strVscFileNameAtrBin      : String = ""
  var strVscFileNameAtrCsv      : String = ""
  
  //----------------------------------------------------------------//
  // VSC_FILE_MODE
  //----------------------------------------------------------------//
  var bVscFileModeEnable            : Bool = FALSE
	
  //----------------------------------------------------------------//
  // VSC_MODE ATR Queue
  //----------------------------------------------------------------//
  var vscAtrQueue     : [JAtrType] = [JAtrType]()
  var iVscAtrCnt      : Int = 0
  var iVscAtrCntPre   : Int = 0
  var vscAtrNow       : JAtrType = JAtrType()
  var vscAtrPre       : JAtrType = JAtrType()
  
  //----------------------------------------------------------------//
  // VSC_MODE ATR FILE Save Queue
  //----------------------------------------------------------------//
  var fileAtrAddQueue    : [JAtrType] = [JAtrType]()
  
  //------------------------------------------------------------//
  // Information for load
  //------------------------------------------------------------//
  var vsInfoNow      : VSInfo     = VSInfo()
  var vsInfoFile     : VSInfo     = VSInfo()
    
  //------------------------------------------------------------//
  // DataSet : for charts
  //------------------------------------------------------------//
  var pDataSet      : [JDataSetType] = [JDataSetType]()
  var iDataSetTime  : [Int] = [Int]()
    
  //------------------------------------------------------------//
  // Chart
  //------------------------------------------------------------//
  var bChartBleDataUpdate   : Bool = FALSE
  
  let chartBleEcg0          : JChartType = JChartType()
  let chartBleEcg1          : JChartType = JChartType()
  
  var bChartFileDataUpdate  : Bool = FALSE
  let chartFileEcg0         : JChartType = JChartType()
  let chartFileEcg1         : JChartType = JChartType()
  
  // Report Chart
  var chartReportEcgArr  : [JChartType] = Array(repeating: JChartType(), count : 22)    
  
  //------------------------------------------------------------//
  // File & Folder Control
  //------------------------------------------------------------//
  let fileCtl : JFileCtlType = JFileCtlType()    
    
  //------------------------------------------------------------//
  // Atr for chart display
  //------------------------------------------------------------//
  var atrArrChartBle  : [JAtrType] = [JAtrType]()
  var atrArrChartFile : [JAtrType] = [JAtrType]()
    
  //------------------------------------------------------------//
  // Util
  //------------------------------------------------------------//
  let util : Util = Util()
  
  //------------------------------------------------------------//
  // JUD
  //------------------------------------------------------------//
  let jud : JUserDefault = JUserDefault()
  
  //----------------------------------------------------------------//
  // Auto-Connect , Auto-Measurement
  //----------------------------------------------------------------// 
  var bAutoConnectOn            : Bool = FALSE    //< JUD_KEY_CONNECT_ON            : Auto Connect Function
  var strAutoConnectName        : String = ""     //< JUD_KEY_CONNECT_NAME          : Device Name for auto Connect Function
  var bAutoConnectStatus        : Bool = FALSE    //< JUD_KEY_CONNECT_STATUS        : Auto Connect Status
  var bAutoMeasurementStatus    : Bool = FALSE    //< JUD_KEY_MEASUREMENT_SATATUS   : Auto Measurement Status
  
  var bAutuMeasurementExecute   : Bool = FALSE    //< Execute once in UI
    
  var iAutoConnectT0            : Double  = 0
  var iAutoConnectT1            : Double  = 0
  var iAutoConnectState         : Int     = 0
  
  //------------------------------------------------------------//
  // BLE Pin Code
  //------------------------------------------------------------//
  var bDisclaimer   : Bool = true

  //------------------------------------------------------------//
  // Health Infomation for display
  //------------------------------------------------------------//
  var healthInfo : JHealthInfo = JHealthInfo()

  //------------------------------------------------------------//
  // ECG Display
  //------------------------------------------------------------//
  var iEcgDisplayRange : Int        = ECG_DISPLAY_RANGE_10MM_MV  

  var iEcgChartRowCount : Int        = 12
  var iEcgChartColCount : Int        = 30

  var iMeasurementPeriodArr : [Int]    =
  [
    MEASUREMENT_PERIOD_CONTINUE,
    MEASUREMENT_PERIOD_6_MIN,
    MEASUREMENT_PERIOD_1_HOUR,
    MEASUREMENT_PERIOD_24_HOUR,
    MEASUREMENT_PERIOD_48_HOUR,
  ]

  //----------------------------------------------------------------//
  // atr bypass HR setting
  //----------------------------------------------------------------//
  var iAtrBypassStage : Int = ATR_UNREADABLE_NULL_STAGE

  //------------------------------------------------------------------------------------------------//
  //
  // Function Area
  //
  //------------------------------------------------------------------------------------------------//
  override public init()
  {
    super.init()
    
    self.MainInit()
    self.iViewId = VIEW_ID_ENTRY;
  }
}
