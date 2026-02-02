//--------------------------------------------------------------------------------
// @file  PacketCmd.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

//-------------------------------------------------------------------------------//
// Command Group
//-------------------------------------------------------------------------------//
public let CMD_GROUP_ID_I2C    = (0x20)
public let CMD_GROUP_ID_SMB    = (0x30)
public let CMD_GROUP_ID_SPI    = (0x40)
public let CMD_GROUP_ID_UART   = (0x50)
public let CMD_GROUP_ID_GPIO   = (0x60)
public let CMD_GROUP_ID_MOTOR  = (0x70)
public let CMD_GROUP_ID_ADC    = (0x80)
public let CMD_GROUP_ID_I2C2   = (0x99)
public let CMD_GROUP_ID_DAC    = (0xA0)
public let CMD_GROUP_ID_PWM    = (0xA1)
public let CMD_GROUP_ID_IOE    = (0xA2)
public let CMD_GROUP_ID_TMP    = (0xA3)
public let CMD_GROUP_ID_HMD    = (0xA4)
public let CMD_GROUP_ID_SREG   = (0xA5)
public let CMD_GROUP_ID_DF     = (0xAA)
public let CMD_GROUP_ID_JDS    = (0xAB)
public let CMD_GROUP_ID_JFILE  = (0xAC)
public let CMD_GROUP_ID_REPORT = (0xAD)

public let CMD_GROUP_ID_SYS    = (0xC0)
public let CMD_GROUP_ID_BLE    = (0xC2)

//-------------------------------------------------------------------------------//
// SYS
//-------------------------------------------------------------------------------//
public let CMD_SYS_VER_GET              = (0x00)
public let CMD_SYS_TIME_SET             = (0x40)
public let CMD_SYS_TIME_GET             = (0x41)
public let CMD_SYS_MEAS_INFO_GET        = (0x63)

public let CMD_SYS_SSN_GET              = (0xA0)
public let CMD_SYS_SSN_SET              = (0xA1)

//-------------------------------------------------------------------------------//
// BLE
//-------------------------------------------------------------------------------//
public let CMD_BLE_VSC_MODE_START        = (0x64)
public let CMD_BLE_VSC_MODE_STOP         = (0x65)

public let CMD_BLE_VSC_MODE_READ         = (0x6A)
public let CMD_BLE_VSC_MODE_TYPE_SET     = (0x70)

public let CMD_BLE_VSC_FILE_MODE_START   = (0x71)
public let CMD_BLE_VSC_FILE_MODE_STOP    = (0x72)
public let CMD_BLE_VSC_FILE_MODE_READ    = (0x73)
public let CMD_BLE_VSC_FILE_INFO_STS     = (0x74)
public let CMD_BLE_VSC_FILE_MODE_READ_EX = (0x76)

//-------------------------------------------------------------------------------//
// SREG
//-------------------------------------------------------------------------------//
public let CMD_SREG_READ                = (0x00)
public let CMD_SREG_WRITE               = (0x01)
public let CMD_SREG_ACT                 = (0x10)

//-------------------------------------------------------------------------------//
// FILE
//-------------------------------------------------------------------------------//
public let CMD_FILE_LIST_CLEAR          = (0x70)
public let CMD_FILE_LIST_READ           = (0x71)


public let CMD_ACK                     = 0x41

public let PACKET_CMD_HEADER_SIZE : Int = (8)

class PacketCmd : NSObject
{      
  //----------------------------------------------------//
  // In data packet 65 bytes
  //----------------------------------------------------//
  var bPCode    : UInt8         = 0          //< Command Group
  var bGroupId  : UInt8         = 0          //< Command Group
  var bCmd      : UInt8         = 0          //< Command Command Byte
  var bCheckSum : UInt8         = 0          //< Checksum
  var wMOSILen  : UInt16        = 0          //< Slave: Data in length /  Master Data out length
  var wMISOLen  : UInt16        = 0          //< Slave: Data out length /  Master Data in length
  var bData     : [UInt8]       = [UInt8]()  //< Data Buffer
  
  var utc       : TimeInterval  = 0          //< Data Buffer
  
  override init()
  {
    super.init()
  }
  
  deinit
  {
    bData = [UInt8]()
  }
  
  func Copy(_ pCacketCmd : PacketCmd)
  {
    //----------------------------------------------------//
    // In data packet 65 bytes
    //----------------------------------------------------//
    self.bPCode     = pCacketCmd.bPCode
    self.bGroupId   = pCacketCmd.bGroupId
    self.bCmd       = pCacketCmd.bCmd
    self.bCheckSum  = pCacketCmd.bCheckSum
    self.wMOSILen   = pCacketCmd.wMOSILen
    self.wMISOLen   = pCacketCmd.wMISOLen
    
    self.bData = [UInt8]()
    
    for i in 0..<pCacketCmd.bData.count
    {
      let bVal : UInt8 = pCacketCmd.bData[i]
      self.bData.append(bVal)
    }
    
    self.utc        = pCacketCmd.utc
  }
    
  func packetConvertToByteArray() -> [UInt8]
  {
    let iHeaderSize     : UInt16  = UInt16(PACKET_CMD_HEADER_SIZE)
    let byteArrayCnt    : Int     = Int(iHeaderSize + self.wMOSILen)
    var bPacketDataArr  : [UInt8] = Array(repeating: 0, count: byteArrayCnt)
    var idx : Int = 0
    var iCheckSum : Int = 0
    
    self.bCheckSum = 0
    
    // PCode
    bPacketDataArr[idx] = self.bPCode
    idx = idx + 1
    
    // Group Id
    bPacketDataArr[idx] = self.bGroupId
    idx = idx + 1
    
    // command
    bPacketDataArr[idx] = self.bCmd
    idx = idx + 1
    
    // Check sum
    bPacketDataArr[idx] = self.bCheckSum
    idx = idx + 1
    
    // Insert MOSI
    bPacketDataArr[idx] = UInt8(self.wMOSILen & 0xff)
    idx = idx + 1
    bPacketDataArr[idx] = UInt8((self.wMOSILen >> 8) & 0xff)
    idx = idx + 1

    // Insert MISO
    bPacketDataArr[idx] = UInt8(self.wMISOLen & 0xff)
    idx = idx + 1
    bPacketDataArr[idx] = UInt8((self.wMISOLen >> 8) & 0xff)
    idx = idx + 1
    
    //--------------------------------------------------//
    //  bData
    //--------------------------------------------------//
    for i in 0..<self.bData.count
    {
      if(idx >= byteArrayCnt)
      {
        break
      }
      bPacketDataArr[idx] = self.bData[i]
      idx = idx + 1
    }
    
    for i in 0..<bPacketDataArr.count
    {
      iCheckSum = (iCheckSum + Int(bPacketDataArr[i])) % 0x100
    }
    self.bCheckSum = UInt8(iCheckSum % 256)
    
    bPacketDataArr[3] = self.bCheckSum
    
    return bPacketDataArr
  }
}
