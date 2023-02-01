//
//  DispatchQueue.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 31/01/2023.
//

import Foundation


extension DispatchQueue {
  static func delay(_ delay: DispatchTimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
  }
}
