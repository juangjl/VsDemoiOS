//--------------------------------------------------------------------------------//
// @file  ViewTimerSelect.swift
// @brief for shared use across all display pages within the report to adjust time.
// @version $Revision$
// @author Jane Lin <jane_lin@vitalsignscorp.com>
// @Reviewer Ryan Yeh <ryan_yeh@vitalsignscorp.com>
// @note Copyright © 2025, VitalSigns Technology Co., Ltd. All rights reserved.
// @note
//--------------------------------------------------------------------------------//

import SwiftUI

class JTimeSelectListItem : NSObject, Identifiable, ObservableObject
{
  //----------------------------------------------------------------//
  // Variables
  //----------------------------------------------------------------//
  var idx           : Int     = 0
  var iAdditionID   : Int     = 0
  
  var strHeartRate  : String  = ""
  var strDate       : String  = ""
  var strTime       : String  = ""
  
  var strAdditions  : String  = ""
  var bSelected     : Bool    =  FALSE
        
  var iUtc          : Int     = 0
  var iMS           : Int     = 0
  
  var colorRowBg    : Color = ADDITION_COLOR_DEFAULT
  
  //----------------------------------------------------------------//
  // Functions
  //----------------------------------------------------------------//
  override init()
  {
    super.init()
  }
    
  deinit
  {

  }
}

struct TimerSetting {
    var chanegTime      : Int = 0
    var changeDuration  : Int = 0
    var changeYScale    : Float = 0.0
    var changeYGrid     : Int = 0
}

struct ViewTimerSelect: View
{
  //----------------------------------------------------------------//
  // Variables
  //----------------------------------------------------------------//
  var vsSDK = VsSDK.shared
  let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
  
  //----------------------------------------------------------------//
  //iSecond
  //----------------------------------------------------------------//
  @State var fSec                       : Float = 0
  
  //----------------------------------------------------------------//
  // UTC Select
  //----------------------------------------------------------------//
  @State var iUtcSelected               : UInt32 = 0
  
  //----------------------------------------------------------------//
  // width and height
  //----------------------------------------------------------------//
  var fTimeWidth                 : CGFloat     = 420
  var fTimeHeight                : CGFloat     = 1024
  
  //----------------------------------------------------------------//
  // Time Control
  //----------------------------------------------------------------//
  @State var iCustomYear                : Int = 2025
  @State var iCustomMonth               : Int = 1
  @State var iCustomDay                 : Int = 1
  @State var iCustomHour                : Int = 0
  @State var iCustomMin                 : Int = 0
  @State var iCustomSec                 : Int = 0
  @State var iTimeRangeSelected         : Int = 12
  @State var timeRangeOptionsArr        : [Int] = [12, 30, 60, 90]

  //----------------------------------------------------------------//
  // Y-axis Setting
  //----------------------------------------------------------------//
  @State var fYScaleSelected           : Float = 10.0
  @State var iYGridSelected            : Int = 12
  @State var fYScaleOptionsArr         : [Float] = [2.5, 5.0, 10.0, 20.0, 40.0]
  @State var iYGridOptionsArr          : [Int]    = [6, 8, 10, 12]
  
  //----------------------------------------------------------------//
  // Title
  //----------------------------------------------------------------//
  @State var fTitleFontSize     : CGFloat = 14
  @State var fValueFontSize     : CGFloat = 14

  @State var onReturnSelectedUtc: (TimerSetting) -> Void
  
  func TimeInitialize()
  {
    iUtcSelected = self.vsSDK.report.iTimerViewUtcSelected
    TimePickerUpdateWithSelected()
  }

  func UpdateSelectItemTime()
  {
    if(self.vsSDK.report.iTimerViewUtcSelected != iUtcSelected)
    {
      iUtcSelected = self.vsSDK.report.iTimerViewUtcSelected
      TimePickerUpdateWithSelected()
    }
  }
  
  // If there is a selected event,time picker update to the time of that event
  func TimePickerUpdateWithSelected()
  {
    if(self.iUtcSelected > 0)
    {
      let jtm = JTM()
      jtm.JTMLocalTimeGet(tNow: UInt32(self.iUtcSelected))
      self.iCustomYear  = jtm.iYear
      self.iCustomMonth = jtm.iMonth
      self.iCustomDay   = jtm.iDay
      self.iCustomHour  = jtm.iHour
      self.iCustomMin   = jtm.iMin
      self.iCustomSec   = jtm.iSec
    }
  }
  
