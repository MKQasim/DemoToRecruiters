//
//  TransactionListModels.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

enum TransactionList
{
  // MARK: Use cases
  
  enum Transactions
  {
    struct Request
    {
    }
    struct Response
    {
      let transactionsList: AppTransactionsList?
    }
    struct ViewModel
    {
      let transactionsList: AppTransactionsList?
    }
  }
}
