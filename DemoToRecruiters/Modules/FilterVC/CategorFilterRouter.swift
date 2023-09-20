//
//  CategorFilterRouter.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 31/01/2023.
//

import UIKit

@objc protocol CategorFilterRoutingLogic
{
  
  func routeToTransactionList()
}

protocol CategorFilterDataPassing
{
  var dataStore: CategorFilterDataStore? { get set }
}

class CategorFilterRouter: NSObject, CategorFilterRoutingLogic, CategorFilterDataPassing
{
  weak var viewController: CategorFilterVC?
  var dataStore: CategorFilterDataStore?
  var didTap:DismissCallbackWithString = {_,_,_  in }
  // MARK: Routing
  
  func routeToTransactionList() {
    let destinationVC = TransactionListVC()
    guard let viewController = self.viewController else{return}
    guard let destinationRouter = destinationVC.router else {return}
    guard var destinationDS = destinationRouter.dataStore else {return}
    guard let sourceDS = dataStore else {return}
    passDataToTransactionList(source: sourceDS , destination: &destinationDS)
    navigateToTransactionList(source: viewController, destination: destinationVC)
  }
  
    // MARK: Navigation
  
  func navigateToTransactionList(source: CategorFilterVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    dismissCall(source: source, tapIn: true)
  }
  
  func dismissCall(source: CategorFilterVC,tapIn:Bool){
    guard let sourceDS = dataStore else {return}
    source.dismiss(animated: true) { [weak self] in
      if tapIn {
        self?.didTap(sourceDS.selectedCategory ?? "",sourceDS.filterdItemList, true)
      }else{
        self?.didTap(sourceDS.selectedCategory ?? "",sourceDS.itemList, false)
      }
    }
  }
  
  // MARK: Passing data
  
  func passDataToTransactionList(source: CategorFilterDataStore, destination: inout TransactionListDataStore)
  {
    destination.filteredList = source.itemList
  }
}