  // Get valid hour range based on selected date
  func ValidHourRangeGet() -> ClosedRange<Int>
  {
    // Get record start and end time
    let iRecordStartTime : Int = Int(self.vsSDK.report.record.t0)
    let iRecordEndTime   : Int = Int(self.vsSDK.report.record.t1)
    
    let jtmStart : JTM = JTM()
    let jtmEnd   : JTM = JTM()
    
    jtmStart.JTMLocalTimeGet(tNow: UInt32(iRecordStartTime))
    jtmEnd.JTMLocalTimeGet(tNow: UInt32(iRecordEndTime))
    
    // Check if selected date is start date
    let bIsStartDate : Bool = (self.iCustomYear == jtmStart.iYear &&
                               self.iCustomMonth == jtmStart.iMonth &&
                               self.iCustomDay == jtmStart.iDay)
    
    // Check if selected date is end date
    let bIsEndDate : Bool = (self.iCustomYear == jtmEnd.iYear &&
                             self.iCustomMonth == jtmEnd.iMonth &&
                             self.iCustomDay == jtmEnd.iDay)
    
    // Check if start and end are same date
    let bIsSameDate : Bool = (jtmStart.iYear == jtmEnd.iYear &&
                              jtmStart.iMonth == jtmEnd.iMonth &&
                              jtmStart.iDay == jtmEnd.iDay)
    
    var iStartHour : Int = 0
    var iEndHour   : Int = 23
    
    if(bIsSameDate && bIsStartDate)
    {
      // Record within same date and user selected that date
      iStartHour = jtmStart.iHour
      iEndHour = jtmEnd.iHour
    }
    else if(bIsStartDate)
    {
      // User selected record start date
      iStartHour = jtmStart.iHour
      iEndHour = 23
    }
    else if(bIsEndDate)
    {
      // User selected record end date
      iStartHour = 0
      iEndHour = jtmEnd.iHour
    }
    // User selected record middle date
    let rangeResult : ClosedRange<Int> = iStartHour...iEndHour
    return rangeResult
  }
  
  func ValidMinuteRangeGet() -> ClosedRange<Int>
  {
    // Get record start and end time
    let iRecordStartTime : Int = Int(self.vsSDK.report.record.t0)
    let iRecordEndTime   : Int = Int(self.vsSDK.report.record.t1)
    
    let jtmStart : JTM = JTM()
    let jtmEnd   : JTM = JTM()
    
    jtmStart.JTMLocalTimeGet(tNow: UInt32(iRecordStartTime))
    jtmEnd.JTMLocalTimeGet(tNow: UInt32(iRecordEndTime))
    
    // Check if selected date and hour match start time
    let bIsStartHour : Bool = (self.iCustomYear == jtmStart.iYear &&
                               self.iCustomMonth == jtmStart.iMonth &&
                               self.iCustomDay == jtmStart.iDay &&
                               self.iCustomHour == jtmStart.iHour)
    
    // Check if selected date and hour match end time
    let bIsEndHour : Bool = (self.iCustomYear == jtmEnd.iYear &&
                             self.iCustomMonth == jtmEnd.iMonth &&
                             self.iCustomDay == jtmEnd.iDay &&
                             self.iCustomHour == jtmEnd.iHour)
    
    // Check if start and end are same hour
    let bIsSameHour : Bool = (jtmStart.iYear == jtmEnd.iYear &&
                              jtmStart.iMonth == jtmEnd.iMonth &&
                              jtmStart.iDay == jtmEnd.iDay &&
                              jtmStart.iHour == jtmEnd.iHour)
    
    var iStartMinute : Int = 0
    var iEndMinute   : Int = 59
    
    if(bIsSameHour && bIsStartHour)
    {
      // Record within same hour and user selected that hour
      iStartMinute = jtmStart.iMin
      iEndMinute = jtmEnd.iMin
    }
    else if(bIsStartHour)
    {
      // User selected record start hour
      iStartMinute = jtmStart.iMin
      iEndMinute = 59
    }
    else if(bIsEndHour)
    {
      // User selected record end hour
      iStartMinute = 0
      iEndMinute = jtmEnd.iMin
    }
    // User selected record middle hour
    let rangeResult : ClosedRange<Int> = iStartMinute...iEndMinute
    return rangeResult
  }
  
