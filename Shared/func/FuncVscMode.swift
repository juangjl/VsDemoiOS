//--------------------------------------------------------------------------------//
// @file  FuncSVscMode.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import Foundation
import CoreBluetooth
import SwiftUI

extension VsSDK
{
  func FuncVscModeInit()
  {
    self.iVscModeInitStep = VSC_MODE_INIT_STEP0
    self.iBleState = BLE_STATE_VSC_MODE_INIT
  }
  
  func FuncVscModeTypeSet()
  {
    self.CmdSBleVscModeTypeSet()
    self.iVscModeInitStep = VSC_MODE_INIT_STEP1
  }
  
  func FuncVscModeStart()
  {
    self.CmdSBleVscModeStart();
    
    self.fVscModeSec       = 0
    self.iVscModeStartUtc  = 0
    
    self.strVscBaseFolder  = ""
       
    //------------------------------------------------------------//
    // Chart
    //------------------------------------------------------------//
    self.iVscModeMSStart   = 0
    self.iVscModeMSEnd     = 0
        
    //------------------------------------------------------------//
    // ATR Reset
    //------------------------------------------------------------//
    self.vscAtrNow.Reset()
    self.vscAtrPre.Reset()
    self.iVscAtrCntPre =  0
    self.iVscAtrCnt    =  0

    self.healthInfo    = JHealthInfo()

    self.QueueVscAtr.sync
    {
      self.vscAtrQueue.removeAll()
    }

    //------------------------------------------------------------//
    // Data Set Reset
    //------------------------------------------------------------//
    self.iDataSetTime[DATASET_MONITOR_ECG_DS0] = 0;
    self.iDataSetTime[DATASET_MONITOR_ECG_DS1] = 0;
    self.iDataSetTime[DATASET_MONITOR_ECG_DS2] = 0;

    self.pDataSet[DATASET_MONITOR_ECG_DS0].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_ECG_DS1].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_ECG_DS2].JDataSetReset();
    
    self.pDataSet[DATASET_MONITOR_GSENSOR_X].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_GSENSOR_Y].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_GSENSOR_Z].JDataSetReset();
  }
  
  func FuncVscModeStop()
  {
    self.CmdSBleVscModeStop();
  }
  
  func FuncVscModeRead()
  {
    if(self.bVscModeReadOn == TRUE)
    {
      return
    }
    self.bVscModeReadOn = TRUE
    self.CmdSBleVscModeRead()
  }
  
  func FuncVscModeProcess()
  {        
    var pVscMode  : VscModeCtlType  = VscModeCtlType()
    var fGSenX : [Float] = [Float]()
    var fGSenY : [Float] = [Float]()
    var fGSenZ : [Float] = [Float]()
    
    var bUpdated : Bool = FALSE
    var iCount   : Int = 0
    var startTime : Int64 = 0
    
    self.QueueVscMode.sync
    {
      iCount = self.vscModeQueue.count
    }
    
    for _ in 0..<iCount
    {
      self.QueueVscMode.sync
      {
        pVscMode = self.vscModeQueue.removeFirst()      
      }
      
      if(self.VscModeCtl.iVscFileModeStartFlag == 1)
      {
        self.VscModeCtl.iVscFileModeStartFlag = 0;
        self.iVscModeMSStart       = Int64(self.iVscModeStartUtc) * 1000
        self.iVscModeMSEnd         = self.iVscModeMSStart
      }
      if(self.iVscModeStartUtc == 0)
      {
        //------------------------------------------------------------------------//
        // 1st VSC Mode Packet --> Add a measurement item
        //------------------------------------------------------------------------//
        self.iVscModeStartUtc     = Int64(pVscMode.jtm.t)
        self.iVscModeMSStart      = Int64(self.iVscModeStartUtc) * 1000
        self.iVscModeMSEnd        = self.iVscModeMSStart
        // Removed DB functionality        
        print("self.iVscModeStartUtc : \(self.iVscModeStartUtc),  self.iVscModeMSEnd: \( self.iVscModeMSEnd) \r\n");
      }
      
      self.iVscModeEndUtc         = Int64(pVscMode.jtm.t)
      self.iVscModeEclapsedSec    = Int64(self.iVscModeEndUtc) - Int64(self.iVscModeStartUtc)
      
      self.iVscModeMSEnd          = self.iVscModeMSEnd + 200

      //------------------------------------------------------------------------------------------//
      //  Chart Data of ECG Set
      //------------------------------------------------------------------------------------------//
      self.pDataSet[DATASET_MONITOR_ECG_DS0].JDataSetFIFOAdd(pVscMode.fValueCH[0], VSC_MODE_CHANNEL_DATA_COUNT, 3000)
      self.pDataSet[DATASET_MONITOR_ECG_DS1].JDataSetFIFOAdd(pVscMode.fValueCH[1], VSC_MODE_CHANNEL_DATA_COUNT, 3000)

      self.iDataSetTime[DATASET_MONITOR_ECG_DS0] = self.iDataSetTime[DATASET_MONITOR_ECG_DS0] + 200
      self.iDataSetTime[DATASET_MONITOR_ECG_DS1] = self.iDataSetTime[DATASET_MONITOR_ECG_DS1] + 200

      //------------------------------------------------------------------------------------------//
      //  Chart Data of Gsensor Set
      //------------------------------------------------------------------------------------------//
      for i in 0..<VSC_MODE_GSENSOR_DATA_COUNT
      {
        fGSenX.append(Float(Float(pVscMode.sGSenX[i]) / 100))
        fGSenY.append(Float(Float(pVscMode.sGSenY[i]) / 100))
        fGSenZ.append(Float(Float(pVscMode.sGSenZ[i]) / 100))
      }

      self.pDataSet[DATASET_MONITOR_GSENSOR_X].JDataSetFIFOAdd(fGSenX, VSC_MODE_GSENSOR_DATA_COUNT, 150)
      self.pDataSet[DATASET_MONITOR_GSENSOR_Y].JDataSetFIFOAdd(fGSenY, VSC_MODE_GSENSOR_DATA_COUNT, 150)
      self.pDataSet[DATASET_MONITOR_GSENSOR_Z].JDataSetFIFOAdd(fGSenZ, VSC_MODE_GSENSOR_DATA_COUNT, 150)
      
      // ATR
      startTime  = Int64(self.iVscModeStartUtc)
      /// check the vsc file mode is running
      if(self.VscModeCtl.iVscFileEnableStatus == 1)
      {
        /// file mode will reduce the running time
        let deltaTime : UInt32 = UInt32(self.VscModeCtl.dwVscFileModeRunSec * 1000)
        if(self.VscModeCtl.iVscFileEnableStatus == 1)
        {
          // print("[CMD] iVscFileEnableStatus delta Time: \(deltaTime) \r\n");
          // check the ATR label time is > 0
          if(pVscMode.atrNow.dwMS > deltaTime )
          {
            pVscMode.atrNow.dwMS = pVscMode.atrNow.dwMS - deltaTime;
          }
          else
          {
            pVscMode.atrNow.bAtr = ATR_NONE
          }
        }
      }
      if(pVscMode.atrNow.bAtr != ATR_NONE)
      {
        let atrNew      : JAtrType = JAtrType()
        let atrDBNew    : JAtrType = JAtrType()
        let atrFileNew  : JAtrType = JAtrType()
        // Bypass the unreadable HR setting
        if(self.iAtrBypassStage == ATR_UNREADABLE_END_STAGE)
        {
          self.iAtrBypassStage = ATR_UNREADABLE_BYPASS_STAGE;
        }

        if(pVscMode.atrNow.bAtr == ATR_UNREADABLES)
        {
          self.iAtrBypassStage = ATR_UNREADABLE_START_STAGE;
        }
        if(pVscMode.atrNow.bAtr == ATR_UNREADABLEE)
        {
          self.iAtrBypassStage = ATR_UNREADABLE_END_STAGE;
        }

        pVscMode.atrNow.StartTimeSet(startTime)
        
        self.vscAtrNow.AtrCopy(pVscMode.atrNow)
        
        // delta seconds
        self.vscAtrNow.fDeltaSec = Float(vscAtrNow.iTimeMS - self.vscAtrPre.iTimeMS) / 1000
        
        // Delta time 
        if(self.vscAtrNow.fDeltaSec < 0)
        {
          self.vscAtrNow.fDeltaSec = 0
        }
        else if(self.vscAtrNow.fDeltaSec > 5)
        {
          self.vscAtrNow.fDeltaSec = 0
        }

        // heart rate by delta seconds
        if(self.vscAtrNow.fDeltaSec > 0)
        {
          self.vscAtrNow.fAtrHR = (60 / vscAtrNow.fDeltaSec)
        }
        else
        {
          self.vscAtrNow.fAtrHR = -1
        }

        atrNew.AtrCopy(self.vscAtrNow)
        atrFileNew.AtrCopy(self.vscAtrNow)
        atrDBNew.AtrCopy(self.vscAtrNow)
                                
        // for VSC ATR ADD
        QueueVscAtr.sync
        {
          self.vscAtrQueue.append(atrNew)
        }

        self.vscAtrNow.AtrCopy(atrNew)        
        self.vscAtrPre.AtrCopy(atrNew)
        
        self.iVscAtrCntPre = self.iVscAtrCnt
        self.iVscAtrCnt    = self.iVscAtrCnt + 1
                
        // for ATR FILE ADD
        QueueFileAtr.sync
        {
          self.fileAtrAddQueue.append(atrFileNew)
        }
        
        //----------------------------------------------------------------//
        // Health Information : HEART RATE
        //----------------------------------------------------------------//
        if(self.iAtrBypassStage == ATR_UNREADABLE_NULL_STAGE)
        {
          self.healthInfo.HeartRateSet(self.vscAtrNow.fAtrHR,  self.vscAtrNow.bAtr)
        }
        else
        {
          if(self.iAtrBypassStage == ATR_UNREADABLE_BYPASS_STAGE)
          {
            self.iAtrBypassStage = ATR_UNREADABLE_NULL_STAGE;
          }
        }
      }
      
      //----------------------------------------------------------------//
      // Information
      //----------------------------------------------------------------//
      if(pVscMode.wId % 5 == 0)
      {
        self.VscModeCtl.VscModeInfoCopy(pVscMode: pVscMode)
        self.vsInfoNow.VscModeParse(pVscMode : pVscMode)
                
        //----------------------------------------------------------------//
        // Removed DB functionality
        //----------------------------------------------------------------//
        let vsInfoNew : VSInfo     = VSInfo()
        vsInfoNew.Copy(self.vsInfoNow)

        //----------------------------------------------------------------//
        // Health Information : Temp
        //----------------------------------------------------------------//
        let fTempNow : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_TEMP)
        self.healthInfo.TempSet(fTempNow)

        //----------------------------------------------------------------//
        // Health Information : G-Sensor
        //----------------------------------------------------------------//
        let fGSenX     : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_GSEN_X_NOW)
        let fGSenY     : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_GSEN_Y_NOW)
        let fGSenZ     : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_GSEN_Z_NOW)
        let fGSenPower : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_GSEN_POWER)
        self.healthInfo.GSensorSet(fGSenX, fGSenY, fGSenZ, fGSenPower)

        //----------------------------------------------------------------//
        // Health Information : HRV
        //----------------------------------------------------------------//
        let fHrvRR      : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_RR)
        let fHrvSdnn    : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_SDNN)
        let fHrvRmssd   : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_RMSSD)
        let fHrvLFHF    : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_LFHF)
        let fHrvLFTP    : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_LFTP)
        let fHrvHFTP    : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_HRV_HFTP)
        self.healthInfo.HrvSet(fHrvRR, fHrvSdnn, fHrvRmssd, fHrvLFHF, fHrvLFTP, fHrvHFTP)

        //----------------------------------------------------------------//
        // Health Information : BattSoc
        //----------------------------------------------------------------//
        let fBattSocNow : Float = self.vsInfoNow.FloatGet(VS_INFO_LABEL_BATT_SOC)
        self.healthInfo.BattSocSet(fBattSocNow)
      }
      
      //------------------------------------------------------------------------------------------//
      //  Save VscMode Data
      //------------------------------------------------------------------------------------------//
      if(self.bVscModeSave == TRUE)
      {
        // for File Save
        let newVscMode : VscModeCtlType = VscModeCtlType()
        newVscMode.Copy(pVscMode)
        self.QueueFileVscMode.sync  
        {
          self.vscModeSaveQueue.append(newVscMode)
        }
      }
            
      self.fVscModeSec = self.fVscModeSec  + 0.2
      bUpdated = TRUE      
    }
    
    self.bChartBleDataUpdate  = bUpdated
  }
  
  func FuncVscModeFileNameSet(_ pVscMode : VscModeCtlType)
  {
    var strFolderName : String = ""
    var strFileName : String = ""
    
    //----------------------------------------------------------------------//
    // 1. Base folder Set
    //----------------------------------------------------------------------//
    if(self.strVscBaseFolder == "")
    {
      strFolderName = String(format : "/VS/%@", self.strDeviceSsn)
      if(self.fileCtl.FolderExisted(self.strVscBaseFolder) == FALSE)
      {
        self.fileCtl.FolderCreate(strFolderName)
      }
      
      self.strVscBaseFolder = String(format : "%@/",    strFolderName) +
                              String(format : "%04d",   pVscMode.jtm.iYear) +
                              String(format : "%02d",   pVscMode.jtm.iMonth) +
                              String(format : "%02d_",  pVscMode.jtm.iDay) +
                              String(format : "%02d",   pVscMode.jtm.iHour) +
                              String(format : "%02d",   pVscMode.jtm.iMin) +
                              String(format : "%02d",   pVscMode.jtm.iSec)
                                              
      
      if(self.fileCtl.FolderExisted(self.strVscBaseFolder) == FALSE)
      {
        self.fileCtl.FolderCreate(self.strVscBaseFolder)
      }
    }
    
    //----------------------------------------------------------------------//
    // 2. Date folder Set
    //----------------------------------------------------------------------//
    self.strVscDateFolder = String(format : "%@/",    strVscBaseFolder) +
                            String(format : "%04d",   pVscMode.jtm.iYear) +
                            String(format : "%02d",   pVscMode.jtm.iMonth) +
                            String(format : "%02d",   pVscMode.jtm.iDay)
     
    if(self.fileCtl.FolderExisted(self.strVscDateFolder) == FALSE)
    {
      self.fileCtl.FolderCreate(self.strVscDateFolder)
    }
   
    //----------------------------------------------------------------------//
    // 3. Hour folder Set
    //----------------------------------------------------------------------//
    self.strVscHourFolder = String(format : "%@/%02d",
                                     self.strVscDateFolder,
                                     pVscMode.jtm.iHour)
    
    if(self.fileCtl.FolderExisted(self.strVscHourFolder) == FALSE)
    {
      self.bHourFolderCreate = TRUE
      self.fileCtl.FolderCreate(self.strVscHourFolder)
    }
    else
    {
      self.bHourFolderCreate = FALSE
    }
    
    //----------------------------------------------------------------------//
    // 4. Set ECG data and Resolution fle
    //----------------------------------------------------------------------//
    self.strVscFileNameEcgCsv.removeAll()
    self.strVscFileNameEcgBin.removeAll()
    
    for i in 0..<Int(self.VscModeCtl.iChannelCount)
    {
      self.strVscFileNameEcgCsv.append(String(format : "%@/ch%d.csv", self.strVscHourFolder, i))
      self.strVscFileNameEcgBin.append(String(format : "%@/ch%d.bin", self.strVscHourFolder, i))
      
      // resolution file 
      strFileName = String(format : "%@/ch%d.reso", self.strVscHourFolder, i);
      if(self.fileCtl.FileExisted(strFileName) == FALSE)
      {
        let fp : FileHandle? = fileCtl.FileOpen(strFileName, "w+")
        if(fp != nil)
        {          
          fileCtl.FilePrint(fp!, String(format : "%0.3f", 1))
          fileCtl.FileClose(fp!)
        }
        else
        {
          print(String(format : "\t [VSC][SAVE] Failed to open the file '%@'\n", strFileName))
        }
      }
    }
    
    //----------------------------------------------------------------------//
    // 5. Set Info data
    //----------------------------------------------------------------------//
    self.strVscFileNameInfoCsv = String(format : "%@/info.csv", self.strVscHourFolder);
    
    //----------------------------------------------------------------------//
    // 6. Set GSensor data
    //----------------------------------------------------------------------//
    self.strVscFileNameGSensorCsv = String(format : "%@/gsen.csv", self.strVscHourFolder);
    
    //----------------------------------------------------------------------//
    // 7. Set ATR data : CSV & BIN
    //----------------------------------------------------------------------//
    self.strVscFileNameAtrBin = String(format : "%@/vsc.atr.bin", self.strVscHourFolder);
    self.strVscFileNameAtrCsv = String(format : "%@/vsc.atr.csv", self.strVscHourFolder);
  }
     
  func FuncVscModeEcgDataCsvSave(_ pVscMode : VscModeCtlType)
  {
    let iCnt : Int = Int(VSC_MODE_ITEM_DATA_SIZE / 4) / Int(self.VscModeCtl.iChannelCount)
        
    for iCH in 0..<Int(self.VscModeCtl.iChannelCount)
    {
  
      let fp = self.fileCtl.FileOpen(self.strVscFileNameEcgCsv[iCH], "a+");
    
      if(fp == nil)
      {
        print(String(format : "\t\t [VSC][ERROR][ECG][%02d] Failed to open '%@'\r\n", iCH, self.strVscFileNameEcgCsv[iCH]))
        continue;
      }

      for i in 0..<iCnt
      {
        let strValue = String(format : "%0.3f\n", pVscMode.fValueCH[iCH][i])
        self.fileCtl.FilePrint(fp!, strValue)
      }
      self.fileCtl.FileClose(fp!);
    }
  }
  
  func FuncVscModeEcgDataBinSave(_ pVscMode : VscModeCtlType)
  {
    let iCnt : Int = Int(VSC_MODE_ITEM_DATA_SIZE / 4) / Int(self.VscModeCtl.iChannelCount)
        
    var bData : [UInt8]  = [UInt8]()
    var fValue : Float    = 0
               
    for iCH in 0..<Int(self.VscModeCtl.iChannelCount)
    {
      // File open
      let fp  = self.fileCtl.FileOpen(self.strVscFileNameEcgBin[iCH], "a+")
      if(fp == nil)
      {
        print(String(format : "[ECG_BIN_SAVE][ERROR] Failed to open the ECG_BIN file '%@'\n", self.strVscFileNameEcgBin[iCH]))
        continue
      }
    
      for i in 0..<iCnt
      {
        fValue =  pVscMode.fValueCH[iCH][i]
        // 4 bytes A
        bData = withUnsafeBytes(of: &fValue) { Array($0) }
        self.fileCtl.FileWrite(fp!, bData);
      }
      self.fileCtl.FileClose(fp!);
    }
  }
  
  func FuncVscModeGSensorDataSave(_ pVscMode : VscModeCtlType)
  {
    let fp : FileHandle? = self.fileCtl.FileOpen(self.strVscFileNameGSensorCsv, "a+");
        
    if(fp == nil)
    {
      print(String(format : "\t\t [VSC][ERROR][GSENSOR] Failed to open %@\r\n", self.strVscFileNameGSensorCsv))
      return;
    }
    
    for i in 0..<5
    {
      let strValue : String =  String(format : "%d,",  pVscMode.sGSenX[i]) +
                               String(format : "%d,",  pVscMode.sGSenY[i]) +
                               String(format : "%d\n", pVscMode.sGSenZ[i])
      self.fileCtl.FilePrint(fp!, strValue)
    }
    
    self.fileCtl.FileClose(fp!);
  }
  
  func FuncVscModeInfoHeaderSave(_ pVscMode : VscModeCtlType, _ fp : FileHandle)
  {
    // YEAR
    self.fileCtl.FilePrint(fp, String(format :"%@", "YEAR,"))
    // MONTH
    self.fileCtl.FilePrint(fp, String(format :"%@", "MONTH,"))
    // DAY
    self.fileCtl.FilePrint(fp, String(format :"%@", "DAY,"))
    // HOUR
    self.fileCtl.FilePrint(fp, String(format :"%@", "HOUR,"))
    // MIN
    self.fileCtl.FilePrint(fp, String(format :"%@", "MIN,"))
    // SEC
    self.fileCtl.FilePrint(fp, String(format :"%@", "SEC,"))
    // MS
    self.fileCtl.FilePrint(fp, String(format :"%@", "MS,"))

    // VSC_MODE_INFO_TYPE0_TIME_UTC                (1)
    self.fileCtl.FilePrint(fp, String(format :"%@", "UTC,"))

    // VSC_MODE_INFO_TYPE0_TEMP_T                  (2)
    self.fileCtl.FilePrint(fp, String(format :"%@", "TEMP,"))
    
    // VSC_MODE_INFO_TYPE0_ECG_HR                  (3)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HR_NOW,"))

    // VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF            (4)
    self.fileCtl.FilePrint(fp, String(format :"%@", "LEAD_OFF,"))

    // VSC_MODE_INFO_TYPE0_GSEN_X                  (5)
    self.fileCtl.FilePrint(fp, String(format :"%@", "GSEN_X_NOW,"))

    // VSC_MODE_INFO_TYPE0_GSEN_Y                  (6)
    self.fileCtl.FilePrint(fp, String(format :"%@", "GSEN_Y_NOW,"))

    // VSC_MODE_INFO_TYPE0_GSEN_Z                  (7)
    self.fileCtl.FilePrint(fp, String(format :"%@", "GSEN_Z_NOW,"))

    // VSC_MODE_INFO_TYPE0_BATT_SOC                (8)
    self.fileCtl.FilePrint(fp, String(format :"%@", "BATT_SOC,"))

    // VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC          (9)
    self.fileCtl.FilePrint(fp, String(format :"%@", "BATT_TOTAL_SEC,"))

    // VSC_MODE_INFO_TYPE0_HRV_SDNN                (10)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_SDNN,"))
    
    // VSC_MODE_INFO_TYPE0_HRV_NN50                (11)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_NN50,"))

    // VSC_MODE_INFO_TYPE0_HRV_RMSSD                (12)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_RMSSD,"))

    // VSC_MODE_INFO_TYPE0_HRV_RR                  (13)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_RR,"))

    // VSC_MODE_INFO_TYPE0_HRV_VLF                  (14)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_VLF,"))

    // VSC_MODE_INFO_TYPE0_HRV_LF                  (15)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_LF,"))

    // VSC_MODE_INFO_TYPE0_HRV_HF                  (16)
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_HF,"))
    
    // TP
    self.fileCtl.FilePrint(fp, String(format :"%@", "HRV_TP,"))
    
    // LF/TP
    self.fileCtl.FilePrint(fp, String(format :"%@", "LFTP,"))
    
    // HF/TP
    self.fileCtl.FilePrint(fp, String(format :"%@", "HFTP,"))
    
    // LF/HF
    self.fileCtl.FilePrint(fp, String(format :"%@", "LFHF,"))
    
    // GSEN-POWER
    self.fileCtl.FilePrint(fp, String(format :"%@", "GSEN_POWER,"))
    
    // TILT_PITCH
    self.fileCtl.FilePrint(fp, String(format :"%@", "TILT_PITCH,"))

    // TILT_ROLL
    self.fileCtl.FilePrint(fp, String(format :"%@", "TILT_ROLL,"))

    // BAR
    self.fileCtl.FilePrint(fp, String(format :"%@", "BAR,"))

    // BAR_TEMP
    self.fileCtl.FilePrint(fp, String(format :"%@", "BAR_TEMP,"))

    self.fileCtl.FilePrint(fp, String(format :"%@", "\n"))
  }
  
  func FuncVscModeInfoDataSave(_ pVscMode : VscModeCtlType, _ fp : FileHandle)
  {
    // YEAR
    self.fileCtl.FilePrint(fp, String(format :"%04d,", pVscMode.jtm.iYear))
    // MONTH
    self.fileCtl.FilePrint(fp, String(format :"%02d,", pVscMode.jtm.iMonth))
    // DAY
    self.fileCtl.FilePrint(fp, String(format :"%02d,", pVscMode.jtm.iDay))
    // HOUR
    self.fileCtl.FilePrint(fp, String(format :"%02d,", pVscMode.jtm.iHour))
    // MIN
    self.fileCtl.FilePrint(fp, String(format :"%02d,", pVscMode.jtm.iMin))
    // SEC
    self.fileCtl.FilePrint(fp, String(format :"%02d,", pVscMode.jtm.iSec))
    // MS
    self.fileCtl.FilePrint(fp, String(format :"%03d,", pVscMode.jtm.iMS))
    // VSC_MODE_INFO_TYPE0_TIME_UTC                (1)
    self.fileCtl.FilePrint(fp, String(format :"%d,",   pVscMode.dwUTC))

    // VSC_MODE_INFO_TYPE0_TEMP_T                  (2)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fTemp))
    
    // VSC_MODE_INFO_TYPE0_ECG_HR                  (3)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHRNow))

    // VSC_MODE_INFO_TYPE0_ECG_LEAD_OFF            (4)
    self.fileCtl.FilePrint(fp, String(format :"%0.0f,", pVscMode.fLeadOff))

    // VSC_MODE_INFO_TYPE0_GSEN_X                  (5)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fGsenXNow))

    // VSC_MODE_INFO_TYPE0_GSEN_Y                  (6)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fGsenYNow))

    // VSC_MODE_INFO_TYPE0_GSEN_Z                  (7)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fGsenZNow))

    // VSC_MODE_INFO_TYPE0_BATT_SOC                (8)
    self.fileCtl.FilePrint(fp, String(format :"%0.0f,",  pVscMode.fBattSoc))

    // VSC_MODE_INFO_TYPE0_BATT_TOTAL_SEC          (9)
    self.fileCtl.FilePrint(fp, String(format :"%0.0f,", pVscMode.fBattTotalSec))

    // VSC_MODE_INFO_TYPE0_HRV_SDNN                (10)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvSDNN))
    
    // VSC_MODE_INFO_TYPE0_HRV_NN50                (11)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvNN50))

    // VSC_MODE_INFO_TYPE0_HRV_RMSSD                (12)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvRMSSD))

    // VSC_MODE_INFO_TYPE0_HRV_RR                  (13)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvRR))

    // VSC_MODE_INFO_TYPE0_HRV_VLF                  (14)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvVLF))

    // VSC_MODE_INFO_TYPE0_HRV_LF                  (15)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvLF))

    // VSC_MODE_INFO_TYPE0_HRV_HF                  (16)
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvHF))
    
    // TP
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvTP))
    
    // LF/TP
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvLFTP))
    
    // HF/TP
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvHFTP))
    
    // LF/HF
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fHrvLFHF))
    
    // GSEN-POWER
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", pVscMode.fGsenPower))

    // TILT_PITCH
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", self.vsInfoNow.fValueArr[VS_INFO_ID_TILT_PITCH]))

    // TILT_ROLL
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", self.vsInfoNow.fValueArr[VS_INFO_ID_TILT_ROLL]))

    // BAR
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", self.vsInfoNow.fValueArr[VS_INFO_ID_BAR]))

    // VS_INFO_ID_BAR_TEMP
    self.fileCtl.FilePrint(fp, String(format :"%0.3f,", self.vsInfoNow.fValueArr[VS_INFO_ID_BAR_TEMP]))

    self.fileCtl.FilePrint(fp, String(format :"%@", "\n"))
  }
  
  func FuncVscModeInfoSave(_ pVscMode : VscModeCtlType)
  {
    var fp : FileHandle? = nil
    var bHeaderGen : Bool = FALSE
    
    if(self.fileCtl.FileExisted(self.strVscFileNameInfoCsv) == FALSE)
    {
      bHeaderGen = TRUE;
    }
    
    fp = self.fileCtl.FileOpen(self.strVscFileNameInfoCsv, "a+");
    
    if(fp == nil)
    {
      print(String(format : "\t\t [VSC][ERROR][INFO] Failed to open %@\r\n", self.strVscFileNameInfoCsv))
      return;
    }
    
    if(bHeaderGen == TRUE)
    {
      self.FuncVscModeInfoHeaderSave(pVscMode, fp!);
    }
    
    self.FuncVscModeInfoDataSave(pVscMode, fp!);
    
    self.fileCtl.FileClose(fp!);
  }
  
  func FuncVscModeTMFileSave(_ pVscMode : VscModeCtlType)
  {
    if(self.bHourFolderCreate == TRUE)
    {
      // Create timestamp file
      let strTmFileName = String(format : "%@/tm.txt", self.strVscHourFolder)
      let fp : FileHandle? = self.fileCtl.FileOpen(strTmFileName, "w+")
      if(fp != nil)
      {
        var strValue : String = ""
        let iTotalSec = pVscMode.jtm.iMin * 60 + pVscMode.jtm.iSec
        
        strValue = String(format : "%d\n", iTotalSec)
        self.fileCtl.FilePrint(fp!, strValue)
        
        strValue = String(format : "%d\n", pVscMode.jtm.t)
        self.fileCtl.FilePrint(fp!, strValue)
        
        strValue =  String(format : "%04d/",  pVscMode.jtm.iYear)  +
                    String(format : "%02d/",  pVscMode.jtm.iMonth) +
                    String(format : "%02d-",  pVscMode.jtm.iDay)   +
                    String(format : "%02d:",  pVscMode.jtm.iHour)  +
                    String(format : "%02d:",  pVscMode.jtm.iMin)   +
                    String(format : "%02d\n", pVscMode.jtm.iSec)
                       
        self.fileCtl.FilePrint(fp!, strValue)
        
        self.fileCtl.FileClose(fp!)
      }
    }
  }
  
  func FuncVscModeAtrBinSave(_ atr: JAtrType)
  {
    var fp : FileHandle? = nil
    var bData : [UInt8]  = [UInt8]()
    var iA : Int32 = Int32(atr.bAtr)
    
    // File open
    fp  = self.fileCtl.FileOpen(self.strVscFileNameAtrBin, "a+")
    if(fp == nil)
    {
      print(String(format : "[ATR_SAVE][ERROR] Failed to open the ATR_BIN file '%@'\n", self.strVscFileNameAtrBin))
      return
    }
    
    // 4 bytes A
    bData = withUnsafeBytes(of: &iA) { Array($0) }
    self.fileCtl.FileWrite(fp!, bData);
    
    // 4 bytes MS
    bData = withUnsafeBytes(of: &atr.dwMS) { Array($0) }
    self.fileCtl.FileWrite(fp!, bData);
    
    self.fileCtl.FileClose(fp!)
  }

  func FuncVscModeAtrCsvSave(_ atr: JAtrType)
  {
    var fp : FileHandle?  = self.fileCtl.FileOpen(self.strVscFileNameAtrCsv, "a+")
    var A : Int           = Int(atr.bAtr)
    var bHeaderGen: Bool  = FALSE
    var strTime : String  = ""
    var fTimeSec : Float  = 0
    var fDeltaSec : Float = 0
    var idx : Int         = 0
    var strNote: String   = ""
    
    var iMS : Int         = 0
    var iTimeSec : Int    = 0
    
    var strValue : String = ""
    
    if(self.fileCtl.FileExisted(self.strVscFileNameAtrCsv) == FALSE)
    {
      bHeaderGen = TRUE
    }
    
    // File open
    fp = self.fileCtl.FileOpen(self.strVscFileNameAtrCsv, "a+")
    
    if(fp == nil)
    {
      print(String(format : "[ATR_SAVE][ERROR] Failed to open the ATR_CSV file '%@'\n", self.strVscFileNameAtrCsv))
      return
    }
    
    // Header print
    if(bHeaderGen == TRUE)
    {
      strValue = String("#,TIME,TSEC,DT,A,LABEL,NOTE\n")
      self.fileCtl.FilePrint(fp!, strValue)
    }

    // idx get
    idx = self.iVscAtrCnt

    // Time get
    fTimeSec  = Float(atr.dwMS) / 1000
    
    iMS      = Int(atr.dwMS % 1000)
    iTimeSec = Int((Int(atr.dwMS) - iMS) / 1000)
    
    // Time String get
    strTime = self.util.TimeStringGet(iTimeSec, iMS)
    
    // Delta time get
    fDeltaSec = atr.fDeltaSec
    
    // A get
    A = Int(atr.bAtr)

    // note
    strNote  = String(format : "%@", JAtrAbbrev[A]);
    
    strValue =  String(format :"%d,",     idx)          +
                String(format :"%@,",     strTime)      +
                String(format :"%0.3f,",  fTimeSec)     +
                String(format :"%0.3f,",  fDeltaSec)    +
                String(format :"%d,",     A)            +
                String(format :"%@,",     JAtrLabel[A]) +
                String(format :"%@\n",    strNote)
    
    //self.DbgPrint(strValue)
    
    self.fileCtl.FilePrint(fp!, strValue)
    
    self.fileCtl.FileClose(fp!)
  }
  
  func FuncVscModeAtrFileSave(_ pVscMode : VscModeCtlType)
  {
    var pAtr : JAtrType?

    QueueFileAtr.sync
    {
      let iCount = self.fileAtrAddQueue.count
      if(iCount == 0)
      {
        return;
      }
      for _ in 0..<iCount
      {
        pAtr = self.fileAtrAddQueue.removeFirst()
        if let pAtr = pAtr
        {
          self.FuncVscModeAtrBinSave(pAtr)
          self.FuncVscModeAtrCsvSave(pAtr)
        }
      }
    }
  }

  func FuncVscModeAtrFind(_ iTimeMSStart : Int64, _ iTimeMSEnd : Int64)->[JAtrType]
  {
    var atrArr : [JAtrType] = [JAtrType]()
    var iTimeStart : Int64 = 0;
    var cnt : Int = 0;

    QueueVscAtr.sync
    {
      let iCount = self.vscAtrQueue.count

      if(iTimeMSStart > 1000)
      {
        iTimeStart = iTimeMSStart - 1000;
      }

      for i in 0..<iCount
      {
        let atrNew : JAtrType = JAtrType()
        atrNew.AtrCopy(self.vscAtrQueue[i])
        let atr : JAtrType? = atrNew
        if let atr
        {
          if(atr.iTimeMS < iTimeStart)
          {
            cnt = cnt + 1;
            continue
          }
          if((atr.iTimeMS >= iTimeMSStart) && (atr.iTimeMS < iTimeMSEnd))
          {
            atrArr.append(atr)
          }
          if(atr.iTimeMS >= iTimeMSEnd)
          {
            break
          }
        }
      }
      if((cnt > 0))
      {
        for _ in 0..<cnt
        {
          self.vscAtrQueue.removeFirst()
        }
      }
    }    

    return atrArr
  }
  
  func FuncVscModeAtrLabelSet(_ atrArr : [JAtrType])
  {
    var iTimeStart   : Int64 = 0
    var iTimeEnd     : Int64 = Int64(self.iDataSetTime[DATASET_MONITOR_ECG_DS0]) + self.iVscModeMSStart
    
    var fXDelta      : Double   = 0
    var fXWidth      : Double   = 0
    
    let fYRatio      : Double   = 0.9
    var fXRatio      : Double   = 0
    
    var strLabel     : String = ""
        
    
    if((iTimeEnd - 6000) < self.iVscModeMSStart)
    {
      iTimeEnd   =  self.iVscModeMSStart + 6000
      iTimeStart = self.iVscModeMSStart
    }
    else
    {
      iTimeEnd   = Int64(self.iDataSetTime[DATASET_MONITOR_ECG_DS0]) + self.iVscModeMSStart
      iTimeStart = iTimeEnd - 6000
    }
    
    fXWidth = Double(iTimeEnd - iTimeStart)
    
    self.chartBleEcg0.LabelClear()
    
    for i in 0..<self.atrArrChartBle.count
    {
      let atr = self.atrArrChartBle[i]
      
      // calculte ratio of X
      fXDelta = Double(atr.iTimeMS - iTimeStart)
      fXRatio = fXDelta / fXWidth
      
      strLabel = JAtrAbbrev[Int(atr.bAtr)]
          
      self.chartBleEcg0.LabelAdd(Float(fXRatio), Float(fYRatio), strLabel)
    }
  }
  
  func FuncVscModeSave(_ pVscMode : VscModeCtlType)
  {
    //------------------------------------------------//
    // 1. File Name set
    //------------------------------------------------//
    self.FuncVscModeFileNameSet(pVscMode)
    
    //------------------------------------------------//
    // 2. ECG Data Save
    //------------------------------------------------//
    self.FuncVscModeEcgDataBinSave(pVscMode);
    self.FuncVscModeEcgDataCsvSave(pVscMode);

    //------------------------------------------------//
    // 3. GSensor Data Save
    //------------------------------------------------//
    self.FuncVscModeGSensorDataSave(pVscMode);
    
    //------------------------------------------------//
    // 4. Info information
    //------------------------------------------------//
    if((pVscMode.item.wId % 5) == 0)
    {
      self.FuncVscModeInfoSave(pVscMode);
    }
    
    //------------------------------------------------//
    // 5.TM
    //------------------------------------------------//
    self.FuncVscModeTMFileSave(pVscMode)
    
    //------------------------------------------------//
    // 6.ATR save
    //------------------------------------------------//
    self.FuncVscModeAtrFileSave(pVscMode)
  }  
  func FuncVscFileModeIsRunning()->Bool
  {
    if(self.VscModeCtl.iVscFileEnableStatus == 1)
    {
      /// setting the start
      return true;
    }
    else
    {
      return false;
    }
  }
  func FuncFileListClearAll()
  {
    self.CmdSBleFileListClearAll()
  }

  func FuncVscFileModeStart()
  {
    if(FuncVscFileModeIsRunning() == TRUE)
    {
      self.VscModeCtl.wId   = UInt16(self.VscModeCtl.iVscFileModeIndex);
      self.iVscModeInitStep = VSC_MODE_INIT_STEP4
      /// shift to current time
      self.iVscModeStartUtc = Int64(self.VscModeCtl.dwVscStartUtc + self.VscModeCtl.dwVscFileModeRunSec)
      self.VscModeCtl.wId   = UInt16(self.VscModeCtl.iVscFileModeIndex) - UInt16((self.VscModeCtl.wId % 5))
      self.VscModeCtl.iVscFileModeIndex = 0;
    }
    else
    {      
      self.CmdSBleVscFileModeStart();
      self.iVscModeStartUtc  = 0
      self.VscModeCtl.dwVscFileModeRunSec = 0
      self.iVscModeInitStep = VSC_MODE_INIT_STEP3
    }
    self.fVscModeSec       = 0
    self.strVscBaseFolder  = ""
    //------------------------------------------------------------//
    // Chart
    //------------------------------------------------------------//
    self.iVscModeMSStart   = 0
    self.iVscModeMSEnd     = 0
    //------------------------------------------------------------//
    // ATR Reset
    //------------------------------------------------------------//
    self.vscAtrNow.Reset()
    self.vscAtrPre.Reset()
    self.iVscAtrCntPre =  0
    self.iVscAtrCnt    =  0
    self.healthInfo    = JHealthInfo()
    self.QueueVscAtr.sync
    {
      self.vscAtrQueue.removeAll()
    }
    
    //------------------------------------------------------------//
    // Data Set Reset
    //------------------------------------------------------------//
    self.iDataSetTime[DATASET_MONITOR_ECG_DS0] = 0;
    self.iDataSetTime[DATASET_MONITOR_ECG_DS1] = 0;
    self.iDataSetTime[DATASET_MONITOR_ECG_DS2] = 0;
    self.pDataSet[DATASET_MONITOR_ECG_DS0].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_ECG_DS1].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_ECG_DS2].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_GSENSOR_X].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_GSENSOR_Y].JDataSetReset();
    self.pDataSet[DATASET_MONITOR_GSENSOR_Z].JDataSetReset();
  }
  
  func FuncVscFileModeStop()
  {
    self.VscModeCtl.iVscFileEnableStatus = 0
    self.CmdSBleVscFileModeStop()
  }
  
  func FuncVscFileModeRead()
  {
    if(self.bVscModeReadOn == TRUE)
    {
      return
    }
    self.bVscModeReadOn = TRUE
    self.CmdSBleVscFileModeReadEx()
  }

  func FuncVscFileModeInfoGet()
  {
    CmdSBleVscFileModeInfoStatus();
  }
}
