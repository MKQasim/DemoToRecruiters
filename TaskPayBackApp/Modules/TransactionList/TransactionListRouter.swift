  //
  //  TransactionListRouter.swift
  //  TaskPayBackApp
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit
import SwiftUI

 @objc protocol TransactionListRoutingLogic
{
   func routeToDetails()
}

protocol TransactionListDataPassing
{
   var dataStore: TransactionListDataStore? { get set}
}

class TransactionListRouter: NSObject, TransactionListRoutingLogic, TransactionListDataPassing
{
  weak var viewController: TransactionListVC?
  var dataStore: TransactionListDataStore?
  
    // MARK: Routing
  
  func routeToDetails()
  {
    guard let  item = dataStore?.item else { return  }
    guard let viewController = self.viewController , let nav = viewController.navigationController else {return}
    if let destinationVC = DefaultScenesFactory().makeTransactionDetailsVC(viewModel: DefaultTransactionDetailsViewModel(transactionDetailsModel:item), navigationController: nav) as? TransactionItemDetailsVC {
      guard let destinationRouter = destinationVC.router else {return}
      guard var destinationDS = destinationRouter.dataStore else {return}
      guard let sourceDS = dataStore else {return}
      passDataToSomewhere(source: sourceDS , destination: &destinationDS)
      navigateToItemDetails(source: viewController, destination: destinationVC)
    }
  }
  
    // MARK: Navigation
  
  func navigateToItemDetails(source: TransactionListVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    source.show(destination, sender: self)
  }
  
    // MARK: Passing data
  
  func passDataToSomewhere(source: TransactionListDataStore, destination: inout TransactionItemDetailsDataStore)
  {guard let viewController = self.viewController else {return}
    destination.item = source.item
//    destination.navigation = viewController.navigationController
  }
}
