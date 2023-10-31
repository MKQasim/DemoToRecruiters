  //
  //  AppColor.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import Foundation
import UIKit
import SwiftUI

class AppColor {
    // MARK: - UserListScreen UI
  struct UserListScreen
  {
    struct NavBar
    {
      struct Light
      {
        struct NavHeaderTitleText
        {
          var textTitleColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#ffffff")
            }
          }
        }
        
        struct NavTintColor
        {
          var navTintColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#6E8138")
            }
          }
        }
        
        struct NavBackGroundView
        {
          var backGroundColor:UIColor{
            get
            {
              return UIColor.init(hexString: "#343A3E")
            }
          }
          
          var shedowGroundColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#5E6E8138")
            }
          }
        }
      }
      
      struct Dark {
        struct NavHeaderTitleText
        {
          var textTitleColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#5E6E8138")
            }
          }
        }
        
        struct NavTintColor
        {
          var navTintColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#5E6E8138")
            }
          }
        }
        
        struct NavBackGroundView
        {
          var backGroundColor:UIColor{
            get
            {
              return UIColor.init(hexString: "#343A3E")
            }
          }
          
          var shedowGroundColor:UIColor
          {
            get
            {
              return UIColor.init(hexString: "#5E6E8138")
            }
          }
        }
      }
    }
    
    struct UserCell
    {
      var textTitleColor:UIColor{
        get
        {
          return UIColor.init(hexString: "#343A3E")
        }
      }
      
      var backGroundColor:UIColor
      {
        get
        {
          return UIColor.init(hexString: "#343A3E")
        }
      }
      
      var shedowGroundColor:UIColor
      {
        get
        {
          return UIColor.init(hexString: "#5E6E8138")
        }
      }
    }
    
    struct UserListBackGroundView
    {
      var backGroundColor:Color{
        get
        {
          return Color("pinkCircle")
        }
      }
      
      var shedowGroundColor:UIColor
      {
        get
        {
          return UIColor.init(hexString: "#5E6E8138")
        }
      }
    }
  }
  
  struct UserDetailsScreenColors {
    
    struct UserDetailsBackGroundView
    {
      var firstCircleColor:Color{
        get
        {
          return Color("greenCircle")
        }
      }
      
      var secondCircleColor:Color{
        get
        {
          return Color("pinkCircle")
        }
      }
      
      var backgroundGradiantColor:[Color]{
        get
        {
          return [Color("backgroundColor"),Color("backgroundColor2")]
        }
      }
    }
  }
}

extension UIColor {
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}