  func ValidSecondRangeGet() -> ClosedRange<Int>
  {
    // Get record start and end time
    let iRecordStartTime : Int = Int(self.vsSDK.report.record.t0)
    let iRecordEndTime   : Int = Int(self.vsSDK.report.record.t1)
    
    let jtmStart : JTM = JTM()
    let jtmEnd   : JTM = JTM()
    
    jtmStart.JTMLocalTimeGet(tNow: UInt32(iRecordStartTime))
    jtmEnd.JTMLocalTimeGet(tNow: UInt32(iRecordEndTime))
    
    // Check if selected date, hour and minute match start time
    let bIsStartMinute : Bool = (self.iCustomYear == jtmStart.iYear &&
                                 self.iCustomMonth == jtmStart.iMonth &&
                                 self.iCustomDay == jtmStart.iDay &&
                                 self.iCustomHour == jtmStart.iHour &&
                                 self.iCustomMin == jtmStart.iMin)
    
    // Check if selected date, hour and minute match end time
    let bIsEndMinute : Bool = (self.iCustomYear == jtmEnd.iYear &&
                               self.iCustomMonth == jtmEnd.iMonth &&
                               self.iCustomDay == jtmEnd.iDay &&
                               self.iCustomHour == jtmEnd.iHour &&
                               self.iCustomMin == jtmEnd.iMin)
    
    // Check if start and end are same minute
    let bIsSameMinute : Bool = (jtmStart.iYear == jtmEnd.iYear &&
                                jtmStart.iMonth == jtmEnd.iMonth &&
                                jtmStart.iDay == jtmEnd.iDay &&
                                jtmStart.iHour == jtmEnd.iHour &&
                                jtmStart.iMin == jtmEnd.iMin)
    
    var iStartSecond : Int = 0
    var iEndSecond   : Int = 59
    
    if(bIsSameMinute && bIsStartMinute)
    {
      // Record within same minute and user selected that minute
      iStartSecond = jtmStart.iSec
      iEndSecond = jtmEnd.iSec
    }
    else if(bIsStartMinute)
    {
      // User selected record start minute
      iStartSecond = jtmStart.iSec
      iEndSecond = 59
    }
    else if(bIsEndMinute)
    {
      // User selected record end minute
      iStartSecond = 0
      iEndSecond = jtmEnd.iSec
    }
    // User selected record middle minute
    let rangeResult : ClosedRange<Int> = iStartSecond...iEndSecond
    return rangeResult
  }
  
  func TimeAdjustAfterDateChange()
  {
    // Get valid time ranges using existing functions
    let rangeHourValid : ClosedRange<Int> = self.ValidHourRangeGet()
    
    // Check if current hour is within valid range
    let bIsHourInRange : Bool = rangeHourValid.contains(self.iCustomHour)
    if(bIsHourInRange == false)
    {
      self.iCustomHour = rangeHourValid.lowerBound
    }
    
    // Recalculate minute range and adjust if necessary
    let rangeMinuteUpdated : ClosedRange<Int> = self.ValidMinuteRangeGet()
    let bIsMinuteInRange : Bool = rangeMinuteUpdated.contains(self.iCustomMin)
    if(bIsMinuteInRange == false)
    {
      self.iCustomMin = rangeMinuteUpdated.lowerBound
    }
    
    // Recalculate second range and adjust if necessary
    let rangeSecondUpdated : ClosedRange<Int> = self.ValidSecondRangeGet()
    let bIsSecondInRange : Bool = rangeSecondUpdated.contains(self.iCustomSec)
    if(bIsSecondInRange == false)
    {
      self.iCustomSec = rangeSecondUpdated.lowerBound
    }
  }
  
