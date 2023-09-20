//
//  CategorFilterModels.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 31/01/2023.
//

import UIKit

enum CategorFilter
{
  // MARK: Use cases
  
  enum Category
  {
    struct Request
    {
    }
    struct Response
    {
      let itemList : [Items]
    }
    struct ViewModel
    {
      let itemList : [Items]
    }
  }
}
