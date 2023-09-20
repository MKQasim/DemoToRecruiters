//
//  TableViewExtentions.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import UIKit

protocol IdentifiableKQ {
  static var Identifier: String {get}
}

extension UITableViewCell: IdentifiableKQ {
  static var Identifier: String { return String(describing: self)}
}

extension UICollectionViewCell: IdentifiableKQ {
  static var Identifier: String { return String(describing: self)}
}

extension UITableViewHeaderFooterView: IdentifiableKQ {
  static var Identifier: String { return String(describing: self)}
}


