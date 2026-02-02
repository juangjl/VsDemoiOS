//--------------------------------------------------------------------------------
// @file  PacketAck.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

class PacketAck : NSObject
{
  //----------------------------------------------------//
  // In data packet 64 bytes
  //----------------------------------------------------//
  var bPCode   : UInt8       = 0          //< Command Group
  var bGroupId : UInt8       = 0          //< Command Group
  var bAck     : UInt8       = 0          //< Command Command Byte
  var bChkSum  : UInt8       = 0          //< Checksum
  var wDataIdx : UInt16      = 0          //< Data in length
  var wDataLen : UInt16      = 0          //< Data out length
  var bData    : [UInt8]     = [UInt8]()  //< In Data Buffer
    
  override init()
  {
    super.init()
  }
  
  deinit
  {
    bData = [UInt8]() 
  }
  
  func packetDecode(_ bPacketDataArr : [UInt8])
  {
    var idx   : Int = 0
    var array : [UInt8]
    var wData : UInt16 = 0
    //var iDataIdx : Int = 0
    
    // Insert PCode
    self.bPCode = bPacketDataArr[idx]
    idx = idx + 1
    
    // Insert Group Id
    self.bGroupId = bPacketDataArr[idx]
    idx = idx + 1
    
    // Insert command
    self.bAck = bPacketDataArr[idx]
    idx = idx + 1
    
    // Insert sum
    self.bChkSum = bPacketDataArr[idx]
    idx = idx + 1
    
    // Data Idx
    array = [bPacketDataArr[idx], bPacketDataArr[idx + 1]]
    memcpy(&wData, array, 2)
    //data = Data(array)
    //value = UInt16(littleEndian: data.withUnsafeBytes {$0.pointee})
    self.wDataIdx = wData
    idx = idx + 2
    
    // Data Len
    array = [bPacketDataArr[idx], bPacketDataArr[idx + 1]]
    memcpy(&wData, array, 2)
    self.wDataLen = wData
    idx = idx + 2
    
    if(idx == bPacketDataArr.count)
    {
      //print("[PACKET][DECODE] : wData = \(self.wDataLen)")
      return
    }
    
    // Data
    if(idx > bPacketDataArr.count)
    {
      print("[PACKET][DECODE][!!!!!!!!] : Data overflow")
      return
    }
    
    for i in idx..<bPacketDataArr.count
    {
      let bVal = bPacketDataArr[i]
      self.bData.append(bVal)
    }
  }
}