  func TimeControlApply()
  {
    let calendarConverter: Calendar = Calendar.current
    
    //In ios cannot create a Date object directly using numbers, must first put each time unit into DateComponents and then convert it into a Date
    var dateComponents: DateComponents = DateComponents()
    dateComponents.year   = self.iCustomYear
    dateComponents.month  = self.iCustomMonth
    dateComponents.day    = self.iCustomDay
    dateComponents.hour   = self.iCustomHour
    dateComponents.minute = self.iCustomMin
    dateComponents.second = self.iCustomSec
    
    let CustomDate   : Date? = calendarConverter.date(from: dateComponents)
    let bHasValidDate: Bool = CustomDate != nil
    
    // Only proceed if we have a valid date
    if(bHasValidDate)
    {
      // Convert Date object to Unix timestamp
      let dCustomDate   : Date = CustomDate!
      let dTimeInterval : TimeInterval = dCustomDate.timeIntervalSince1970
      let iSelectedUtc  : Int = Int(dTimeInterval)
      
      let setting = TimerSetting(chanegTime: iSelectedUtc, changeDuration: self.iTimeRangeSelected, changeYScale: self.fYScaleSelected, changeYGrid: self.iYGridSelected)
      onReturnSelectedUtc(setting)
    }
  }

  func OnTimer()
  {
    self.UpdateSelectItemTime()
  }

  func OnAppear()
  {
    let fViewWidth : CGFloat = UIScreen.main.bounds.width
    
    if(fViewWidth < 420)
    {
      self.fTitleFontSize = 12
      self.fValueFontSize = 14
    }
    else if(fViewWidth > 640)
    {
      self.fTitleFontSize = 14
      self.fValueFontSize = 16
    }
    
    self.TimeInitialize()
  }

