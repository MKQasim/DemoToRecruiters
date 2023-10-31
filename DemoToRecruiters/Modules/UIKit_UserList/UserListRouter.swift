  //
  //  UserListRouter.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit
import SwiftUI

@objc protocol UserListRoutingLogic
{
  func routeToDetails()
  func routeToSearchFilter()
}

protocol UserListDataPassing
{
  var dataStore: UserListDataStore? { get set}
}

class UserListRouter: NSObject, UserListRoutingLogic, UserListDataPassing
{
  
  weak var viewController: UsersListVC?
  var dataStore: UserListDataStore?
  var didTap:DismissCallbackWithString = {_,_,_  in }
    // MARK: Routing
  
  func routeToDetails()
  {
      guard let  item = dataStore?.selectedUser else { return  }
    guard let viewController = self.viewController , let nav = viewController.navigationController else {return}
    if let destinationVC = DefaultScenesFactory().makeUserDetailsVC(viewModel: DefaultUserDetailsViewModel(UserDetailsModel:item), navigationController: nav) as? UserItemDetailsVC {
      guard let destinationRouter = destinationVC.router else {return}
      guard var destinationDS = destinationRouter.dataStore else {return}
      guard let sourceDS = dataStore else {return}
      passDataToUserDetails(source: sourceDS , destination: &destinationDS)
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
  
  func navigateToCategoryFilter(source: UsersListVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    source.show(destination, sender: self)
  }
  
    // MARK: Navigation
  
  func navigateToItemDetails(source: UsersListVC, destination: UIViewController)
  {
    source.navigationController?.isNavigationBarHidden = true
    source.showDetailViewController(destination, sender: self)
  }
  
    // MARK: Passing data
  func passDataToUserDetails(source: UserListDataStore, destination: inout UserItemDetailsDataStore)
  {
      destination.item = source.selectedUser
  }
    // MARK: Passing data
  func passDataToCategoryFilter(source: UserListDataStore, destination: inout CategorFilterDataStore)
  {
      destination.itemList = source.userList
  }
}

