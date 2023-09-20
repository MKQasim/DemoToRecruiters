//
//  Transaction.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

  // MARK: - Transaction
struct Items : Codable {
  var partnerDisplayName: String?
  var alias: Alias?
  var category: Int?
  var transactionDetail: TransactionDetail?
}

