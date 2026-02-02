//
//  ViewAbout.swift
//  vsdemo
//
//

import SwiftUI

struct ViewAbout: View
{
  @ObservedObject var vsSDK : VsSDK = VsSDK.shared
  
  //--------------------------------------------------------------------------------------------------------//
  // iSecond
  //--------------------------------------------------------------------------------------------------------//
  @State var iSec : Int = 0

  //----------------------------------------------------------------//
  // Labels of dictionary
  //----------------------------------------------------------------//
  @State var strLabelBack  : String = ""

  //--------------------------------------------------------------------------------------------------------//
  // SCREEN_WIDTH
  //--------------------------------------------------------------------------------------------------------//
  let SCREEN_WIDTH_SMALL   : CGFloat    = 420
  let SCREEN_WIDTH_MIDDLE  : CGFloat    = 640
    
  //--------------------------------------------------------------------------------------------------------//
  // Background color
  //--------------------------------------------------------------------------------------------------------//
  @State var colorTitleBg : Color = Color(red: 242 / 256, green: 242 / 256, blue: 247 / 256)
  
  //--------------------------------------------------------------------------------------------------------//
  // width and height
  //--------------------------------------------------------------------------------------------------------//
  @State var fViewWidth  : CGFloat      = 420
  @State var fViewHeight : CGFloat      = 1024
  
  @State var fScreenWidth  : CGFloat    = 420
  @State var fScreenHeight : CGFloat    = 1024
  
  func OnBtnGoBackClicked()
  {
    // action
    self.vsSDK.iViewId = VIEW_ID_ENTRY
  }

  func UIUpdate()
  {
    //----------------------------------------------------------------//
    // Direct English strings
    //----------------------------------------------------------------//
    self.strLabelBack                 = "Back"
  }

  var body: some View
  {
    ZStack
    {
      Color.white
      VStack
      {
        //----------------------------------------------------------------//
        // Header
        //----------------------------------------------------------------//
        VStack(spacing: 1)
        {
          Spacer()
            .frame(height: 20)
          HStack
          {
            Spacer()
              .frame(width: 20)
            Button(action: self.OnBtnGoBackClicked)
            {
              Image("GO-LEFT")
                .resizable()
                .interpolation(.high)
                .antialiased(true)
                .frame(width: 20, height: 20)
              Text(self.strLabelBack)
                .font(.custom(APP_FONT_NAME, size: 18))
                .foregroundColor(Color(red: 143 / 255, green: 170 / 255, blue: 220 / 255))
            }
            Spacer()
          }
          Spacer()
            .frame(height: 20)
        }
          .frame(width: self.fViewWidth + 40, height: 60, alignment: .center)
          .background(self.colorTitleBg)
                
        Spacer()
        Image("BANNER")
          .resizable()
          .interpolation(.high)
          .antialiased(TRUE)
          .frame( width: 189, height: 65.3)
        Text("https://www.vsigntek.com")
          .font(.body)
          .padding()
          .foregroundColor(.gray)
          .frame(width: 400, height: 40)
        Text("Visit the website for more information")
          .font(.body)
          .padding()
          .foregroundColor(.gray)
          .frame(width: 400, height: 40)
 
        Spacer()
      }
    }
    .onAppear()
    {
      var fWidth: CGFloat  = UIScreen.main.bounds.width
      
      if(fWidth < SCREEN_WIDTH_SMALL)
      {
        fWidth = UIScreen.main.bounds.width
      }
      else if(fWidth > SCREEN_WIDTH_MIDDLE)
      {
        //let fWidth: CGFloat  = UIScreen.main.bounds.width - 70
        fWidth = 640
      }
                 
      self.fViewWidth  = fWidth - 40
      self.fViewHeight = 600

      UIUpdate()
    }
  }
}

struct AboutView_Previews: PreviewProvider
{
  static var previews: some View
  {
    ViewAbout()
  }
}
