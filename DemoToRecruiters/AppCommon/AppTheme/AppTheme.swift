//
//  AppTheme.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//


import Foundation
import UIKit

enum UIUserInterfaceStyle: Int {
  case unspecified
  case light
  case dark
}


class AppTheme {
  
  static var shared = AppTheme()
  private init() {}
  
  let navTitleTextColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case .unspecified:return UIColor.systemGray
    case.dark: return AppColor.TransactionListScreen.NavBar.Dark.NavHeaderTitleText().textTitleColor
    case .light: return AppColor.TransactionListScreen.NavBar.Light.NavHeaderTitleText().textTitleColor
    default: return UIColor.systemGray
    }
  }
  
  let navTintColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case .unspecified:return UIColor.systemGray
    case.dark: return AppColor.TransactionListScreen.NavBar.Dark.NavTintColor().navTintColor
    case .light: return AppColor.TransactionListScreen.NavBar.Light.NavTintColor().navTintColor
    default: return UIColor.systemGray
    }
  }
  
  let navBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case .unspecified:return UIColor.systemGray
    case.dark: return AppColor.TransactionListScreen.NavBar.Dark.NavBackGroundView().backGroundColor.withAlphaComponent(1)
    case .light: return AppColor.TransactionListScreen.NavBar.Light.NavBackGroundView().backGroundColor
    default: return UIColor.systemGray
    }
  }
  
  let statusBarBackgroundColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case .unspecified:return UIColor.systemGray
    case.light: return AppColor.TransactionListScreen.NavBar.Light.NavBackGroundView().backGroundColor
    case .dark: return AppColor.TransactionListScreen.NavBar.Dark.NavBackGroundView().backGroundColor
    default: return UIColor.systemGray
    }
  }
}
