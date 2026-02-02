//--------------------------------------------------------------------------------//
// @file  ViewScanItemList.swift
// @version $Revision$
// @author JLJuang <jl_juang@vsigntek.com>
// @Copyright © 2023 VitalSigns Technology Co., Ltd. All rights reserved.
//--------------------------------------------------------------------------------//
import SwiftUI

struct ViewScanItemList: View
{
  //----------------------------------------------------------------//
  //
  // Variables
  //
  //----------------------------------------------------------------//
  @ObservedObject var vsSDK : VsSDK = VsSDK.shared
  @State var idx: Int = 0
  @State var strSearchText : String = ""
  @State var strLabalPaired: String = ""
  
  //----------------------------------------------------------------//
  // width and height
  //----------------------------------------------------------------//
  @State var fViewWidth                 : CGFloat     = 420
  
  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelSearchDeviceName   : String = ""
  
  let timer  = Timer.publish(every: 0.2, on: RunLoop.current, in: .common).autoconnect()
  
  func FilterConnectedArrGet() -> [VsPeripheral]
  {
    var listConnectedArr : [VsPeripheral] = [VsPeripheral]()
    if(strSearchText.isEmpty)
    {
      listConnectedArr = vsSDK.vsPeripheralConnectedArr
    }
    else
    {
      listConnectedArr = vsSDK.vsPeripheralConnectedArr.filter { peripheral in
        peripheral.strDeviceName.localizedCaseInsensitiveContains(strSearchText)
      }
    }
    return listConnectedArr
  }
  
  func FilterPeripheralArrGet() -> [VsPeripheral]
  {
    var listPeripheralArr : [VsPeripheral] = [VsPeripheral]()
    if(strSearchText.isEmpty)
    {
      listPeripheralArr = vsSDK.vsPeripheralArr
    }
    else
    {
      listPeripheralArr = vsSDK.vsPeripheralArr.filter { peripheral in
        peripheral.strDeviceName.localizedCaseInsensitiveContains(strSearchText)
      }
    }
    return listPeripheralArr
  }
  
  func UIUpdate()
  {
    //----------------------------------------------------------------//
    // Disctionary String update
    //----------------------------------------------------------------//
    self.strLabalPaired                    = "Paired"
    self.strLabelSearchDeviceName          = "Search Device Name"
  }
  
  func OnAppear()
  {
    var fWidth: CGFloat  = UIScreen.main.bounds.width
        
    if(fWidth < SCREEN_WIDTH_SMALL)
    {
      fWidth = SCREEN_WIDTH_SMALL
    }
            
    self.fViewWidth  = fWidth - 10
    
    self.UIUpdate()
  }
  
  func OnBtnSelectItem(vsPeripheral: VsPeripheral)
  {
    self.vsSDK.BleScanStop()
    self.vsSDK.BleConnect(vsPeripheral)
    self.vsSDK.vsPeripheralSelected = vsPeripheral
    self.vsSDK.strAutoConnectName = vsPeripheral.strDeviceName
    self.vsSDK.iViewId = VIEW_ID_CONNECTING
  }

  //------------------------------------------------------------------------------------------------//
  //
  // Views
  //
  //------------------------------------------------------------------------------------------------//  
  var body: some View
  {
    // search Text view
    HStack()
    {
      Spacer()
      ZStack(alignment: .leading)
      {
        TextField("", text: $strSearchText)
          .frame(width: 270)
          .foregroundColor(.black)
          .padding(10)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color(red: 242 / 256, green: 245 / 256, blue: 250 / 256))
              .overlay(
                RoundedRectangle(cornerRadius: 10)
              .stroke(Color(red: 210 / 255,  green: 218 / 255, blue: 222 / 255), lineWidth: 1)
            )
          )
          .cornerRadius(12)
        
        if(strSearchText.isEmpty)
        {
          Text(self.strLabelSearchDeviceName)
              .foregroundColor(Color(red: 142 / 255,  green: 142 / 255, blue: 147 / 255))
              .padding(.leading, 15)
        }
      }
        
      Spacer()
    }
      .padding(.bottom, 10)

    // Bluetooth device list view
    ScrollView()
    {
      VStack()
      {
        ForEach(FilterConnectedArrGet())
        { vsPeripheral in
          HStack()
          {
            Spacer()
            Button(action: { self.OnBtnSelectItem(vsPeripheral: vsPeripheral)})
            {
              Text(String(format: "%@", vsPeripheral.strDeviceName))
                .font(.custom(APP_FONT_NAME, size: 16))
                .frame(width: self.fViewWidth/2, height: 40, alignment: .leading)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .truncationMode(.head)
            }
            
            Spacer()
            
            Text(strLabalPaired)
              .font(.custom(APP_FONT_NAME, size: 14))
              .frame(height: 40, alignment: .trailing)
          }
        }
        
        ForEach(FilterPeripheralArrGet())
        { vsPeripheral in
          HStack()
          {
            Button(action: { self.OnBtnSelectItem(vsPeripheral: vsPeripheral)})
            {
              Text(String(format: "%@", vsPeripheral.strDeviceName))
                .font(.custom(APP_FONT_NAME, size: 16))
                .frame(width: self.fViewWidth/2, height: 40, alignment: .leading)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .truncationMode(.head)
            }
            
            Spacer()
              .frame(width:10)
            
            Text(String(format: " %d db", vsPeripheral.iRSSI))
              .font(.custom(APP_FONT_NAME, size: 14))
              .foregroundColor(Color.black)
              .frame(height: 40, alignment: .trailing)
          }
        }
        Spacer()
      }
    }
      .onAppear()
      {
        OnAppear()
      }
      .onReceive(timer)
      { timer in
          
      }
  }
}
