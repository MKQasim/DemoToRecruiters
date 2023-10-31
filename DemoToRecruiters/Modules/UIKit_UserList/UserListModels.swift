//
//  UserListModels.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

enum UserList
{
  // MARK: Use cases
  
  enum Users
  {
    struct Request
    {
    }
    struct Response
    {
      let UsersList: AppUsersList?
    }
    struct ViewModel
    {
      let usersList: AppUsersList?
    }
  }
}
