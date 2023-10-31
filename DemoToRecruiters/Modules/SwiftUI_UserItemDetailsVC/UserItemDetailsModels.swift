//
//  UserItemDetailsModels.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

enum UserItemDetails
{
  // MARK: Use cases
  
  enum UserDetails
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
