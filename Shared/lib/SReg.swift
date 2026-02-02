//--------------------------------------------------------------------------------//
// @file  JSReg.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import SwiftUI

//------------------------------------------------------------------------------------------------//
// SREG Command Name
//------------------------------------------------------------------------------------------------//
public let  SREG_DEVICE_NAME             : String = "SREG_DEVICE_NAME"
public let  SREG_DEVICE_RESET            : String = "SREG_DEVICE_RESET"
public let  SREG_DEVICE_SSN              : String = "SREG_DEVICE_SSN"
public let  SREG_MEAS_ZERO_BASE          : String = "SREG_MEAS_ZERO_BASE"
public let  SREG_MEAS_LEAD_OFF           : String = "SREG_MEAS_LEAD_OFF"
public let  SREG_MEAS_LEAD_OFF_COMP_TH   : String = "SREG_MEAS_LEAD_OFF_COMP_TH"
public let  SREG_MEAS_LEAD_OFF_CURR      : String = "SREG_MEAS_LEAD_OFF_CURR"
public let  SREG_MEAS_MOTION_MODE        : String = "SREG_MEAS_MOTION_MODE"
public let  SREG_MEAS_SAMPLE_RATE        : String = "SREG_MEAS_SAMPLE_RATE"
public let  SREG_DEVICE_ID               : String = "SREG_DEVICE_ID"
public let  SREG_DEVICE_IDLE_SLEEP_TIME  : String = "SREG_DEVICE_IDLE_SLEEP_TIME"
public let  SREG_DEVICE_BEACON           : String = "SREG_DEVICE_BEACON"
public let  SREG_MONITOR_MEAS_ONLY       : String = "SREG_MONITOR_MEAS_ONLY"
public let  SREG_CHARG_POWER_DOWN        : String = "SREG_CHARG_POWER_DOWN"
public let  SREG_ADVERTISING_INTERVAL    : String = "SREG_ADVERTISING_INTERVAL"
public let  SREG_ADVERTISING_FIXED       : String = "SREG_ADVERTISING_FIXED"
public let  SREG_SYSTEM_PIN_CHALLENGE    : String = "SREG_SYSTEM_PIN_CHALLENGE"
public let  SREG_SYSTEM_PIN_ENABLE       : String = "SREG_SYSTEM_PIN_ENABLE"
public let  SREG_SYSTEM_PIN_CODE         : String = "SREG_SYSTEM_PIN_CODE"

public let  SREG_ECG_ALG_TYPE            : String = "SREG_ECG_ALG_TYPE"
public let  SREG_ECG_SW_GAIN             : String = "SREG_ECG_SW_GAIN"
public let  SREG_ECG_MIN_VPP_VALUE       : String = "SREG_ECG_MIN_VPP_VALUE"
public let  SREG_DEVICE_CHIP_STATUS      : String = "SREG_DEVICE_CHIP_STATUS"
public let  SREG_ECG_MIN_VPP_MV          : String = "SREG_ECG_MIN_VPP_MV"
public let  SREG_CHARG_BEACON_ENABLE     : String = "SREG_CHARG_BEACON_ENABLE"
public let  SREG_TIMER_TRIMING_ENABLE    : String = "SREG_TIMER_TRIMING_ENABLE"
public let  SREG_FILE_RING_MODE          : String = "SREG_FILE_RING_MODE"
public let  SREG_CMD_ECG_WAVEFORM_CH     : String = "SREG_CMD_ECG_WAVEFORM_CH"
public let  SREG_VSC_CHANNEL             : String = "SREG_VSC_CHANNEL"
public let  SREG_LPF_CUT_OFF_FREQ        : String = "SREG_LPF_CUT_OFF_FREQ"
public let  SREG_HPF_CUT_OFF_FREQ        : String = "SREG_HPF_CUT_OFF_FREQ"
public let  SREG_NOTCH_50                : String = "SREG_NOTCH_50"
public let  SREG_NOTCH_60                : String = "SREG_NOTCH_60"
public let  SREG_BLE_PAIR_CHECK          : String = "SREG_BLE_PAIR_CHECK"
public let  SREG_ECG_HW_GAIN             : String = "SREG_ECG_HW_GAIN"
public let  SREG_MOTION_ATR_MARK         : String = "SREG_MOTION_ATR_MARK"
public let  SREG_TEMP_GAIN               : String = "SREG_TEMP_GAIN"
public let  SREG_TEMP_OFFSET             : String = "SREG_TEMP_OFFSET"

