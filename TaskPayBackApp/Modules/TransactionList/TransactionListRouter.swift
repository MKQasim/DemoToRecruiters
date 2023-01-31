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
  func routeToSearchFilter()
}

protocol TransactionListDataPassing
{
  var dataStore: TransactionListDataStore? { get set}
}

class TransactionListRouter: NSObject, TransactionListRoutingLogic, TransactionListDataPassing
{
  
  weak var viewController: TransactionListVC?
  var dataStore: TransactionListDataStore?
  var didTap:DismissCallbackWithString = {_,_,_  in }
    // MARK: Routing
  
  func routeToDetails()
  {
    guard let  item = dataStore?.item else { return  }
    guard let viewController = self.viewController , let nav = viewController.navigationController else {return}
    if let destinationVC = DefaultScenesFactory().makeTransactionDetailsVC(viewModel: DefaultTransactionDetailsViewModel(transactionDetailsModel:item), navigationController: nav) as? TransactionItemDetailsVC {
      guard let destinationRouter = destinationVC.router else {return}
      guard var destinationDS = destinationRouter.dataStore else {return}
      guard let sourceDS = dataStore else {return}
      passDataToTransactionDetails(source: sourceDS , destination: &destinationDS)
      navigateToItemDetails(source: viewController, destination: destinationVC)
    }
  }
  
  func routeToSearchFilter() {
    let destinationVC = CategorFilterVC()
    guard let viewController = self.viewController else{return}
    guard let destinationRouter = destinationVC.router else {return}
    guard let dest = destinationRouter as? CategorFilterRouter else { return  }
    dest.didTap = { [weak self] (selectedCategory,item, isTap) in
      print(selectedCategory,item?.count,isTap)
      self?.didTap(selectedCategory, item,  isTap)
    }
    guard var destinationDS = destinationRouter.dataStore else {return}
    guard let sourceDS = dataStore else {return}
    passDataToCategoryFilter(source: sourceDS , destination: &destinationDS)
    navigateToItemDetails(source: viewController, destination: destinationVC)
  }
  
    // MARK: Navigation
  
  func navigateToCategoryFilter(source: TransactionListVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    source.show(destination, sender: self)
  }
  
    // MARK: Navigation
  
  func navigateToItemDetails(source: TransactionListVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    source.showDetailViewController(destination, sender: self)
  }
  
    // MARK: Passing data
  func passDataToTransactionDetails(source: TransactionListDataStore, destination: inout TransactionItemDetailsDataStore)
  {
    destination.item = source.item
  }
    // MARK: Passing data
  func passDataToCategoryFilter(source: TransactionListDataStore, destination: inout CategorFilterDataStore)
  {
    destination.itemList = source.itemList
  }
}

