//--------------------------------------------------------------------------------//
// @file  FuncBle.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI


extension VsSDK: CBCentralManagerDelegate
{
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
  // https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate
  //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
  public func centralManagerDidUpdateState(_ central: CBCentralManager)
  {

  }
  
  // Discover ble device
  public func centralManager(_ central: CBCentralManager,
                             didDiscover peripheral: CBPeripheral,
                             advertisementData: [String : Any],
                             rssi RSSI: NSNumber)
  {
    var strDeviceName   : String       = "";
    var strMacAddr      : String       = "";    
    var bFound          : Bool         = false;
    let vsPeripheral    : VsPeripheral = VsPeripheral();
    let strDevice       : String       = "VSH"
    
    if(advertisementData["kCBAdvDataLocalName"] != nil)
    {
      strDeviceName = (advertisementData["kCBAdvDataLocalName"] as! String)
      vsPeripheral.strDeviceName = strDeviceName;
    }
    else
    {
      return;
    }
    
    if(strDeviceName.contains(strDevice) == true)
    {

    }
    else
    {
      return
    }
        
    if(advertisementData["kCBAdvDataLeBluetoothDeviceAddress"] != nil)
    {
      strMacAddr = (advertisementData["kCBAdvDataLocalName"] as! String)
      //strMacAddr = String(describing: advertisementData["kCBAdvDataLeBluetoothDeviceAddress"]!)      
    }
  
    vsPeripheral.set(peripheral: peripheral)
    
    vsPeripheral.iRSSI = Int32(truncating : RSSI);
    vsPeripheral.strMacAddr = strMacAddr;
              
    for vsp in vsPeripheralArr
    {
      if(vsp.strDeviceName == vsPeripheral.strDeviceName)
      {
        vsp.iSec = 0;
        vsp.iRSSI = vsPeripheral.iRSSI;
        bFound = true;
        return;
      }
    }
    
    if(bFound == false)
    {
      vsPeripheralArr.append(vsPeripheral);
    }
  }
  
  public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral)
  {    
    print("[BLE-CENTRAL] ble peripheral disconnected")
    
    self.bBleConnected = FALSE;
  }
  
  public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
  {
    let serviceUUIDs: [CBUUID] = [CBUUID(string: UUID_VS_SERVICE)]
    
    peripheral.delegate = self; //< set delegate to VsSDK

    peripheral.discoverServices(serviceUUIDs);
  }
}

extension VsSDK : CBPeripheralDelegate
{
  public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
  {
    guard error == nil else
    {
      print("[BLE-PERIPHERAL] Service discovery failed")
      return
    }
    //print("[BLE-PHERIPHERAL] Services discovered")
    for service: CBService in peripheral.services!
    {
      if(service.uuid.uuidString == UUID_VS_SERVICE)
      {
        peripheral.discoverCharacteristics(nil, for: service)
        return
      }
    }
  }
  
  public func peripheral(_ peripheral: CBPeripheral,  didDiscoverCharacteristicsFor service: CBService,     error: Error?)
  {
    var bFound : Bool = FALSE
    guard error == nil else
    {
      print("[BLE-PERIPHERAL] Service characteristics failed")
      return
    }

    //---------------------------------------------------------------------------------------------------------//
    // Fnd  VitalSigns UART  service
    //---------------------------------------------------------------------------------------------------------//
    
    for characteristic : CBCharacteristic in service.characteristics!
    {
      if(characteristic.uuid.uuidString == UUID_VS_SERVICE_CHAR_TX)
      {       
        self.charTX = characteristic;
        self.iBleTxEn = TRUE;
      }
      
      if(characteristic.uuid.uuidString == UUID_VS_SERVICE_CHAR_RX)
      {        
        self.iBleRxEn = TRUE;
        self.charRX = characteristic;
        peripheral.setNotifyValue(true, for: characteristic)
        bFound = TRUE
      }
    }
    self.bBleConnected = TRUE;
    if(bFound  == TRUE)
    {
      self.iBleState        = BLE_STATE_CONNECT_INIT
      self.iViewId          = VIEW_ID_MEASUREMENT
      self.iDeviceVersion   = 0;
      self.iVsh101Module    = 0;      
    }
    else
    {
    }
    self.cbPeripheral = peripheral    
  }
   
  public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
  {
    guard error == nil else
    {
      if let e = error as? CBError
      {
        print("\tError#0 \(e.code): \(e.localizedDescription)")
      }
      else
      {
        print("\t Error#1  \(error!.localizedDescription)")
      }
      
      self.DbgPrint(String(format : "[ERROR] BLE Write Error!!! %@\n", characteristic.uuid.uuidString));
      return
    }
    
    
  _ = characteristic.uuid.uuidString
  }
  
  public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
  {

    guard error == nil else
    {
      if let e = error as? CBError
      {
        print("\tError#0 \(e.code): \(e.localizedDescription)")
      }
      else
      {
        print("\t Error#1 \(error!.localizedDescription)")
      }
      
      self.DbgPrint(String("[ERROR]  didUpdateValueFor !!!\n"))

      return
    }
    
    guard let pbReceived = characteristic.value else
    {
      print("[BLE-MANAGER] Notification received from: \(characteristic.uuid.uuidString), with empty value")
      print("[BLE-MANAGER] Empty packet received")

      return
    }
    
    let pbData : [UInt8] = [UInt8](pbReceived)
       
    self.PacketReadHandler(pbData)
  }
  
