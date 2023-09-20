//
//  NibExtension.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import UIKit

public protocol NibInstantiatable {
  
  static func nibName() -> String
  
}

extension NibInstantiatable {
  
  static func nibName() -> String {
    return String(describing: self)
  }
  
}

extension NibInstantiatable where Self: UIView {
  
  static func fromNib() -> Self {
    
    let bundle = Bundle(for: self)
    let nib = bundle.loadNibNamed(nibName(), owner: self, options: nil)
    
    return nib!.first as! Self
    
  }
  
}
