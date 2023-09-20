//
//  ProgressLoaderView.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 31/01/2023.
//

import Foundation
import UIKit


public class LoadingOverlay{
  
  var overlayView = UIView()
  var activityIndicator = UIActivityIndicatorView()
  
  class var shared: LoadingOverlay {
    struct Static {
      static let instance: LoadingOverlay = LoadingOverlay()
    }
    return Static.instance
  }
  
  public func showOverlay(view: UIView) {
    
    overlayView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    overlayView.center = view.center
//    overlayView.backgroundColor = AppTheme.shared.navBackgroundColor
    overlayView.clipsToBounds = true
    overlayView.layer.cornerRadius = 10
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    activityIndicator.color = .white
    activityIndicator.style = .large
    activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
    setGradientBackground()
    overlayView.addSubview(activityIndicator)
    view.addSubview(overlayView)
    activityIndicator.startAnimating()
  }
  
  func setGradientBackground() {
    self.overlayView.layer.cornerRadius = 25
    self.overlayView.layer.masksToBounds = true
    self.overlayView.layerGradient(startPoint: .centerRight, endPoint: .centerLeft, colorArray: [UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.first!).cgColor, UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.last!).cgColor], type: .axial)
  }
  
  public func hideOverlayView() {
    activityIndicator.stopAnimating()
    overlayView.removeFromSuperview()
  }
}
