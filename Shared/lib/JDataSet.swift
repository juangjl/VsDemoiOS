//--------------------------------------------------------------------------------
// @file  JDataSetType.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2022 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------
import Foundation

public let  JDATA_SAMPLE_RATE       = (500) //< Hz
public let  JDATA_MAX_SEC           = (12)  //< second
public let  JDATA_MAX_CNT           = (JDATA_SAMPLE_RATE * JDATA_MAX_SEC)

class JDataSetType
{
  var id : Int  = 0
  var idx : Int = 0
  var cnt : Int = 0
  var data : [Float] = [Float]()
  
  init()
  {
  }
    
  deinit
  {
    self.data =  [Float]()
  }
  
  func JDataSetAdd(iData : Int) -> Bool
  {
    let idx : Int = self.idx;
    let cnt : Int = self.cnt;
    if(cnt >= JDATA_MAX_CNT)
    {
      return FALSE;
    }

    self.data[idx] = Float(iData);

    self.idx =  self.idx + 1;
    self.cnt =  self.cnt + 1;
    return TRUE;
  }
  
  func JDataSetAdd(fData : Float) -> Bool
  {
    let cnt : Int = self.cnt;
    if(cnt >= JDATA_MAX_CNT)
    {
      return FALSE;
    }

    self.data.append(fData)
    self.cnt = self.data.count
    self.idx =  self.idx + 1;
    return TRUE;
  }
  
  func JDataSetGetEx(idx: Int) -> Float
  {
    return self.data[idx]
  }
  
  func JDataSetGet(idx: Int) ->Float
  {
    return self.data[idx];
  }
  
  func JDataSetReset()
  {
    self.idx = 0
    self.cnt = 0;
    self.data =  [Float]()
  }
  
  func JDataSetInit()
  {
    self.JDataSetReset()
  }
  
  func JDataSetFIFOAdd(_ pfData: [Float], _ iCount : Int, _ iFIFOSize: Int)
  {
    var fVal : Float = 0
   
    //-------------------------------------------//
    // Shift data
    //-------------------------------------------//
    if((self.data.count + iCount) > iFIFOSize)
    {
      let shiftCount : Int = self.data.count + iCount - iFIFOSize
      self.data = Array(self.data[shiftCount..<self.data.count])
    }
    
    //-------------------------------------------//
    // Add N data
    //-------------------------------------------//
    for i in 0..<iCount
    {
      fVal = Float(pfData[i])
      self.data.append(fVal)
    }    
  }
}

