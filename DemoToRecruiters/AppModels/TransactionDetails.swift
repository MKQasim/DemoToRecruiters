//
//  TransactionDetails.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

enum Description: String, Codable {
  case punkteSammeln = "Punkte sammeln"
}

  // MARK: - TransactionDetail
struct TransactionDetail: Codable {
  var description: Description?
  var bookingDate: Date?
  var value: Value?
}


