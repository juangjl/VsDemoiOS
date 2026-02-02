//--------------------------------------------------------------------------------//
// @file  VsPeripheral.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2024 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth

public class VsPeripheral : NSObject , Identifiable, Codable
{
  public let id = UUID(); //< for list usage
  
  public var peripheral     : CBPeripheral!
  public var iRSSI          : Int32 = 0
  public var strDeviceName  : String = "";
  public var strMacAddr     : String = "";
  public var iSec           : Int  = 0;
  
  var isConnected : Bool = false
    
  override init()
  {  
    self.iRSSI          = 0;
    self.strDeviceName  = "";
    self.strMacAddr     = "";
  }
    
  func set(peripheral: CBPeripheral)
  {
    self.peripheral = peripheral;
  }
  
  // Codable
  public required init(from decoder:Decoder) throws
  {
    
  }

  public func encode(to encoder: Encoder) throws
  {
    
  }
}