public let  SREG_ACT_READ  : Bool = FALSE
public let  SREG_ACT_WRITE : Bool = TRUE

public let SREG_CMD_STATE_IDLE      : Int = 0
public let SREG_CMD_STATE_ISSUE     : Int = 1
public let SREG_CMD_STATE_BUSY      : Int = 2
public let SREG_CMD_STATE_DONE      : Int = 3

//------------------------------------------------------------------------------------------------//
// SREG type
//------------------------------------------------------------------------------------------------//
public let SREG_NAME_SIZE       = (32)
public let SREG_DATA_SIZE       = (64)


//------------------------------------------------------------------------------------------------//
// SREG CMD
//------------------------------------------------------------------------------------------------//
public let SREG_TIMEOUT : Int64 = 200

class SRegType
{
  var  strName : String = ""
  
  //------------------------------------------------------------------------//
  // SREG Read or Write
  //------------------------------------------------------------------------//
  var  bAction    : Bool    = SREG_ACT_READ
  
  var bCmdOn      : Bool    = FALSE
  
  //------------------------------------------------------------------------//
  // SREG Data
  //------------------------------------------------------------------------//
  var  bNameData: [UInt8]  = Array(repeating: 0, count: SREG_NAME_SIZE)
  var  bData: [UInt8]      = Array(repeating: 0, count: SREG_DATA_SIZE)
  
  //------------------------------------------------------------------------//
  // SREG Data
  //------------------------------------------------------------------------//
  var  iCmdState   : Int    = SREG_CMD_STATE_IDLE
  var  iCmdUtcMS   : Int64  = 0
  
  var  bAck               : UInt8 = 0
  var  bAckFailDisConnect : Bool = TRUE

  //------------------------------------------------------------------------//
  // SREG Data
  //------------------------------------------------------------------------//
  var strSRegDeviceName             : String = "VSH101"
  var strSRegDeviceSsn              : String = "000-00-0000"
  var strSRegMeasZeroBase           : String = "OFF"
  var strSRegMeasLeadOff            : String = "ON"
  var strSRegMeasLeadOffCompTh      : String = ""
  var strSRegMeasLeadOffCurr        : String = ""
  var strSRegMeasMotionMode         : String = "ON"
  var strSRegMeasSampleRate         : String = "500"
  var strSRegDeviceID               : String = "123456"
  var strSRegDeviceIdleToSleepTime  : String = "30"
  var strSRegDeviceBeaconMode       : String = "OFF"
  var strSRegMonitorMeasOnly        : String = "OFF"
  var strSRegChargerPowerDown       : String = "OFF"
  var strSRegBleAdvertisingKeep     : String = "OFF"
  var strSRegBleAdvertisingInterval : String = "100"
  var strSRegPinCode                : String = "1234"
  var strSRegPinChallenge           : String = "FAIL"
  var strSRegPinCodeEnable          : String = "ON"
  var bDevPinCodeEnable             : Bool   = false
  var bDevPinCodeChallenge          : Bool   = false
  var strSregDeviceEcgAlgType       : String = "1"
  var strSregDeviceEcgSWGain        : String = "1.00"
  var strSregEcgMinVppValue         : String = "550"
  var strSregDeviceChargeBeaconEn   : String = "OFF"
  var strSregDeviceTimerTrimingEn   : String = "OFF"
  var strSregDeviceChipStatus       : String = "00"
  var bDevPeripheralErr             : UInt8   = 0
  var strDeviceFileRingMode         : String  = "ON"
  var strSRegEcgWaveformCh          : String  = "0"
  var strSRegVscChannel             : String  = "0"
  var strSRegLpfCutOffFreq          : String  = "60"
  var strSRegHpfCutOffFreq          : String  = "0.9"
  var strSRegNotCh50                : String  = "ON"
  var strSRegNotCh60                : String  = "ON"
  var strSRegDeviceBlePairCheck     : String  = "OFF"
  var strSRegDeviceEcgHWGain        : String  = "1"
  var strSRegMotionAtrMark          : String  = "ON"
  var strSRegTempGain               : String  = "1.0"
  var strSRegTempOffset             : String  = "0.0"

