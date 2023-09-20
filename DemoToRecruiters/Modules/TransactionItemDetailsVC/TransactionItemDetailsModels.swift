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
      var item: Items
    }
    struct ViewModel
    {
      var item: Items
    }
  }
}