  public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?)
  {
    guard error == nil else
    {
      if let e = error as? CBError
      {
        print("\tError#0 \(e.code): \(e.localizedDescription)")
      }
      else
      {
        print("\t Error#1 \(error!.localizedDescription)")
      }
      
      self.DbgPrint(String("[ERROR] didUpdateNotificationStateFor !!!\n"));
      return
    }
    
    if(characteristic == self.charRX)
    {
      
    }
  }
}

extension VsSDK
{
  func BleConnectedDeviceGet()
  {
    var vsPeripheral    : VsPeripheral = VsPeripheral()
    let serviceUuidArr = [CBUUID(string : UUID_VS_SERVICE)]
    let peripheralArr  = self.cbCentralManger.retrieveConnectedPeripherals(withServices: serviceUuidArr)
    var i  : Int = 1
      
    self.vsPeripheralConnectedArr = [VsPeripheral]()

    for peripheral in peripheralArr
    {
      vsPeripheral = VsPeripheral()
      vsPeripheral.set(peripheral: peripheral)
    
      vsPeripheral.strDeviceName = (peripheral.name ?? "Unknwon")
      vsPeripheral.iRSSI      = 0
      vsPeripheral.strMacAddr = ""

      print(String(format : "\t\t %02d: %@ connected  - Peripheral identifier %@", i, vsPeripheral.strDeviceName,  peripheral.identifier.uuidString))
      
      self.vsPeripheralConnectedArr.append(vsPeripheral)      
      i = i + 1
    }
    
    if(self.vsPeripheralConnectedArr.count > 0)
    {
      print(String(format : "\t [BLE]Peripherals connected count = %d", self.vsPeripheralConnectedArr.count))
    }
  }

  func BleSMDeviceConnect(_ vsPeripheral : VsPeripheral)
  {  
    self.BleScanStop()
    self.vsPeripheralSelected = vsPeripheral    
    self.BleConnect(vsPeripheral)
  }

  public func BleScanStart()
  {
    if(self.cbCentralManger?.state != .poweredOn)
    {
      print(String(format : "[BLE] BLE is not poweredon\r\n"));
      return;
    }
    vsPeripheralArr.removeAll()
    self.bBleScanStart = TRUE
    self.cbCentralManger?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
  }
  
  public func BleScanStop()
  {
    if(self.cbCentralManger?.isScanning == true)
    {
      self.cbCentralManger?.stopScan();
    }
    else
    {
      print("BLE Scan start first\r\n");
    }
    self.bBleScanStart = FALSE
  }

  public func BleConnect(_ vsPeripheral: VsPeripheral)
  {
    self.bBleConnected = FALSE
    self.iBleTxEn = FALSE;
    self.iBleRxEn = FALSE;

    if(self.cbCentralManger?.state != .poweredOn)
    {
      self.bBleConnected = FALSE
      print(String(format : "[BLE] BLE is not poweredon\r\n"));
      return;
    }
    self.cbCentralManger?.connect(vsPeripheral.peripheral, options: nil);
    self.vsPeripheralConnected = vsPeripheral;
  }
  
  public func BleDisconnect()
  {
    if(self.cbCentralManger?.state != .poweredOn)
    {
      self.bBleConnected = FALSE
      print(String(format : "[BLE] BLE is not poweredon\r\n"));
      return;
    }
    
    if(self.bBleConnected == FALSE)
    {
      return;
    }
    self.cbCentralManger?.cancelPeripheralConnection(self.vsPeripheralConnected.peripheral);
    self.bBleConnected = FALSE
  }
  
  public func BleTxWrite(_ bDataArr : [UInt8])
  {
    let data = Data(bDataArr)
    guard self.cbPeripheral.state == .connected else
    {
      self.DbgPrint(String(format : "[BleOtaDataWrite] Peripheral disconnect, \n"))
      self.bBleConnected = false;
      return
    }

    self.cbPeripheral.writeValue(data, for: self.charTX, type:  CBCharacteristicWriteType.withResponse)
    BlePacketEvent()
  }

  public func FWVersionSet(_ iVersion : Int32)
  {
    self.iFwVersion = iVersion
  }

  public func FWCheckSumSet(_ dwSum : UInt32)
  {
    self.dwCheckSum = dwSum
  }

  public func BlePacketErrorRateStart()
  {
    self.DbgPrint(String(format : "BlePacketErrorRateStart\n"))
    self.iBlePackerErrorCount = 0
    self.iBlePacketTotalCount = 0
    self.bBlePERStart = TRUE
    self.tBlePacketStartTime = Date().timeIntervalSince1970
  }

  public func BlePacketErrorRateStop()
  {
    self.DbgPrint(String(format : "BlePacketErrorRateStop\n"))
    self.tBlePacketEndTime = Date().timeIntervalSince1970
    self.bBlePERStart = FALSE
  }

  public func BlePacketErrorRateFpsGet()-> Float
  {
    var fData : Float = 0
  
    self.tBlePacketEndTime = Date().timeIntervalSince1970
    let deltaTime = Int64(self.tBlePacketEndTime - self.tBlePacketStartTime)
    fData = Float(self.iBlePacketTotalCount)
    fData = fData / Float(deltaTime)

    return fData
  }

  public func BlePacketEvent()
  {
    if(self.bBlePERStart == FALSE)
    {
      return
    }
  
    self.iBlePacketTotalCount = self.iBlePacketTotalCount + 1;
  }
 
  public func BlePacterErrorEvent()
  {
    if(self.bBlePERStart == FALSE)
    {
      return
    }
    self.iBlePackerErrorCount = self.iBlePackerErrorCount + 1
  }
}
