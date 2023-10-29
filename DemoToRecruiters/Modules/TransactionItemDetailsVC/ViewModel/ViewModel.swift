//
//  ViewModel.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import SwiftUI

protocol TransactionItemDetailsViewDelegate: AnyObject {
  func didSelectButton(_ sender: String)
}

protocol TransactionItemDetailsViewModel {
  var delegate: TransactionItemDetailsViewDelegate? { get set }
  var transactionDetailsModel : User? { get set}
}

final class DefaultTransactionDetailsViewModel : TransactionItemDetailsViewModel {
  
  var delegate: TransactionItemDetailsViewDelegate?
  var transactionDetailsModel: User?
  var text: String?
  var buttonText: String?
  
  internal init(delegate: TransactionItemDetailsViewDelegate? = nil, transactionDetailsModel: User? = nil, text: String? = nil, buttonText: String? = nil) {
    self.delegate = delegate
    self.transactionDetailsModel = transactionDetailsModel
    self.text = text
    self.buttonText = buttonText
  }
}
