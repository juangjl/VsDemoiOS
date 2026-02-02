//--------------------------------------------------------------------------------
// @file  VscModeItem.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

public let  VSC_MODE_ITEM_DATA_SIZE  : Int     = (800)  //< Data size
public let  VSC_MODE_TYPE0_DATA_SIZE : Int     = (800)  //< 2 channel 200 ms
public let  VSC_MODE_TYPE1_DATA_SIZE : Int     = (400)  //< 1 channel 200 ms
public let  VSC_MODE_ITEM_INFO_SIZE  : Int     = (168)  //< 42 information

public let  VSC_MODE_ITEM_INFO_COUNT : Int     = (VSC_MODE_ITEM_INFO_SIZE / 4)  //< 168 / 4 =  42

class VscModeItemType
{
  var   wId   : UInt16     = 0             //< Packet Idx
  var   wLen  : UInt16     = 0             //< Packet Idx
  var   bData : [UInt8]    = [UInt8]()     //< 800 bytes channels data
  var   fInfo : [Float]    = [Float]()     //< 104 bytes  for information 26 x 4 = 104
  
  init()
  {
    self.wId   = 0
    self.wLen  = 0
    self.bData = Array(repeating: UInt8(), count : VSC_MODE_ITEM_DATA_SIZE)
    self.fInfo = Array(repeating: Float(), count : VSC_MODE_ITEM_INFO_SIZE / 4)
  }
    
  deinit
  {
    self.bData = [UInt8]()  
    self.fInfo = [Float]()  
  }
  
  func Clear()
  {
    self.bData = [UInt8]()  
    self.fInfo = [Float]()  
  }
  
  func Copy(_ pItem : VscModeItemType)
  {
    self.wId  = pItem.wId
    self.wLen = pItem.wLen

    self.bData = [UInt8]()  
    self.fInfo = [Float]()  
    
    for i in 0..<pItem.bData.count
    {
      let bVal : UInt8 = UInt8(pItem.bData[i])
      self.bData.append(bVal)
    }
    for i in 0..<pItem.fInfo.count
    {
      let fVal : Float = Float(pItem.fInfo[i])
      self.fInfo.append(fVal)
    }    
  }
}

