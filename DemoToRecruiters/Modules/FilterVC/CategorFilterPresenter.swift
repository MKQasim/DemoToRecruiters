//
//  CategorFilterPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 31/01/2023.
//

import UIKit

protocol CategorFilterPresentationLogic
{
  func presentSomething(response: CategorFilter.Category.Response)
}

class CategorFilterPresenter: CategorFilterPresentationLogic
{
  weak var viewController: CategorFilterDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CategorFilter.Category.Response)
  {
    let viewModel = CategorFilter.Category.ViewModel(itemList: response.itemList)
    viewController?.displaySomething(viewModel: viewModel)
  }
}
