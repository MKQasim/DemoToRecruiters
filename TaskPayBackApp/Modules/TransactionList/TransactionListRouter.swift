//
//  TransactionListRouter.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

@objc protocol TransactionListRoutingLogic
{
  func moveToTransactionDetailsVC()
}

protocol TransactionListDataPassing
{
  var dataStore: TransactionListDataStore? { get }
}

class TransactionListRouter: NSObject, TransactionListRoutingLogic, TransactionListDataPassing
{
  weak var viewController: TransactionListVC?
  var dataStore: TransactionListDataStore?
  
  // MARK: Routing
  
  func moveToTransactionDetailsVC() {
    
  }

  // MARK: Navigation
  
  func navigateToSomewhere(source: TransactionListVC, destination: UIViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToSomewhere(source: TransactionListDataStore, destination: inout TransactionListDataStore)
  {
//    destination.name = source.name
  }
}