  init()
  {
 
  }
    
  deinit
  {
  }
  
  func CleanData()
  {
    self.strName   = ""
    self.bCmdOn    = FALSE
    self.iCmdUtcMS = 0
    
    self.strSRegDeviceName             = ""         //<
    self.strSRegDeviceSsn              = ""         //<
    self.strSRegMeasZeroBase           = ""         //<
    self.strSRegMeasLeadOff            = ""         //<
    self.strSRegMeasLeadOffCompTh      = ""         //<
    self.strSRegMeasLeadOffCurr        = ""         //<
    self.strSRegMeasMotionMode         = ""         //<
    self.strSRegMeasSampleRate         = ""         //<
    self.strSRegDeviceID               = ""         //<
    self.strSRegDeviceIdleToSleepTime  = ""         //<
    self.strSRegDeviceBeaconMode       = ""         //<
    self.strSRegMonitorMeasOnly        = ""         //<
    self.strSRegChargerPowerDown       = ""
    self.strSRegBleAdvertisingKeep     = ""
    self.strSRegBleAdvertisingInterval = ""
    self.strSRegPinCode                = ""
    self.strSRegPinChallenge           = ""
    self.strSRegPinCodeEnable          = ""
    self.strSregDeviceChipStatus       = ""
    self.strDeviceFileRingMode         = ""
    self.strSRegDeviceBlePairCheck     = ""
    self.strSRegMotionAtrMark          = ""

    for i in 0..<self.bNameData.count
    {
      self.bNameData[i] = 0
    }
    
    for i in 0..<self.bData.count
    {
      self.bData[i] = 0
    }
  }
  
  func Timeout()
  {
    self.CleanData()
  }
  
  func NameSet(_ strName : String)
  {
    let str = self.Left(strName, SREG_NAME_SIZE - 1)
    self.strName = str
    let bStrData = Array(str.utf8)
    
    for i in 0..<self.bNameData.count
    {
      if(i < bStrData.count)
      {
        self.bNameData[i] = bStrData[i]
      }
      else
      {
        self.bNameData[i] = 0
      }
    }
  }
  
  func Left(_ strData : String, _ iCount : Int) -> String
  {
    var strValue : String = strData
    if(strValue.count > iCount)
    {
      let index = strValue.index(strValue.startIndex, offsetBy: iCount)
      strValue = String(strValue.prefix(upTo: index))
    }
    return strValue
  }
  
  func BytesToString(_ bData : [UInt8]) -> String
  {
    var str  : String = ""
    var idx : Int  = 0
    
    // [UInt8] to String
    for i in 0..<bData.count
    {
      if(bData[i] == 0)
      {
        break;
      }
      idx = i
    }
    if(idx > 0)
    {
      str = String(decoding: bData[0...idx], as: UTF8.self)
    }
    return str
  }
  
