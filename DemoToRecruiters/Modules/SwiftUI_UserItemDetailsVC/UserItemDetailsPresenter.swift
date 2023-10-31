//
//  UserItemDetailsPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

protocol UserItemDetailsPresentationLogic
{
  func presentSomething(response: UserItemDetails.UserDetails.Response)
}

class UserItemDetailsPresenter: UserItemDetailsPresentationLogic
{
  weak var viewController: UserItemDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: UserItemDetails.UserDetails.Response)
  {
    let viewModel = UserItemDetails.UserDetails.ViewModel(item: response.item)
    viewController?.displaySomething(viewModel: viewModel)
  }
}
