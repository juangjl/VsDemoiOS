//--------------------------------------------------------------------------------//
// @file  Task.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func ThreadTaskLoop() async
  {
    var t0 : Int64 = 0
    var t1 : Int64 = Date().millisecondsSince1970
    while(TRUE)
    {
      t1 = Date().millisecondsSince1970
      if((t1 - t0) > 20)
      {
        self.TaskLoop()
        t1 = Date().millisecondsSince1970
        t0 = t1
      }
      do
      {        
        try await self.FuncTaskSleep()
      }
      catch
      {
        
      }     
    }
  }

  func FuncTaskSleep() async throws
  {
    try await Task.sleep(nanoseconds: 5000000)
  }
   
  func FuncTaskLoopStart()
  {
    self.iLoopT0 = Date().millisecondsSince1970
  }
  
  func FuncTaskLoopEnd()
  {
    self.iLoopT1 = Date().millisecondsSince1970
    
    self.iLoopMS = self.iLoopT1 - self.iLoopT0
    self.iLoopCoount = self.iLoopCoount + 1
    
    self.iLoopMSSum = self.iLoopMSSum + self.iLoopMS
    self.fLoopMSAvg = Float64(self.iLoopMSSum) / Float64(iLoopCoount)
    
    if(self.iLoopMSMax < self.iLoopMS)
    {
      self.iLoopMSMax = self.iLoopMS    
    }
  }

  //------------------------------------------------------------------------------------------------//
  // Task Routines
  //------------------------------------------------------------------------------------------------//
  func TaskRoundInit()
  {
    self.FuncTaskLoopStart()
    
    self.iTimeTick = Date().millisecondsSince1970
    //self.DbgPrint(String(format : "%ld\n", iTimeTick))
    if((self.iTimeTick  - self.iTimeTickPre) < 10)
    {
      return
    }
    self.iTimeTickPre = self.iTimeTick
    self.iTimeMS    = Int(iTimeTick % 1000)
    self.iTime10MS  = Int((self.iTimeMS - self.iTimeMS % 10) % 100)
    self.iTime100MS = Int(self.iTimeMS - self.iTimeMS % 100)
    
    if(self.iTime10MS == self.iTime10MSPre)
    {
      return
    }
    self.iTime10MSPre = self.iTime10MS
    
    if(self.iTime10MS % 50 == 0)
    {
      self.iTime50MS = self.iTime10MS
    }
    
    if(self.iTime50MS  != self.iTime50MSPre)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_50MS_EVT;
      self.iTime50MSPre = self.iTime50MS
    }
    
    self.iTime10MSPre = self.iTime10MS
    
    self.dwSysCtl2 |= SYS_CTL2_TASK_EVT
    
    if(self.iTime100MS == self.iTime100MSPre)
    {
      return
    }
    self.iTime100MSPre = self.iTime100MS

    self.dwSysCtl2 |= SYS_CTL2_TIMER_100MS_EVT;
    //self.DbgPrint(String(format : "%ld\n", iTimeTick))
    /*
    self.DbgPrint(String(format : "MS= %03d,  10MS = %02d, 50 = %03d 100MS = %03d VIEW_ID = %d\n",
                                self.iTimeMS,
                                self.iTime10MS,
                                self.iTime50MS,
                                self.iTime100MS, self.iViewId))
     */
    if(self.iTime100MS == 0)
    {
      self.dwSysCtl2 |= SYS_CTL2_SEC_EVT;
      self.dwSysCtl2 |= SYS_CTL2_TIMER_200MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_000MS_EVT;
    }
    if(self.iTime100MS == 100)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_100MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_100MS_EVT;
    }
    if(self.iTime100MS == 200)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_200MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_200MS_EVT;
    }
    if(self.iTime100MS == 300)
    {
      self.dwSysCtl2 |= SYS_CTL2_300MS_EVT;
    }
    if(self.iTime100MS == 400)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_200MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_400MS_EVT;
    }
    if(self.iTime100MS == 500)
    {
      self.dwSysCtl2 |= SYS_CTL2_500MS_EVT;
    }
    if(self.iTime100MS == 600)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_200MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_600MS_EVT;
    }
    if(self.iTime100MS == 700)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_100MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_700MS_EVT;
    }
    if(self.iTime100MS == 800)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_200MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_800MS_EVT;
    }
    if(self.iTime100MS == 900)
    {
      self.dwSysCtl2 |= SYS_CTL2_TIMER_100MS_EVT;
      self.dwSysCtl2 |= SYS_CTL2_900MS_EVT;
    }
  }  
  
  func TaskTime()
  {
    if((self.dwSysCtl2 & SYS_CTL2_SEC_EVT) == 0)
    {
      return;
    }
    self.iTimeSec = self.iTimeSec + 1;
  }
      
  func TaskBleScan()
  {    
    var idx = 0;
        
    if((self.dwSysCtl2 & SYS_CTL2_TASK_EVT) == 0)
    {
      return
    }
    
    if((self.dwSysCtl2 & SYS_CTL2_SEC_EVT) == 0)
    {
      return;
    }
    
    if(self.bBleScanStart == FALSE)
    {
      return;
    }
    
    for vsp in vsPeripheralArr
    {
      vsp.iSec = vsp.iSec + 1;
      if(vsp.iSec > 20)
      {
        vsPeripheralArr.remove(at: idx);
        continue
      }
      idx = idx + 1;      
    }        
  }
  
  func TaskBleCmd()
  {
    let tNow = Date().timeIntervalSince1970
    
    if((self.dwSysCtl2 & SYS_CTL2_TASK_EVT) == 0)
    {
      return
    }
    
    if(self.bBleConnected == FALSE)
    {
      self.packetCmdArr.removeAll()
      self.bPacketCmdOn = FALSE
      return;
    }
    
    if(self.bPacketCmdOn == FALSE)
    {
      if(self.packetCmdArr.count > 0)
      {
        self.PacketCmdSend()
        self.bPacketCmdOn = TRUE
        self.iBleWaitT0 = self.iLoopT0
      }
    }
    else
    {
      /// resend command
      self.iBleWaitT1 = self.iLoopT0
      if((self.iBleWaitT1 - self.iBleWaitT0) > 500)
      {
        self.iBleReSendCnt = self.iBleReSendCnt + 1
        // resend data
        if(self.iBleReSendCnt < 3)
        {
          self.bPacketCmdOn = FALSE
        }
      }

      if((tNow - self.packetOut.utc) > 1)
      {
        self.DbgPrint(String(format : "[CMD][ERROR] Command time out self.bPacketCmdOn:%d, stage:%d, step:%d\n", self.bPacketCmdOn, self.iBleState, self.iBleInitStep))

        self.bPacketCmdOn = FALSE
        
        self.iBleState = BLE_STATE_DISCONNECTED
      }
    }
  }
  
  func TaskBleSReg()
  {
    var iUTcMS : Int64 = 0
    
    if((self.dwSysCtl2 & SYS_CTL2_TASK_EVT) == 0)
    {
      return
    }
    
    if(self.SReg.iCmdState == SREG_CMD_STATE_IDLE)
    {
      return
    }
    else if(self.SReg.iCmdState == SREG_CMD_STATE_ISSUE)
    {
      self.FuncSRegSend()
      self.SReg.iCmdState = SREG_CMD_STATE_BUSY
    }
    else if(self.SReg.iCmdState == SREG_CMD_STATE_BUSY)
    {
      iUTcMS = Date().millisecondsSince1970
      if((iUTcMS - self.SReg.iCmdUtcMS) > SREG_TIMEOUT)
      {
        self.SReg.Timeout()
        self.BleDisconnect()
        self.iViewId = VIEW_ID_SCAN
      }
      self.SReg.iCmdState = SREG_CMD_STATE_IDLE
    }
    else if(self.SReg.iCmdState == SREG_CMD_STATE_DONE)
    {
      iUTcMS = Date().millisecondsSince1970
      if((iUTcMS - self.SReg.iCmdUtcMS) > SREG_TIMEOUT)
      {
        self.SReg.iCmdState = SREG_CMD_STATE_IDLE
      }
    }
  }
  
  func TaskBleState()
  {   
    if(self.iBleState == BLE_STATE_CLOSE)
    {
      self.iBleInitStep = BLE_INIT_STEP0
      return;
    }
    else if(self.iBleState == BLE_STATE_CONNECT_INIT)
    {
      if(self.iBleInitStep == BLE_INIT_STEP_FINISH)      
      {
        self.iBleInitStep = BLE_INIT_STEP0
        self.iBleState    = BLE_STATE_CONNECTED
      }
      
      if((self.dwSysCtl2 & SYS_CTL2_TIMER_100MS_EVT) != 0)
      {
        return
      }
      if(self.bBleConnected == FALSE)
      {
        return
      }
      if(self.bPacketCmdOn == TRUE)
      {
        return
      }
      // set time
      if(self.iBleInitStep == BLE_INIT_STEP0)
      {
        vsPeripheralArr.removeAll()
        self.CmdSBleSysTimeSet()
      }
      // get the SSN
      else if(self.iBleInitStep == BLE_INIT_STEP1)
      {
        self.CmdSBleSysSsnGet()
      }
      // get the version
      else if(self.iBleInitStep == BLE_INIT_STEP2)
      {
        self.CmdSBleSysVersionGet()
      }
      // ge the vsc file mode info
      else if(self.iBleInitStep == BLE_INIT_STEP3)
      {
        /// get the vsc file mode information status
        self.CmdSBleVscFileModeInfoStatus()
      }
      // get the device alarm status
      else if(self.iBleInitStep == BLE_INIT_STEP4)
      {
        if(self.iDeviceVersion >= 232)
        {
          self.CmdSBleDevAlarmStsGet()
        }
        else
        {
          self.iBleInitStep = BLE_INIT_STEP5;
        }
      }
      // get the pin code
      else if(self.iBleInitStep == BLE_INIT_STEP5)
      {
        self.CmdSBleDevPinCodeEnableGet()

        // check the default the PEC is enable
        let strItemEnable : String = self.FuncJudRead(JUD_KEY_PACKET_ERROR_RATE_ON)
        let strItemStart  : String = self.FuncJudRead(JUD_VAL_PACKET_ERROR_RATE_START)
        if((strItemStart == "ON") && (strItemEnable == "ON"))
        {
          if(self.bBlePERStart == FALSE)
          {
            BlePacketErrorRateStart()
          }
        }
      }
      // get the pin code
      else if(self.iBleInitStep == BLE_INIT_STEP6)
      {
        if((self.iDeviceVersion >= 260) && (self.SReg.bDevPinCodeEnable == TRUE))
        {
          self.CmdSBleDevBlePairCheckGet()
        }
        else
        {
          self.iBleInitStep = BLE_INIT_STEP_FINISH;
        }
      }
      else if(self.iBleInitStep == BLE_INIT_STEP7)
      {
        // check pin code is finish
        if(self.SReg.strSRegDeviceBlePairCheck == "ON")
        {
          self.iBleInitStep = BLE_INIT_STEP_FINISH;
        }
        else
        {
          self.iBleInitStep = BLE_INIT_STEP6;
        }
      }
    }
    else if(self.iBleState == BLE_STATE_CONNECTED)
    {
      if((self.dwSysCtl2 & SYS_CTL2_SEC_EVT) != 0)
      {       
        self.QueueVscMode.sync 
        {
          self.vscModeQueue.removeAll()
        }
        /// check the file  mode is used the initial running
        if(self.VscModeCtl.iVscFileEnableStatus == 1)
        {
          /// check the bAutoConnect is init
          self.FuncVscModeInit()
        }
        else
        {
          self.CmdSBleSysMeasInfo()
          self.FuncAutoConnectOn()
        }
      }
    }
    else if(self.iBleState == BLE_STATE_RECONNECT)
    {
      self.BleConnect(self.vsPeripheralConnected);
      self.iBleInitStep = BLE_INIT_STEP0
      self.iBleState = BLE_STATE_CONNECT_INIT
      print("BLE_STATE_RECONNECT\r\n")
    }
    else if(self.iBleState == BLE_STATE_DISCONNECTED)
    {
      self.BleDisconnect()
      self.packetCmdArr.removeAll()
      self.bPacketCmdOn = FALSE
      self.vsPeripheralArr.removeAll()
      
      if(self.bAutoConnectStatus == TRUE)
      {
        self.iAutoConnectState =  AUTO_CONNECT_STATE_INIT
        self.iBleState = BLE_STATE_AUTO_CONNECT
      }
      else
      {
        self.iBleState = BLE_STATE_CLOSE
      }
    }
    else if(self.iBleState == BLE_STATE_AUTO_CONNECT)
    {
      if(self.iAutoConnectState ==  AUTO_CONNECT_STATE_INIT)
      {
        if(self.iViewId != VIEW_ID_AUTO_CONNECTING)
        {
          self.iViewId = VIEW_ID_AUTO_CONNECTING
        }
        BleScanStop()
        self.vsPeripheralArr.removeAll()
        BleScanStart()
        self.iAutoConnectState = AUTO_CONNECT_STATE_SCAN
      }
      else if(self.iAutoConnectState ==  AUTO_CONNECT_STATE_SCAN)
      {
        for i in 0..<vsPeripheralArr.count
        {
          let vsPeripheral = vsPeripheralArr[i]
          if(vsPeripheral.strDeviceName == self.strAutoConnectName)
          {
            //----------------------------------------------------------------//
            // Set for UI to execute the auto start
            //----------------------------------------------------------------//
            if(self.bAutoMeasurementStatus == TRUE)
            {
              self.FuncAutoMeasurementSet()
            }
            else
            {
              self.FuncAutoMeasurementClear()
            }
            
            self.iAutoConnectT0 = Date().timeIntervalSince1970
            self.iAutoConnectT1 = Date().timeIntervalSince1970
            
            //----------------------------------------------------------------//
            // stop before connect
            //----------------------------------------------------------------//
            BleScanStop()
            self.BleConnect(vsPeripheral)
            self.iAutoConnectState = AUTO_CONNECT_STATE_CONNECT
          }
        }        
      }
      else if(self.iAutoConnectState == AUTO_CONNECT_STATE_CONNECT)
      {
        if(self.iBleState == BLE_STATE_CONNECTED)
        {
          self.iViewId = VIEW_ID_MEASUREMENT
        }
        else
        {
          self.iAutoConnectT1 = Date().timeIntervalSince1970
          if(Int(self.iAutoConnectT1 - self.iAutoConnectT0) > 20)
          {
            self.iAutoConnectState =  AUTO_CONNECT_STATE_INIT
          }
        }
      }
    }
    else if(self.iBleState == BLE_STATE_VSC_MODE_INIT)
    {
      if(self.iVscModeInitStep == VSC_MODE_INIT_STEP0)
      {
        // DO VSC_MODE_TYPE_SET
        self.FuncVscModeTypeSet()
        self.iVscModeInitStep = VSC_MODE_INIT_STEP1
        self.iVscModeWaitT0 = self.iLoopT0
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP1)
      {
        // WAIT VSC_MODE_TYPE_SET DONE
        self.iVscModeWaitT1 = self.iLoopT0
        if((self.iVscModeWaitT1 - self.iVscModeWaitT0) > 1000)
        {
          self.iBleState = BLE_STATE_CLOSE
        }
        let strEnabled : String = self.FuncJudRead(JUD_KEY_VSC_FILE_MODE)
        if(strEnabled == "OFF")
        {
          self.bVscFileModeEnable = FALSE
        }
        else
        {
          self.bVscFileModeEnable = TRUE
        }
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP2)
      {        
        // VSC_MODE_TYPE_SET DONE, DO VSC_MODE_START
        if(self.bVscFileModeEnable == TRUE)
        {
          self.FuncVscFileModeStart()
        }
        else
        {
          self.FuncVscModeStart()
          self.iVscModeInitStep = VSC_MODE_INIT_STEP3
        }
        self.iVscModeWaitT0 = self.iLoopT0
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP3)
      {
        self.iVscModeWaitT1 = self.iLoopT0
        if((self.iVscModeWaitT1 - self.iVscModeWaitT0) > 1000)
        {
          self.iBleState = BLE_STATE_CLOSE
        }
        // WAIT_VSC_START_DONE
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP4)
      {
        self.bVscModeReadOn = FALSE;
        self.fVscModeSec   = 0;
        /// reconnect VSH101 flow
        if(self.VscModeCtl.iVscFileEnableStatus == 1)
        {        
          self.VscModeCtl.iVscFileModeStartFlag = 1
          let wId = self.VscModeCtl.wId;
          self.VscModeCtl.VscModeInit()
          self.VscModeCtl.wId = wId;
        }
        else
        {
          // Init VSC_MODE
          self.VscModeCtl.VscModeInit()
        }
        self.iVscModeInitStep = VSC_MODE_INIT_STEP0
        self.iBleState = BLE_STATE_VSC_MODE        
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP5)
      {
        // DO VSC_MODE_STOP
        if(self.bVscFileModeEnable == TRUE)
        {
          self.FuncVscFileModeStop()
        }
        else
        {
        self.FuncVscModeStop()
        }
        self.iVscModeInitStep = VSC_MODE_INIT_STEP6
        self.iVscModeWaitT0 = self.iLoopT0
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP6)
      {
        // WAIT_VSC_STOP_DONE
        self.iVscModeWaitT1 = self.iLoopT0
        if((self.iVscModeWaitT1 - self.iVscModeWaitT0) > 1000)
        {
          self.iBleState = BLE_STATE_CLOSE
        }
      }
      else if(self.iVscModeInitStep == VSC_MODE_INIT_STEP7)
      {
        // VSC_MODE_STOP_DONE goto STEP0
        self.iVscModeInitStep = VSC_MODE_INIT_STEP0
      }
    }
    else if(self.iBleState == BLE_STATE_VSC_MODE)
    {
      /// add check view
      if(self.bVscModeReadOn == FALSE)
      {        
        if(self.bVscFileModeEnable == TRUE)
        {
          self.FuncVscFileModeRead()
        }
        else
        {
          self.FuncVscModeRead()
        }
        
        //----------------------------------------------------------------//
        // Packet send time set
        //----------------------------------------------------------------//
        // t1 of the packet
        let dateNow : Date = Date()
        self.tPacketT0MS =  Int64(dateNow.timeIntervalSince1970 * 1000)
      }
      else
      {
        //----------------------------------------------------------------//
        // Packet Timeout -cHECK
        //----------------------------------------------------------------//
        // t1 of the packet
        let dateNow : Date = Date()
        let tPacketT1MS : Int64  =  Int64(dateNow.timeIntervalSince1970 * 1000)
        if((tPacketT1MS - self.tPacketT0MS) > 500)
        {
          self.BlePacterErrorEvent()
          self.bVscModeReadOn = FALSE
          self.PacketCmdEnd()
        }        
      }
      
      if(self.bVscModeAdded == TRUE)
      {
        self.FuncVscModeProcess()
        self.bVscModeAdded  = FALSE
      }
    }
    else if(self.iBleState == BLE_STATE_VSC_MODE_QUEUE_FULL)
    {
      self.iBleState = BLE_STATE_VSC_MODE_INIT
    }
    else if(self.iBleState == BLE_STATE_VSC_MODE_END)
    {
      if(self.bVscFileModeEnable == TRUE)
      {
        self.FuncVscFileModeStop()
      }
      else
      {
        self.FuncVscModeStop()
      }
      self.iVscModeInitStep = VSC_MODE_INIT_STEP0
      self.iBleState        = BLE_STATE_CONNECTED
    }
  }

  func TaskBleChart()
  {
    if((self.dwSysCtl2 & SYS_CTL2_TIMER_100MS_EVT) == 0)
    {
      return
    }
    
    if(self.bChartBleDataUpdate == FALSE)
    {
      return
    }
    
    var iChartTimeStart : Int64 = 0
    var iChartTimeEnd   : Int64 = 0
    
    
    if((self.iVscModeMSEnd - self.iVscModeMSStart) < 6000)
    {
      iChartTimeStart = self.iVscModeMSStart
      iChartTimeEnd   = self.iVscModeMSStart + 6000
    }
    else
    {
      iChartTimeStart = self.iVscModeMSEnd - 6000
      iChartTimeEnd   = self.iVscModeMSEnd
    }
    // find atr
    self.atrArrChartBle = [JAtrType]()
    self.atrArrChartBle = self.FuncVscModeAtrFind(iChartTimeStart, iChartTimeEnd)

    if(self.chartBleEcg0.bLineUpdate == FALSE)
    {    
      // set atr label
      self.FuncVscModeAtrLabelSet(self.atrArrChartBle)
            
      let fEcgMVFixed = self.FuncEcgDisplayAmpGet()
      self.chartBleEcg0.fEcgMVFixed = fEcgMVFixed
      self.chartBleEcg1.fEcgMVFixed = fEcgMVFixed

      self.chartBleEcg0.xLabelArr = [JLabel]()
      self.chartBleEcg1.xLabelArr = [JLabel]()

      self.chartBleEcg0.LineDraw(pDataSet: self.pDataSet[DATASET_MONITOR_ECG_DS0])
      self.chartBleEcg1.LineDraw(pDataSet: self.pDataSet[DATASET_MONITOR_ECG_DS1])
      
      // set axis label
      self.chartBleEcg0.LabelXDraw(iChartTimeStart, iChartTimeEnd)
      self.chartBleEcg0.LabelYDraw()
      self.chartBleEcg1.LabelXDraw(iChartTimeStart, iChartTimeEnd)
      self.chartBleEcg1.LabelYDraw()
      
      self.chartBleEcg0.bLineUpdate = TRUE
    }
    
    self.bChartBleDataUpdate  = FALSE
  }
      

   
  func TaskRoundEnd()
  {
    self.dwSysCtl2 &= ~(SYS_CTL2_SEC_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_000MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_100MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_200MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_300MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_400MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_500MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_600MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_700MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_800MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_900MS_EVT);
    
    
    self.dwSysCtl2 &= ~(SYS_CTL2_TIMER_50MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_TIMER_100MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_TIMER_200MS_EVT);
    self.dwSysCtl2 &= ~(SYS_CTL2_TIMER_500MS_EVT);
    
    self.dwSysCtl2 &= ~SYS_CTL2_TASK_EVT
    
    usleep(500)
    
    self.FuncTaskLoopEnd()
  }
    
  
  @objc func TaskLoop()
  {
    if(self.bTaskLoopOn == TRUE)
    {
      //self.DbgPrint("[MAIN][!!!!] Skipped\n")
      return
    }
    
    self.bTaskLoopOn  = TRUE
    
    self.TaskRoundInit();
    
    self.TaskTime()
          
    self.TaskBleScan();
    
    self.TaskBleCmd();

    self.TaskBleSReg();
    
    self.TaskBleState();
    
    self.TaskBleChart();
    
    
    
    self.TaskRoundEnd();
    
    self.bTaskLoopOn = FALSE
  }  

  func TaskLoopOn()
  {
    if(self.bTaskMainLoopOn == FALSE)
    {
      self.bTaskMainLoopOn = TRUE
      _ = Task(priority: .high)
      {
        await self.ThreadTaskLoop()
      }
    }
  }
}
