//
//  UIExtensions.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import UIKit

  // MARK: - Gradient

public enum CAGradientPoint {
  case topLeft
  case centerLeft
  case bottomLeft
  case topCenter
  case center
  case bottomCenter
  case topRight
  case centerRight
  case bottomRight
  var point: CGPoint {
    switch self {
    case .topLeft:
      return CGPoint(x: 0, y: 0)
    case .centerLeft:
      return CGPoint(x: 0, y: 0.5)
    case .bottomLeft:
      return CGPoint(x: 0, y: 1.0)
    case .topCenter:
      return CGPoint(x: 0.5, y: 0)
    case .center:
      return CGPoint(x: 0.5, y: 0.5)
    case .bottomCenter:
      return CGPoint(x: 0.5, y: 1.0)
    case .topRight:
      return CGPoint(x: 1.0, y: 0.0)
    case .centerRight:
      return CGPoint(x: 1.0, y: 0.5)
    case .bottomRight:
      return CGPoint(x: 1.0, y: 1.0)
    }
  }
}

extension CAGradientLayer {
  
  convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
    self.init()
    self.frame.origin = CGPoint.zero
    self.startPoint = start.point
    self.endPoint = end.point
    self.colors = colors
    self.locations = (0..<colors.count).map(NSNumber.init)
    self.type = type
  }
}

extension UIView {
  
  func layerGradient(startPoint:CAGradientPoint, endPoint:CAGradientPoint ,colorArray:[CGColor], type:CAGradientLayerType ) {
    let gradient = CAGradientLayer(start: .topCenter, end: .bottomCenter, colors: colorArray, type: type)
    gradient.frame.size = self.frame.size
    self.layer.insertSublayer(gradient, at: 0)
  }
}