  func FloatToBytes(_ fVal : Float)->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: fVal, Array.init)
    return bArr
  }
  
  func BytesToFloat(_ bArr : [UInt8])->Float
  {
    let  data  = Data(bArr)
    let fVal : Float  = data.withUnsafeBytes { $0.load(as: Float.self) }
    return fVal
  }
  
  func Int32ToBytes(_ iVal : Int32 )->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: iVal, Array.init)
    return bArr
  }
  
  func BytesToInt32(_ bArr : [UInt8])->Int32
  {
    let  data  = Data(bArr)
    let iVal : Int32  = data.withUnsafeBytes { $0.load(as: Int32.self) }
    return iVal
  }
  
  func UInt32ToBytes(_ dwVal : UInt32 )->[UInt8]
  {
    let bArr : [UInt8] = withUnsafeBytes(of: dwVal, Array.init)
    return bArr
  }
  
  func BytesToUInt32(_ bArr : [UInt8])->UInt32
  {
    let  data  = Data(bArr)
    let dwVal : UInt32  = data.withUnsafeBytes { $0.load(as: UInt32.self) }
    return dwVal
  }
  
  //------------------------------------------------------------------------------------------------//
  //
  // SREG Action
  //
  //------------------------------------------------------------------------------------------------//
  func SRegAction()
  {
    if(self.strName == SREG_DEVICE_NAME)
    {
      self.SRegActDeviceName()
    }
    if(self.strName == SREG_DEVICE_RESET)
    {
      // Do nothing
    }
    if(self.strName == SREG_DEVICE_SSN)
    {
      self.SRegActDeviceSsn()
    }
    else if(self.strName == SREG_MEAS_ZERO_BASE)
    {
      self.SRegActMeasZeroBase()
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF)
    {
      self.SRegActMeasLeadOff()
    }
    else if(self.strName == SREG_CHARG_POWER_DOWN)
    {
      self.SRegActChargerPowerDown()
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF_COMP_TH)
    {
      self.SRegActMeasLeadCompTh()
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF_CURR)
    {
      self.SRegActMeasLeadCurr()
    }
    else if(self.strName == SREG_MEAS_MOTION_MODE)
    {
      self.SRegActMeasMotionMode()
    }
    else if(self.strName == SREG_MEAS_SAMPLE_RATE)
    {
      self.SRegActMeasSampleRate()
    }
    else if(self.strName == SREG_DEVICE_ID)
    {
      self.SRegActDeviceId()
    }
    else if(self.strName == SREG_DEVICE_IDLE_SLEEP_TIME)
    {
      self.SRegActDeviceIdleToSleepTime()
    }
    else if(self.strName == SREG_DEVICE_BEACON)
    {
      self.SRegActDeviceBeacon()
    }
    else if(self.strName == SREG_MONITOR_MEAS_ONLY)
    {
      self.SRegActMonitorMeasOnly()
    }
    else if(self.strName == SREG_ADVERTISING_FIXED)
    {
      self.SRegActBleAdvertisingFixed()
    }
    else if(self.strName == SREG_ADVERTISING_INTERVAL)
    {
      self.SRegActBleAdvertisingInterval()
    }
    else if(self.strName == SREG_SYSTEM_PIN_CHALLENGE)
    {
      self.SRegActDeviceChallengePinCode()
    }
    else if(self.strName == SREG_DEVICE_CHIP_STATUS)
    {
      self.SRegActDeviceChipStatus()
    }
    else if(self.strName == SREG_BLE_PAIR_CHECK)
    {
      self.SRegActBlePairCheck()
    }
    else if(self.strName == SREG_SYSTEM_PIN_ENABLE)
    {
      self.SRegActDevicePinCodeEnable()
    }
    else if(self.strName == SREG_SYSTEM_PIN_CODE)
    {
      self.SRegActDevicePinCode()
    }
    else if(self.strName == SREG_FILE_RING_MODE)
    {
      self.SRegActDeviceFileRingMode()
    }
    else if(self.strName == SREG_ECG_ALG_TYPE)
    {
      self.SRegActDeviceEcgAlgType()
    }
    else if(self.strName == SREG_ECG_SW_GAIN)
    {
      self.SRegActDeviceEcgSWGain()
    }
    else if(self.strName == SREG_ECG_HW_GAIN)
    {
      self.SRegActDeviceEcgHWGain()
    }
    else if(self.strName == SREG_ECG_MIN_VPP_VALUE)
    {
      self.SRegActDeviceEcgMinVppValue()
    }
    else if(self.strName == SREG_ECG_MIN_VPP_MV)
    {
      self.SRegActDeviceEcgMinVppMv()
    }
    else if(self.strName == SREG_CHARG_BEACON_ENABLE)
    {
      self.SRegActDeviceChargeBeaconEnable()
    }
    else if(self.strName == SREG_TIMER_TRIMING_ENABLE)
    {
      self.SRegActDeviceTimerTrimingEnable()
    }
    else if(self.strName == SREG_CMD_ECG_WAVEFORM_CH)
    {
      self.SRegActEcgWaveFormChannel()
    }
    else if(self.strName == SREG_VSC_CHANNEL)
    {
      self.SRegActVscChannel()
    }
    else if(self.strName == SREG_NOTCH_60)
    {
      self.SRegActFilterNotch60()
    }
    else if(self.strName == SREG_NOTCH_50)
    {
      self.SRegActFilterNotch50()
    }
    else if(self.strName == SREG_LPF_CUT_OFF_FREQ)
    {
      self.SRegActLpfCutOffFreq()
    }
    else if(self.strName == SREG_HPF_CUT_OFF_FREQ)
    {
      self.SRegActHpfCutOffFreq()
    }
    else if(self.strName == SREG_MOTION_ATR_MARK)
    {
      self.SregActMotionAtrMark()
    }
    else if(self.strName == SREG_TEMP_GAIN)
    {
      self.SRegActTempGain()
    }
    else if(self.strName == SREG_TEMP_OFFSET)
    {
      self.SRegActTempOffset()
    }

    self.bCmdOn    = FALSE
    self.iCmdState = SREG_CMD_STATE_DONE
    self.iCmdUtcMS = Date().millisecondsSince1970
  }
  
  func DataSet(_ strData : String)
  {
    var bArr : [UInt8] = [UInt8]()
    
    if(self.strName == SREG_DEVICE_NAME)
    {
      bArr =  Array(strData.utf8)
    }
    else if(self.strName == SREG_DEVICE_RESET)
    {
      // Do nothing
    }
    else if(self.strName == SREG_DEVICE_SSN)
    {
      bArr =  Array(strData.utf8)
    }
    else if(self.strName == SREG_MEAS_ZERO_BASE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName ==  SREG_CHARG_POWER_DOWN)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_ADVERTISING_FIXED)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_ADVERTISING_INTERVAL)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF_COMP_TH)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_MEAS_LEAD_OFF_CURR)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_MEAS_MOTION_MODE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_MEAS_SAMPLE_RATE)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_DEVICE_ID)
    {
      let dwVal : UInt32 = UInt32((strData as NSString).intValue)
      bArr = self.UInt32ToBytes(dwVal)
    }
    else if(self.strName == SREG_DEVICE_IDLE_SLEEP_TIME)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_DEVICE_BEACON)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }    
    else if(self.strName == SREG_MONITOR_MEAS_ONLY)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
        self.strSRegMonitorMeasOnly = "ON"
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
        self.strSRegMonitorMeasOnly = "OFF"
      }
    }
    else if(self.strName == SREG_ECG_ALG_TYPE)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_ECG_HW_GAIN)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_ECG_SW_GAIN)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_ECG_MIN_VPP_VALUE)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_ECG_MIN_VPP_MV)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_CHARG_BEACON_ENABLE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_TIMER_TRIMING_ENABLE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_SYSTEM_PIN_CHALLENGE)
    {
      /// default setting 
      self.bDevPinCodeChallenge = false
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_SYSTEM_PIN_ENABLE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_DEVICE_CHIP_STATUS)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_SYSTEM_PIN_CODE)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_FILE_RING_MODE)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_MOTION_ATR_MARK)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_CMD_ECG_WAVEFORM_CH)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_VSC_CHANNEL)
    {
      let iVal : Int32 = Int32((strData as NSString).intValue)
      bArr = self.Int32ToBytes(iVal)
    }
    else if(self.strName == SREG_NOTCH_60)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_NOTCH_50)
    {
      if(strData == "ON")
      {
        let bData : UInt8 = 0x01
        bArr.append(bData)
      }
      else
      {
        let bData : UInt8 = 0x00
        bArr.append(bData)
      }
    }
    else if(self.strName == SREG_LPF_CUT_OFF_FREQ)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_HPF_CUT_OFF_FREQ)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_TEMP_GAIN)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }
    else if(self.strName == SREG_TEMP_OFFSET)
    {
      let fVal : Float = (strData as NSString).floatValue
      bArr = self.FloatToBytes(fVal)
    }

    print(String( format : "\t\t [SREG] STR = '%@' , bArr = %d, bData = %d", strData, bArr.count, bData.count))
    
    for i in 0..<self.bData.count
    {
      if(i < bArr.count)
      {
        self.bData[i] = bArr[i]
      }
      else
      {
        self.bData[i] = 0
      }
    }
  }
  
  //------------------------------------------------------------------------------------------------//
  //
  // SREG Function Action
  //
  //------------------------------------------------------------------------------------------------//
  func SRegActDeviceName()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceName))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      self.strSRegDeviceName = self.BytesToString(self.bData)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceName))
    }
  }
  
  func SRegActDeviceSsn()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceSsn))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      self.strSRegDeviceSsn = self.BytesToString(self.bData)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceSsn))
    }
  }
  
  func SRegActMeasZeroBase()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasZeroBase))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegMeasZeroBase = "ON"
        
      }
      else
      {
        self.strSRegMeasZeroBase = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasZeroBase))
    }
  }

  func SRegActChargerPowerDown()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegChargerPowerDown))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegChargerPowerDown = "ON"

      }
      else
      {
        self.strSRegChargerPowerDown = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegChargerPowerDown))
    }
  }

  func SRegActBleAdvertisingInterval()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegBleAdvertisingInterval))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iInterval = self.BytesToInt32(self.bData)
      self.strSRegBleAdvertisingInterval = String(format : "%d", iInterval)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegBleAdvertisingInterval))
    }
  }

  func SRegActBleAdvertisingFixed()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegBleAdvertisingKeep))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegBleAdvertisingKeep = "ON"
      }
      else
      {
        self.strSRegBleAdvertisingKeep = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegBleAdvertisingKeep))
    }
  }

  
  func SRegActMeasLeadOff()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasLeadOff))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegMeasLeadOff = "ON"
      }
      else
      {
        self.strSRegMeasLeadOff = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasLeadOff))
    }
  }
  
  func SRegActMeasLeadCompTh()
  {
    
  }
  
  func SRegActMeasLeadCurr()
  {
    
  }
  
  func SRegActMeasMotionMode()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegMeasMotionMode = "ON"
      }
      else
      {
        self.strSRegMeasMotionMode = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
  }

  func SRegActMeasSampleRate()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasSampleRate))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iSampleRate = self.BytesToInt32(self.bData)
      self.strSRegMeasSampleRate = String(format : "%d", iSampleRate)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasSampleRate))
    }
  }
  
  func SRegActDeviceId()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceID))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let dwID = self.BytesToUInt32(self.bData)
      self.strSRegDeviceID = String(format : "%d", dwID)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceID))
    }
  }
  
  func SRegActDeviceIdleToSleepTime()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceIdleToSleepTime))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSRegDeviceIdleToSleepTime = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceIdleToSleepTime))
    }
  }
  func SRegActDeviceChipStatus()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//      
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSregDeviceChipStatus = String(format : "%X", iVal)
      self.bDevPeripheralErr = self.bData[0];
      //print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregDeviceChipStatus))
    }
  }
  
  func SRegActDeviceChallengePinCode()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      if(self.bAck == UInt8(CMD_ACK))
      {
        self.strSRegPinChallenge = "PASS"
        self.bDevPinCodeChallenge = true
      }
      else
      {
        self.strSRegPinChallenge = "FAIL"
        self.bDevPinCodeChallenge = false
      }
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegPinChallenge))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegPinChallenge))
    }
  }

  func SRegActDeviceFileRingMode()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strDeviceFileRingMode))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strDeviceFileRingMode = "ON"
      }
      else
      {
        self.strDeviceFileRingMode = "OFF"
      }
      print(String( format :"\t\t [SREG]SRegActDeviceInternalStorage SREG[%@] = '%@' --> OK\n", self.strName, self.strDeviceFileRingMode))
    }
  }

  func SRegActBlePairCheck()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceBlePairCheck))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegDeviceBlePairCheck = "ON"
      }
      else
      {
        self.strSRegDeviceBlePairCheck = "OFF"
      }
