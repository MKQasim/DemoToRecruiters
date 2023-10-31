//
//  CategorFilterRouter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 31/01/2023.
//

import UIKit

@objc protocol CategorFilterRoutingLogic
{
  
  func routeToUserList()
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
  
  func routeToUserList() {
    let destinationVC = UsersListVC()
    guard let viewController = self.viewController else{return}
    guard let destinationRouter = destinationVC.router else {return}
    guard var destinationDS = destinationRouter.dataStore else {return}
    guard let sourceDS = dataStore else {return}
    passDataToUserList(source: sourceDS , destination: &destinationDS)
    navigateToUserList(source: viewController, destination: destinationVC)
  }
  
    // MARK: Navigation
  
  func navigateToUserList(source: CategorFilterVC, destination: UIViewController)
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
  
  func passDataToUserList(source: CategorFilterDataStore, destination: inout UserListDataStore)
  {
      destination.filteredUserList = source.itemList
  }
}
