//
//  TransactionItemDetailsPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

protocol TransactionItemDetailsPresentationLogic
{
  func presentSomething(response: TransactionItemDetails.TransactionDetails.Response)
}

class TransactionItemDetailsPresenter: TransactionItemDetailsPresentationLogic
{
  weak var viewController: TransactionItemDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: TransactionItemDetails.TransactionDetails.Response)
  {
    let viewModel = TransactionItemDetails.TransactionDetails.ViewModel(item: response.item)
    viewController?.displaySomething(viewModel: viewModel)
  }
}