//      print(String( format :"\t\t [SREG]SRegActBlePairCheck SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceBlePairCheck))
    }

  }

  func SRegActDevicePinCodeEnable()
  {
    let date = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.timeZone   = TimeZone.current
    dateFormatter.locale     = NSLocale.current
    dateFormatter.dateFormat = "yyyy/MM/dd-HH:mm:ss.SSS"
    dateFormatter.date(from: String(describing: date))
    
    if(self.bAction == SREG_ACT_WRITE)
    {
      
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegPinCodeEnable = "ON"
        self.bDevPinCodeEnable = true;

      }
      else
      {
        self.bDevPinCodeEnable = false;
        self.strSRegPinCodeEnable = "OFF"
      }
    }

  }

  func SRegActDevicePinCode()
  {
    let date = Date()
    let dateFormatter = DateFormatter()
    var strTime : String = "";
    dateFormatter.timeZone   = TimeZone.current
    dateFormatter.locale     = NSLocale.current
    dateFormatter.dateFormat = "yyyy/MM/dd-HH:mm:ss.SSS"
    dateFormatter.date(from: String(describing: date))
    strTime = dateFormatter.string(from: date)
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"'%@'\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n",strTime, self.strName, self.strSRegMeasLeadOff))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      let iInterval = self.BytesToInt32(self.bData)
      self.strSRegPinCode = String(format : "%d", iInterval)

      print(String( format :"'%@'\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n",strTime, self.strName, self.strSRegPinCode))
    }
  }

  func SRegActDeviceEcgAlgType()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregDeviceEcgAlgType))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSregDeviceEcgAlgType = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregDeviceEcgAlgType))
    }
  }
  
  func SRegActDeviceEcgHWGain()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSRegDeviceEcgHWGain = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
  }

  func SRegActDeviceEcgSWGain()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSregDeviceEcgSWGain = String(format : "%.2f", fVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }

  }

  func SRegActTempGain()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegTempGain))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSRegTempGain = String(format : "%.1f", fVal)
      print(String( format :"\t\t [SREG][ACT] [SR]SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegTempGain))
    }
  }

  func SRegActTempOffset()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegTempOffset))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSRegTempOffset = String(format : "%.1f", fVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegTempOffset))
    }
  }


  func SRegActLpfCutOffFreq()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegLpfCutOffFreq))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSRegLpfCutOffFreq = String(format : "%.1f", fVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegLpfCutOffFreq))
    }
  }

  func SRegActHpfCutOffFreq()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegHpfCutOffFreq))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSRegHpfCutOffFreq = String(format : "%.1f", fVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegHpfCutOffFreq))
    }
  }
  func SRegActVscChannel()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegVscChannel))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSRegVscChannel = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegVscChannel))
    }
  }

  func SregActMotionAtrMark()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMotionAtrMark))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------/
      if(self.bData[0] == 0x01)
      {
        self.strSRegMotionAtrMark = "ON"
      }
      else
      {
        self.strSRegMotionAtrMark = "OFF"
      }

      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMotionAtrMark))
    }

  }

  func SRegActEcgWaveFormChannel()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegEcgWaveformCh))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSRegEcgWaveformCh = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegEcgWaveformCh))
    }
  }
  func SRegActFilterNotch50()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegNotCh50))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegNotCh50 = "ON"
      }
      else
      {
        self.strSRegNotCh50 = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegNotCh50))
    }
  }
  func SRegActFilterNotch60()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegNotCh60))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegNotCh60 = "ON"
      }
      else
      {
        self.strSRegNotCh60 = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegNotCh60))
    }
  }
  func SRegActDeviceEcgMinVppValue()
  {

    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
    print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let iVal = self.BytesToInt32(self.bData)
      self.strSregEcgMinVppValue = String(format : "%d", iVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
  }
  func SRegActDeviceEcgMinVppMv()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      let fVal = self.BytesToFloat(self.bData)
      self.strSregEcgMinVppValue = String(format : "%.3f", fVal)
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSregEcgMinVppValue))
    }
  }
  func SRegActDeviceTimerTrimingEnable()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSregDeviceTimerTrimingEn = "ON"
      }
      else
      {
        self.strSregDeviceTimerTrimingEn = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
  }

  func SRegActDeviceChargeBeaconEnable()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSregDeviceChargeBeaconEn = "ON"
      }
      else
      {
        self.strSregDeviceChargeBeaconEn = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMeasMotionMode))
    }
  }

  func SRegActDeviceBeacon()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceBeaconMode))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegDeviceBeaconMode = "ON"
      }
      else
      {
        self.strSRegDeviceBeaconMode = "OFF"
      }
      print(String( format :"\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegDeviceBeaconMode))
    }
  }
  
  func SRegActMonitorMeasOnly()
  {
    if(self.bAction == SREG_ACT_WRITE)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_WRITE
      //----------------------------------------------------------------------------------------------//
      print(String( format :"\t\t [SREG][ACT][WRITE] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMonitorMeasOnly))
    }
    else if(self.bAction == SREG_ACT_READ)
    {
      //----------------------------------------------------------------------------------------------//
      // SREG_ACT_READ
      //----------------------------------------------------------------------------------------------//
      if(self.bData[0] == 0x01)
      {
        self.strSRegMonitorMeasOnly = "ON"
      }
      else
      {
        self.strSRegMonitorMeasOnly = "OFF"
      }
      print(String(format : "\t\t [SREG][ACT] SREG[%@] = '%@' --> OK\n", self.strName, self.strSRegMonitorMeasOnly))
    }
  }
  
}
