//--------------------------------------------------------------------------------//
// @file  FuncPacket.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func ActSBleSysVersionGet()
  {
    var idx : Int  = 0
    let strVSH101Module = "VSH101_43"
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint("[ACT][ERROR] Version NACK\r\n")
      return
    }
    
    // [UInt8] to String
    for i in 4..<packetIn.bData.count
    {
      if(packetIn.bData[i] == 0)
      {
        break;
      }
      idx = i
    }
    self.strDeviceName = String(decoding: packetIn.bData[4...idx], as: UTF8.self)
    
    // [UInt8] to Int32
    let subArr = Array(packetIn.bData[0...3])
    memcpy(&self.iDeviceVersion, subArr, 4)
    // check the VSH101 module is current
    if(strVSH101Module == self.strDeviceName)
    {
      self.iVsh101Module = 1;
    }
    else
    {
      self.iVsh101Module = 0;
    }
    
    self.PacketCmdEnd()
		
    /// after the FW version 228 add the pin code
    if(self.iBleState == BLE_STATE_CONNECT_INIT)
    {
      if(self.iDeviceVersion <= 228)
      {
        self.iBleInitStep = BLE_INIT_STEP_FINISH;
      }
      else
      {
        self.iBleInitStep = BLE_INIT_STEP3;
      }
    }
  }

  func ActSBleMeasInfoGet()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint("[ACT][ERROR] ActSBleMeasInfoGet NACK\r\n")
      return
    }

    memcpy(&self.iDeviceVersion, Array(self.packetIn.bData[16...19]), 4)
    memcpy(&self.iBatteryLevel,  Array(self.packetIn.bData[20...23]), 4)
    memcpy(&self.iBatteryVolt,   Array(self.packetIn.bData[38...41]), 4)

    self.PacketCmdEnd()
  }

  func ActSBleSysTimeSet()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR][SYS][TIME_SET] GROUP = %02X CMD = %02X \n", packetIn.bGroupId,  packetIn.bPCode))
      return
    }
    
    self.iBleInitStep = BLE_INIT_STEP1
    
    // end of packer command
    self.PacketCmdEnd()        
  }
  
  func ActSBleSysSsnGet()
  {
    var idx : Int  = 0
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint("[ACT][ERROR] Command NACK\r\n")
      return
    }
    
    // [UInt8] to String
    for i in 0..<packetIn.bData.count
    {
      if(packetIn.bData[i] == 0)
      {
        break;
      }
      idx = i
    }
    self.strDeviceSsn = String(decoding: packetIn.bData[0...idx], as: UTF8.self)
    
    self.iBleInitStep = BLE_INIT_STEP2
    self.PacketCmdEnd()
  }
  
  func ActSBleVscModeStart()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      return
    }
    // end of packer command
    self.PacketCmdEnd()
    
    self.iVscModeInitStep = VSC_MODE_INIT_STEP4
  }
  
  func ActSBleVscModeStop()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      self.bVscModeReadOn = FALSE   
      return
    }
    
    // end of packer command
    self.PacketCmdEnd()
  }
  
  func ActSBleVscFileModeStart()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      return
    }
    // end of packer command
    self.PacketCmdEnd()
    /// get the VSC File Mode start UTC
    let subArr = Array(packetIn.bData[0...3])
    memcpy(&self.iVscModeStartUtc, subArr, 4)
    self.VscModeCtl.iVscFileModeStartFlag = 1
    self.VscModeCtl.iVscFileModeIndex = 0
    self.iVscModeInitStep = VSC_MODE_INIT_STEP4
  }

  func ActSBleVscFileModeStop()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      self.bVscModeReadOn = FALSE   
      return
    }
    // end of packer command
    self.PacketCmdEnd()
  }
  
  func ActSBleVscFileListClearAll()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      self.bVscModeReadOn = FALSE
      return
    }
    self.iVscModeInitStep = VSC_MODE_INIT_STEP2
    // end of packer command
    self.PacketCmdEnd()
  }
  
  func ActSBleVscFileModeInfoStatus()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02x CMD = %02x \r\n", packetIn.bGroupId,  packetIn.bPCode))
      // end of packer command
      self.PacketCmdEnd()
      return
    }
    // get the VSC File Mode Running flag
    //    let subArr = Array(packetIn.bData[0...3])
    memcpy(&self.VscModeCtl.iVscFileEnableStatus, Array(self.packetIn.bData[0...3]), 4)
    // get the VSC File Mode start UTC
    //  let subArr = Array(packetIn.bData[4...7])
    memcpy(&self.VscModeCtl.dwVscStartUtc,  Array(self.packetIn.bData[4...7]), 4)
    // get the VSC File Mode current Index
    //  let subArr = Array(packetIn.bData[8...11])
    memcpy(&self.VscModeCtl.iVscFileModeIndex, Array(self.packetIn.bData[8...11]), 4)
    // get the VSC File Mode running sec
    //  let subArr = Array(packetIn.bData[12...15])
    memcpy(&self.VscModeCtl.dwVscFileModeRunSec,  Array(self.packetIn.bData[12...15]), 4)
    // get the VSC File Mode last command UTC
    //  let subArr = Array(packetIn.bData[16...19])
    memcpy(&self.VscModeCtl.dwVscFileModeLastUTC, Array(self.packetIn.bData[16...19]), 4)
    // get the VSC File Mode Last command Index
    //  let subArr = Array(packetIn.bData[20...23])
    memcpy(&self.VscModeCtl.iVscFileModeLastIndex, Array(self.packetIn.bData[20...23]), 4)    
    
    if(self.VscModeCtl.iVscFileEnableStatus == 1)
    {
      let strEnabled : String = self.FuncJudRead(JUD_KEY_VSC_FILE_MODE)
      if(strEnabled == "OFF")
      {
        /// setting the ON
        self.FuncJudWrite(JUD_KEY_VSC_FILE_MODE, "ON")
        self.DbgPrint("RESET THE VSC FILE MODE ON \r\n");
      }
    }
    if(self.iBleInitStep == BLE_INIT_STEP3)
    {
      self.iBleInitStep = BLE_INIT_STEP4;
    }
    // end of packer command
    self.PacketCmdEnd()
  }

  func ActSBleVscFileModeRead()
  {
    var wId: UInt16 = 0
    var wLen: UInt16 = 0
    let pVscMode : VscModeCtlType = VscModeCtlType()
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][!!!!!] GROUP = %02x CMD = %02x \r\n", packetIn.bGroupId,  packetIn.bPCode))
      // end of packer command
      self.PacketCmdEnd()
      return
    }
    if(self.packetIn.wDataIdx  == VSC_MODE_IDX_INVALID)
    {
      if(self.iVscModeIdxNotFoundCnt >= 20)
      {
        self.DbgPrint(String(format : "[ACT][!!!!!] ERR_VSC_FILE_MODE_IDX = %0d, there is no data in device (%d)\n",
                                        self.packetIn.wDataIdx, self.iVscModeIdxNotFoundCnt))
        self.iBleState = BLE_STATE_DISCONNECTED
        self.iVscModeIdxNotFoundCnt = 0
      }
      self.iVscModeIdxNotFoundCnt  = self.iVscModeIdxNotFoundCnt + 1
      self.bVscModeReadOn = FALSE
      // end of packer command
      self.PacketCmdEnd()
      return
    }

    self.iVscModeIdxNotFoundCnt = 0
    if(self.VscModeCtl.wId != self.packetIn.wDataIdx)
    {
      self.DbgPrint(String(format : "\t\t [BLE][WARNING] BLE_VSC_MODE_READ ID = %d\r\n", self.packetIn.wDataIdx))
      self.bVscModeReadOn = FALSE
      self.BlePacterErrorEvent()
      // end of packer command
      self.PacketCmdEnd()
      return
    }

    wId  = self.packetIn.wDataIdx;
    wLen = self.packetIn.wDataLen;
    if(self.dwVscModeType == VSC_MODE_TYPE0)
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }
    else  if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      pVscMode.VscModeType1Decode(wId, wLen, self.packetIn.bData);
    }
    else
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }

    //pVscMode.VscModeInfoPrint()
    self.QueueVscMode.sync
    {
      self.vscModeQueue.append(pVscMode)
      if(self.bVscModeAdded == TRUE)
      {
        self.DbgPrint(String(format : "%@", "[ERROR] VSC Mode ADD = TRUE, data overflow\r\n"))
      }
      else
      {
        self.bVscModeAdded = TRUE
      }
      self.VscModeCtl.wId = UInt16(Int(self.VscModeCtl.wId + 1) % VSC_MODE_IDX_MAX)
      self.VscModeCtl.iVscFileModeIndex = self.VscModeCtl.iVscFileModeIndex + 1
      self.bVscModeReadOn = FALSE
    }
    // end of packer command
    self.PacketCmdEnd()
  }

  func ActSBleVscFileModeReadEx()
  {
    var wId: UInt16 = 0
    var wLen: UInt16 = 0
    let pVscMode : VscModeCtlType = VscModeCtlType()

    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02x CMD = %02x \r\n", packetIn.bGroupId,  packetIn.bPCode))
      // end of packer command
      self.PacketCmdEnd()
      return
    }
    
    if(self.packetIn.wDataIdx  == VSC_MODE_IDX_INVALID)
    {
      if(self.iVscModeIdxNotFoundCnt >= 20)
      {
        self.DbgPrint(String(format : "[ACT][ERROR] ERR_VSC_FILE_MODE_IDX = %0d, there is no data in device (%d)\n",
                                        self.packetIn.wDataIdx, self.iVscModeIdxNotFoundCnt))
        self.iBleState = BLE_STATE_DISCONNECTED
        self.iVscModeIdxNotFoundCnt = 0
      }
      self.iVscModeIdxNotFoundCnt  = self.iVscModeIdxNotFoundCnt + 1
      self.bVscModeReadOn = FALSE
      // end of packer command
      self.PacketCmdEnd()
      return
    }

    self.iVscModeIdxNotFoundCnt = 0
    if(self.VscModeCtl.wId != self.packetIn.wDataIdx)
    {
      self.DbgPrint(String(format : "\t\t [BLE][WARNING] BLE_VSC_MODE_READ ID = %d\r\n", self.packetIn.wDataIdx))
      self.bVscModeReadOn = FALSE
      self.BlePacterErrorEvent()
      // end of packer command
      self.PacketCmdEnd()
      return
    }

    wId  = self.packetIn.wDataIdx;
    wLen = self.packetIn.wDataLen;
    if(self.dwVscModeType == VSC_MODE_TYPE0)
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }
    else  if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      pVscMode.VscModeType1Decode(wId, wLen, self.packetIn.bData);
    }
    else
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }

    //pVscMode.VscModeInfoPrint()
    self.QueueVscMode.sync
    {
      self.vscModeQueue.append(pVscMode)
      if(self.bVscModeAdded == TRUE)
      {
        self.DbgPrint(String(format : "%@", "[ERROR] VSC Mode ADD = TRUE, data overflow\r\n"))
      }
      else
      {
        self.bVscModeAdded = TRUE
      }
      self.VscModeCtl.wId = UInt16(Int(self.VscModeCtl.wId + 1) % VSC_MODE_IDX_MAX)
      self.VscModeCtl.iVscFileModeIndex = self.VscModeCtl.iVscFileModeIndex + 1
      self.bVscModeReadOn = FALSE
    }
    // end of packer command
    self.PacketCmdEnd()
  }

  func ActSBleVscModeRead()
  {
    var wId: UInt16 = 0
    var wLen: UInt16 = 0
    let pVscMode : VscModeCtlType = VscModeCtlType();
  
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02x CMD = %02x \r\n", packetIn.bGroupId,  packetIn.bPCode))
      // end of packer command
      self.PacketCmdEnd()
      return
    }
        
    if(self.packetIn.wDataIdx  == VSC_MODE_IDX_INVALID)
    {
      if(self.iVscModeIdxNotFoundCnt >= 5)
      {
        self.DbgPrint(String(format : "[ACT][ERROR] ERR_VSC_MODE_IDX = %0d, there is no data in device (%d)\n",
                                        self.packetIn.wDataIdx, self.iVscModeIdxNotFoundCnt))
      }
      
      if(self.iVscModeIdxNotFoundCnt >= 20)
      {
        self.DbgPrint(String(format : "[ACT][ERROR] ERR_VSC_MODE_IDX = %0d, there is no data in device (%d)\n",
                                        self.packetIn.wDataIdx, self.iVscModeIdxNotFoundCnt))
        self.iBleState = BLE_STATE_DISCONNECTED
        self.iVscModeIdxNotFoundCnt = 0
      }
      else
      {

      }
      self.iVscModeIdxNotFoundCnt  = self.iVscModeIdxNotFoundCnt + 1
      
      self.bVscModeReadOn = FALSE
      
      // end of packer command
      self.PacketCmdEnd()
      
      return;
    }
    
    self.iVscModeIdxNotFoundCnt = 0

    if(self.VscModeCtl.wId != self.packetIn.wDataIdx)
    {
      self.DbgPrint(String(format : "\t\t [BLE][WARNING] BLE_VSC_MODE_READ ID = %d\r\n", self.packetIn.wDataIdx))
      
      self.bVscModeReadOn = FALSE      
      self.BlePacterErrorEvent()
     
      // end of packer command
      self.PacketCmdEnd()
      
      return;
    }
        
    wId  = self.packetIn.wDataIdx;
    wLen = self.packetIn.wDataLen;
    
    if(self.dwVscModeType == VSC_MODE_TYPE0)
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }
    else  if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      pVscMode.VscModeType1Decode(wId, wLen, self.packetIn.bData);
    }
    else
    {
      pVscMode.VscModeType0Decode(wId, wLen, self.packetIn.bData);
    }
   
    //pVscMode.VscModeInfoPrint()  
    self.QueueVscMode.sync
    {
      self.vscModeQueue.append(pVscMode)
    
      if(self.bVscModeAdded == TRUE)
      {
        self.DbgPrint(String(format : "%@", "[ERROR] VSC Mode ADD = TRUE, data overflow\r\n"))
      }
      else
      {
        self.bVscModeAdded = TRUE
      }
      
      self.VscModeCtl.wId = UInt16(Int(self.VscModeCtl.wId + 1) % VSC_MODE_IDX_MAX)
      self.VscModeCtl.iVscFileModeIndex = self.VscModeCtl.iVscFileModeIndex  + 1
      
      self.bVscModeReadOn = FALSE   
    }    

    // end of packer command
    self.PacketCmdEnd()
  }
  
  func ActSBleVscModeTypeSet()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint(String(format : "[ACT][ERROR] GROUP = %02X CMD = %02X \r\n", packetIn.bGroupId,  packetIn.bPCode))
      return
    }
    // end of packer command
    self.PacketCmdEnd()
    
    // Go to next strp
    self.iVscModeInitStep = VSC_MODE_INIT_STEP2
  }
    
  func ActSBleSRegRead()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      self.DbgPrint("[ACT][ERROR] SREG READ NACK\r\n")
      return
    }
    
    if(self.SReg.bCmdOn  == FALSE)
    {
      self.PacketCmdEnd()
      return
    }
    
    //------------------------------------------------------------------------------------------------//
    // SReg Data Copy
    //------------------------------------------------------------------------------------------------//
    for i in 0..<self.SReg.bData.count
    {
      if(i < packetIn.bData.count)
      {
        self.SReg.bData[i] =  packetIn.bData[i]
      }
      else
      {
        self.SReg.bData[i] = 0
      }
    }
    
    //------------------------------------------------------------------------------------------------//
    // SReg Read Action
    //------------------------------------------------------------------------------------------------//
    self.SReg.SRegAction()

  
    self.PacketCmdEnd()
   /// get the SREG ack
   if(self.iBleState == BLE_STATE_CONNECT_INIT)
   {
     if(self.iBleInitStep == BLE_INIT_STEP4)
     {
       self.iBleInitStep = BLE_INIT_STEP5;
     }
     else if(self.iBleInitStep == BLE_INIT_STEP5)
     {
       self.iBleInitStep = BLE_INIT_STEP6;
     }
     else if(self.iBleInitStep == BLE_INIT_STEP6)
     {
       self.iBleInitStep = BLE_INIT_STEP7;
     }
   }
  }
  
  func ActSBleSRegWrite()
  {
    if(self.packetIn.bAck != UInt8(CMD_ACK))
    {
      if(self.SReg.bAckFailDisConnect == TRUE)
      {
        self.DbgPrint("[ACT][ERROR] SREG WRITE NACK\r\n")
        return;
      }
    }
    
    self.SReg.bAck = self.packetIn.bAck ;
    //------------------------------------------------------------------------------------------------//
    // SReg Read Action
    //------------------------------------------------------------------------------------------------//
    self.SReg.SRegAction()
    
    self.PacketCmdEnd()
     /// get the ack
    if(self.iBleState == BLE_STATE_CONNECT_INIT)
    {
      if(self.iBleInitStep == BLE_INIT_STEP3)
      {
        self.iBleInitStep = BLE_INIT_STEP4;
      }
    }
  }
    
  func CmdSBleSysVersionGet()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SYS)
    pPacketOut.bCmd     = UInt8(CMD_SYS_VER_GET)
    pPacketOut.bPCode   = UInt8(CMD_SYS_VER_GET)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 32
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
        
    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleSysMeasInfo()
  {
    let pPacketOut : PacketCmd = PacketCmd()

    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SYS)
    pPacketOut.bCmd     = UInt8(CMD_SYS_MEAS_INFO_GET)
    pPacketOut.bPCode   = UInt8(CMD_SYS_MEAS_INFO_GET)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 42

    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)

    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleDevBlePairCheckGet()
  {
    _ = self.FuncSRegRead(SREG_BLE_PAIR_CHECK)
  }

  func CmdSBleDevPinCodeEnableGet()
  {   
    self.SReg.bAckFailDisConnect = TRUE;
    _ = self.FuncSRegRead(SREG_SYSTEM_PIN_ENABLE)
  }

  func CmdSBleDevAlarmStsGet()
  {
    self.SReg.bAckFailDisConnect = TRUE;
    _ = self.FuncSRegRead(SREG_DEVICE_CHIP_STATUS)
  }

  func CmdSBleSysTimeSet()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    let jtm   : JTM = JTM()
    let tNow  : UInt32  = UInt32(Date().timeIntervalSince1970)
    var wYear : UInt16 = 0
    var bDataArr : [UInt8] = [UInt8]()
    
    var iVal : Int32 = 0
    
    jtm.JTMLocalTimeGet(tNow: tNow)
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SYS)
    pPacketOut.bCmd     = UInt8(CMD_SYS_TIME_SET)
    pPacketOut.bPCode   = UInt8(CMD_SYS_TIME_SET)
    pPacketOut.wMOSILen = 32
    pPacketOut.wMISOLen = 32
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
        
    
    wYear = UInt16(jtm.iYear)
    bDataArr =  withUnsafeBytes(of: &wYear){Array($0)}
    
    // Year
    pPacketOut.bData[16] = bDataArr[0]
    pPacketOut.bData[17] = bDataArr[1]
    // month
    pPacketOut.bData[18] = UInt8(jtm.iMonth)
    // day
    pPacketOut.bData[19] = UInt8(jtm.iDay)
    // hour
    pPacketOut.bData[20] = UInt8(jtm.iHour)
    
    // minute
    pPacketOut.bData[21] = UInt8(jtm.iMin)
    
    // sec
    pPacketOut.bData[22] = UInt8(jtm.iSec)
    
    // t
    iVal = Int32(jtm.t)
    bDataArr =  withUnsafeBytes(of: &iVal){Array($0)}
    pPacketOut.bData[24] = bDataArr[0]
    pPacketOut.bData[25] = bDataArr[1]
    pPacketOut.bData[26] = bDataArr[2]
    pPacketOut.bData[27] = bDataArr[3]
    
    // time_zone
    iVal = 8 * 3600
    bDataArr =  withUnsafeBytes(of: &iVal){Array($0)}
    pPacketOut.bData[28] = bDataArr[0]
    pPacketOut.bData[29] = bDataArr[1]
    pPacketOut.bData[30] = bDataArr[2]
    pPacketOut.bData[31] = bDataArr[3]
    

    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleSysSsnGet()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SYS)
    pPacketOut.bCmd     = UInt8(CMD_SYS_SSN_GET)
    pPacketOut.bPCode   = UInt8(CMD_SYS_SSN_GET)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 32
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    
    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleVscModeStart()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_MODE_START)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_MODE_START)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 0
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
        
    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleVscModeStop()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_MODE_STOP)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_MODE_STOP)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 0
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
        
    self.PacketCmdIssue(pPacketOut)
  }
   
  func CmdSBleVscModeRead()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    let bDataArr = withUnsafeBytes(of: self.dwVscModeType, Array.init)
    var wDataLen : UInt16 = 968
    
    if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      wDataLen = 568
    }
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_MODE_READ)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_MODE_READ)
    pPacketOut.wMOSILen = 8
    pPacketOut.wMISOLen = wDataLen
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    
    // set ID
    pPacketOut.bData[0] = UInt8(self.VscModeCtl.wId % 256);
    pPacketOut.bData[1] = UInt8(self.VscModeCtl.wId / 256);
    
    // set TYPE
    for i in 0..<4
    {
      pPacketOut.bData[4 + i] = bDataArr[i]
    }
        
    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleVscModeTypeSet()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_MODE_TYPE_SET)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_MODE_TYPE_SET)
    pPacketOut.wMOSILen = 20
    pPacketOut.wMISOLen = 0
    
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen) + PACKET_CMD_HEADER_SIZE)
    
    let dwVscModeType : UInt32 = self.dwVscModeType
    let bDataArr = withUnsafeBytes(of: dwVscModeType, Array.init)
    
    for i in 0..<4
    {
      pPacketOut.bData[16 + i] = bDataArr[i]
    }
        
    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleSRegRead(_ SReg: SRegType)
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SREG)
    pPacketOut.bCmd     = UInt8(CMD_SREG_READ)
    pPacketOut.bPCode   = UInt8(CMD_SREG_READ)
    pPacketOut.wMOSILen = UInt16(SREG_NAME_SIZE)
    pPacketOut.wMISOLen = UInt16(SREG_DATA_SIZE)
        
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
       
    // SReg Name Set
    for i in 0..<SReg.bNameData.count
    {
      pPacketOut.bData[i] = SReg.bNameData[i]
    }
        
    self.PacketCmdIssue(pPacketOut)
  }
  
  func CmdSBleSRegWrite(_ SReg: SRegType)
  {
    let pPacketOut : PacketCmd = PacketCmd()
    
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_SREG)
    pPacketOut.bCmd     = UInt8(CMD_SREG_WRITE)
    pPacketOut.bPCode   = UInt8(CMD_SREG_WRITE)
    pPacketOut.wMOSILen = UInt16(SREG_NAME_SIZE + SREG_DATA_SIZE)
    pPacketOut.wMISOLen = 0

    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    
    // SReg Name Set
    for i in 0..<SReg.bNameData.count
    {
      pPacketOut.bData[i] = SReg.bNameData[i]
    }
    
    // SReg Data Set
    for i in 0..<SReg.bData.count
    {
      pPacketOut.bData[i + SREG_NAME_SIZE] = SReg.bData[i]
    }
        
    self.PacketCmdIssue(pPacketOut)
  }      
  
  func CmdSBleVscFileModeStart()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    // check the config setting
    var iMeasurementPeriodSecNow : Int = self.jud.IntGet(JUD_KEY_MEASUREMENT_PERIOD)
    // add the seg  time maybe need modify it
    if(iMeasurementPeriodSecNow != 0)
    {
      iMeasurementPeriodSecNow = iMeasurementPeriodSecNow + 6
    }
		
    let bDataArr = withUnsafeBytes(of: iMeasurementPeriodSecNow, Array.init)
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_FILE_MODE_START)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_FILE_MODE_START)
    pPacketOut.wMOSILen = 4
    pPacketOut.wMISOLen = 4
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    /// setting the Measurement time
    for i in 0..<4
    {
      pPacketOut.bData[0 + i] = bDataArr[i]
    }
    self.PacketCmdIssue(pPacketOut)
  }
  func CmdSBleVscFileModeStop()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_FILE_MODE_STOP)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_FILE_MODE_STOP)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 0
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
      
    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleFileListClearAll()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_JFILE)
    pPacketOut.bCmd     = UInt8(CMD_FILE_LIST_CLEAR)
    pPacketOut.bPCode   = UInt8(CMD_FILE_LIST_CLEAR)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 0
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleVscFileModeInfoStatus()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_FILE_INFO_STS)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_FILE_INFO_STS)
    pPacketOut.wMOSILen = 0
    pPacketOut.wMISOLen = 30
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleVscFileModeReadEx()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    // let bDataArr = withUnsafeBytes(of: self.dwVscModeType, Array.init)
    var wDataLen : UInt16 = 968
    var bDataArr : [UInt8] = [UInt8]()
    var dwVal    : UInt32 = 0
    var iMsec    : UInt16 = 0

    if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      wDataLen = 568
    }

    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_FILE_MODE_READ_EX)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_FILE_MODE_READ_EX)
    pPacketOut.wMOSILen = 8
    pPacketOut.wMISOLen = wDataLen
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)

    /// input the fetch time
    dwVal = UInt32(self.iVscModeStartUtc + (Int64(self.VscModeCtl.iVscFileModeIndex)/5));
    bDataArr =  withUnsafeBytes(of: &dwVal){Array($0)}
    pPacketOut.bData[0] = bDataArr[0]
    pPacketOut.bData[1] = bDataArr[1]
    pPacketOut.bData[2] = bDataArr[2]
    pPacketOut.bData[3] = bDataArr[3]

    /// fetch mSec data
    iMsec = UInt16(Int(self.VscModeCtl.iVscFileModeIndex % 5) * 200)
    bDataArr =  withUnsafeBytes(of: &iMsec){Array($0)}
    pPacketOut.bData[4] = bDataArr[0]
    pPacketOut.bData[5] = bDataArr[1] 

    self.PacketCmdIssue(pPacketOut)
  }

  func CmdSBleVscFileModeRead()
  {
    let pPacketOut : PacketCmd = PacketCmd()
    // let bDataArr = withUnsafeBytes(of: self.dwVscModeType, Array.init)
    var wDataLen : UInt16 = 968
    var bDataArr : [UInt8] = [UInt8]()
    var dwVal     : UInt32 = 0

    if(self.dwVscModeType == VSC_MODE_TYPE1)
    {
      wDataLen = 568
    }
    //self.DbgPrint(String(format:"[CmdSBleVscFileModeRead] UTC:%d, CNT:%d, IDX:%d\r\n",self.iVscModeStartUtc, self.VscModeCtl.iVscFileModeIndex, self.VscModeCtl.wId ));
    pPacketOut.bGroupId = UInt8(CMD_GROUP_ID_BLE)
    pPacketOut.bCmd     = UInt8(CMD_BLE_VSC_FILE_MODE_READ)
    pPacketOut.bPCode   = UInt8(CMD_BLE_VSC_FILE_MODE_READ)
    pPacketOut.wMOSILen = 8
    pPacketOut.wMISOLen = wDataLen
    pPacketOut.bData = Array(repeating: 0, count: Int(pPacketOut.wMOSILen)  +  PACKET_CMD_HEADER_SIZE)
    /// input the fetch time
    dwVal = UInt32(self.iVscModeStartUtc + (Int64(self.VscModeCtl.iVscFileModeIndex)/5));
    bDataArr =  withUnsafeBytes(of: &dwVal){Array($0)}
    pPacketOut.bData[0] = bDataArr[0]
    pPacketOut.bData[1] = bDataArr[1]
    pPacketOut.bData[2] = bDataArr[2]
    pPacketOut.bData[3] = bDataArr[3]
    // set ID
    pPacketOut.bData[4] = UInt8(self.VscModeCtl.wId % 256);
    pPacketOut.bData[5] = UInt8(self.VscModeCtl.wId / 256);
    self.PacketCmdIssue(pPacketOut)
  }

  func PacketCmdEnd()
  {
    self.bPacketCmdOn = FALSE
    self.iBleReSendCnt = 0
    //self.DbgPrint("[CMD] Command End\r\n");
  }
  
  func PacketCmdSend()
  {
    let pPacketCmd : PacketCmd = self.packetCmdArr.removeFirst()
    
    var bDataArr = pPacketCmd.packetConvertToByteArray()
    //self.DataPrint(bDataArr)
    
    pPacketCmd.utc = Date().timeIntervalSince1970
    
    //self.DbgPrint(String("[CMD] Command Send\r\n"))
    
    self.packetOut.Copy(pPacketCmd)
       
    self.bPacketReadDataArr.removeAll()
    
    self.BleTxWrite(bDataArr)
    
    bDataArr.removeAll()
  }
  
  func PacketCmdIssue(_ pPacketOut: PacketCmd)
  {
    self.packetCmdArr.append(pPacketOut)
  }

  func PacketCmdDispatch()
  {
    // SYS
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SYS) && (self.packetIn.bPCode == CMD_SYS_VER_GET))
    {
      self.ActSBleSysVersionGet()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SYS) && (self.packetIn.bPCode == CMD_SYS_TIME_SET))
    {
      self.ActSBleSysTimeSet()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SYS) && (self.packetIn.bPCode == CMD_SYS_SSN_GET))
    {
      self.ActSBleSysSsnGet()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SYS) && (self.packetIn.bPCode == CMD_SYS_MEAS_INFO_GET))
    {
      self.ActSBleMeasInfoGet()
    }
    // VSC_FILE_MODE
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_FILE_MODE_START))
    {
      ActSBleVscFileModeStart()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_FILE_MODE_STOP))
    {
      ActSBleVscFileModeStop()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_FILE_MODE_READ))
    {
      ActSBleVscFileModeRead()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_FILE_MODE_READ_EX))
    {
      ActSBleVscFileModeReadEx()
    }

    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_FILE_INFO_STS))
    {
      ActSBleVscFileModeInfoStatus()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_JFILE) && (self.packetIn.bPCode == CMD_FILE_LIST_CLEAR))
    {
      ActSBleVscFileListClearAll()
    }
    
    // VSC_MODE
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_MODE_START))
    {
      self.ActSBleVscModeStart()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_MODE_STOP))
    {
      self.ActSBleVscModeStop()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_MODE_READ))
    {
      self.ActSBleVscModeRead()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_BLE) && (self.packetIn.bPCode == CMD_BLE_VSC_MODE_TYPE_SET))
    {
      self.ActSBleVscModeTypeSet()
    }
    
    // SREG
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SREG) && (self.packetIn.bPCode == CMD_SREG_READ))
    {
      self.ActSBleSRegRead()
    }
    if((self.packetIn.bGroupId == CMD_GROUP_ID_SREG) && (self.packetIn.bPCode == CMD_SREG_WRITE))
    {
      self.ActSBleSRegWrite()
    }
  }
  
  func PacketReadHandler(_ bRawData : [UInt8])
  {
    var wDataLen   : UInt16   = 0
    var wPacketLen : UInt16   = 0
    let wHeaderLen : UInt16   = 8
    
    for i in 0..<bRawData.count
    {
      let bData : UInt8 = bRawData[i]
      self.bPacketReadDataArr.append(bData)
    }
    
    wPacketLen = UInt16(self.bPacketReadDataArr.count)
    if(wPacketLen < 8)
    {
      self.BlePacterErrorEvent()
      
      return;
    }
    
    wDataLen = (UInt16(self.bPacketReadDataArr[6]) + UInt16(self.bPacketReadDataArr[7]) * 0x100)
    
    if(wPacketLen == (wDataLen + wHeaderLen))
    {
      //self.DataPrint(self.bPacketReadDataArr);
      self.packetIn = PacketAck()
      
      self.packetIn.packetDecode(self.bPacketReadDataArr)
      self.PacketCmdDispatch()
    }
  }
}