  //----------------------------------------------------------------//
  // Time Control
  //----------------------------------------------------------------//
  var body: some View
  {
    VStack()
    {
      Spacer()
      
      // Data picker section
      HStack()
      {
        VStack()
        {
          // Title section
          HStack()
          {
            Spacer()
              .frame(width: 40)
            
            Text("Date")
              .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
              .frame(width: 150, alignment: .leading)
              .foregroundColor(.gray)
            
            Spacer()
          }
            .frame(width: self.fTimeWidth)
          
          HStack()
          {
            Spacer()
              .frame(width: 15)
            
            // Date picker
            DatePicker("",
                      selection: Binding(
                        get:
                          {
                            let calendarConverter : Calendar = Calendar.current
                            var dateComponentsSelected : DateComponents = DateComponents()
                            dateComponentsSelected.year = self.iCustomYear
                            dateComponentsSelected.month = self.iCustomMonth
                            dateComponentsSelected.day = self.iCustomDay
                            let dResultDate : Date = calendarConverter.date(from: dateComponentsSelected) ?? Date()
                            return dResultDate
                          },
                        set: { dNewDate in
                          let calendarConverter : Calendar = Calendar.current
                          let dateComponentsExtracted : DateComponents = calendarConverter.dateComponents([.year, .month, .day], from: dNewDate)
                          
                          self.iCustomYear = dateComponentsExtracted.year ?? 2025
                          self.iCustomMonth = dateComponentsExtracted.month ?? 1
                          self.iCustomDay = dateComponentsExtracted.day ?? 1
                          
                          // Adjust time after date change
                          self.TimeAdjustAfterDateChange()
                        }
                      ),
                      in:
                      {
                        let dStartDate : Date = Date(timeIntervalSince1970: TimeInterval(self.vsSDK.report.record.t0))
                        let dEndDate : Date = Date(timeIntervalSince1970: TimeInterval(self.vsSDK.report.record.t1))
                        let rangeResult : ClosedRange<Date> = dStartDate...dEndDate
                        return rangeResult
                      }(),
                      displayedComponents: [.date])
              .datePickerStyle(CompactDatePickerStyle())
              .frame(width: 150, height: 30)
              .foregroundColor(.black)
            
            Spacer()
          }
            .frame(width: self.fTimeWidth)
        }
      }
      
      Spacer()
      
      // Time and Duration picker section
      HStack(spacing: 5)
      {
        Spacer()
        
        // Hour Picker section
        VStack(alignment: .center)
        {
          Text("Hour")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
            .frame(alignment: .leading)
          
          let rangeHourValid : ClosedRange<Int> = ValidHourRangeGet()
          
          Picker("Hour", selection: $iCustomHour)
          {
            ForEach(Array(rangeHourValid), id: \.self)
            { iHourCurrent in
              Text(String(format: "%02d", iHourCurrent))
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
            .frame(width: ((self.fTimeWidth - 45) / 4), height: 38)
            .onChange(of: iCustomHour)
            { _ in
              let rangeMinuteValid : ClosedRange<Int> = ValidMinuteRangeGet()
              let bIsMinuteInRange : Bool = rangeMinuteValid.contains(iCustomMin)
            
              if(bIsMinuteInRange == false)
              {
                iCustomMin = rangeMinuteValid.lowerBound
              }
            }
        }
        
        // Minute Picker section
        VStack(alignment: .center)
        {
          Text("Min")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
          
          let rangeMinuteValid : ClosedRange<Int> = ValidMinuteRangeGet()
          
          Picker("Minute", selection: $iCustomMin)
          {
            ForEach(Array(rangeMinuteValid), id: \.self)
            { iMinuteCurrent in
              Text(String(format: "%02d", iMinuteCurrent))
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
            .frame(width: ((self.fTimeWidth - 45) / 4), height: 38)
            .onChange(of: iCustomMin)
            { _ in
              let rangeSecondValid : ClosedRange<Int> = ValidSecondRangeGet()
              let bIsSecondInRange : Bool = rangeSecondValid.contains(iCustomSec)
            
              if(bIsSecondInRange == false)
              {
                iCustomSec = rangeSecondValid.lowerBound
              }
          }
        }
        
        // Second Picker section
        VStack(alignment: .center)
        {
          Text("Sec")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
          
          let rangeSecondValid : ClosedRange<Int> = ValidSecondRangeGet()
          
          Picker("Second", selection: $iCustomSec)
          {
            ForEach(Array(rangeSecondValid), id: \.self)
            { iSecondCurrent in
              Text(String(format: "%02d", iSecondCurrent))
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
            .frame(width: ((self.fTimeWidth - 45) / 4), height: 38)
        }
        
        // Time Range Picker section
        VStack(alignment: .center)
        {
          Text("Duration")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
          
          Picker("Range", selection: $iTimeRangeSelected)
          {
            ForEach(self.timeRangeOptionsArr, id: \.self)
            { iTimeOptionCurrent in
              Text("\(iTimeOptionCurrent)s")
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
            .frame(width: ((self.fTimeWidth - 45) / 4) + 5, height: 38)
        }
        
        Spacer()
      }
      
      Spacer()
      
      // Y Scale and Y Grid picker section
      HStack()
      {
        // Y Scale Selection section
        VStack(alignment: .center, spacing: 3)
        {
          Text("Y Scale (mm/mV)")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
          
          Picker("Y Scale", selection: $fYScaleSelected)
          {
            ForEach(self.fYScaleOptionsArr, id: \.self)
            { iYScaleOptionCurrent in
              Text(String(format: "%.0f mm", iYScaleOptionCurrent))
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
        }
          .frame(width: ((self.fTimeWidth - 60) / 2))
        
        Spacer()
          .frame(width: 10)
        
        // Y Scale Selection section
        VStack(alignment: .center, spacing: 3)
        {
          Text("Y Grid")
            .font(.custom(APP_FONT_NAME, size: fTitleFontSize))
            .foregroundColor(.gray)
          
          Picker("Y Grids", selection: $iYGridSelected)
          {
            ForEach(self.iYGridOptionsArr, id: \.self)
            { iYGridOptionCurrent in
              Text("\(iYGridOptionCurrent)")
                .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            }
          }
            .pickerStyle(MenuPickerStyle())
        }
          .frame(width: ((self.fTimeWidth - 60) / 2))
      }
      
      Spacer()
      
      // Preview button
      HStack()
      {
        Button(action: self.TimeControlApply)
        {
          Text("Preview")
            .font(.custom(APP_FONT_NAME, size: fValueFontSize))
            .fontWeight(.medium)
            .frame(width: self.fTimeWidth - 80, height: 38)
            .foregroundColor(.black)
            .background(Color(red: 224 / 255, green: 224 / 255, blue: 224 / 255))
            .cornerRadius(6)
        }
      }
      
      Spacer()
    }
    
    // Timer
    .onReceive(timer)
    { time in
      self.fSec = self.fSec + 0.2
      self.OnTimer()
    }
    
    // onAppear
    .onAppear()
    {
      self.OnAppear()
    }
  }
}

#Preview {
    ViewTimerSelect(
      onReturnSelectedUtc:{ update in
    })
}
