//
//  TransactionItemDetailsModels.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

enum TransactionItemDetails
{
  // MARK: Use cases
  
  enum TransactionDetails
  {
    struct Request
    {
    }
    struct Response
    {
      var item: User
    }
    struct ViewModel
    {
      var item: User
    }
  }
}
