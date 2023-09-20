//
//  Value.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

enum Currency: String, Codable {
  case pbp = "PBP"
}
  // MARK: - Value
struct Value: Codable {
  var amount: Int?
  var currency: Currency?
}


