//
//  UserListPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

protocol UserListPresentationLogic
{
  func presentFetchedUsers(response: UserList.Users.Response)
  func checkApiUrlSerssion(isCanceled: Bool)
  func presenApiNetworkError(message: String?)
  func presentNoIterneConnection(message: String?)
}

class UserListPresenter: UserListPresentationLogic
{
  
  let router = UserListRouter()
  weak var viewController: UserListDisplayLogic?
  
  // MARK: Do something
  
  func presentFetchedUsers(response: UserList.Users.Response)
  {
    guard let usersList = response.UsersList else { return  }
      let viewModel = UserList.Users.ViewModel(usersList: usersList)
      viewController?.displayFetchedUsers(viewModel: viewModel)
  }
  
  func presentNoIterneConnection(message: String?) {
    if let message = message?.components(separatedBy: "NetworkError(message: \"").last!.components(separatedBy: "\")").first {
      viewController?.presenApiNetworkError(message: message)
    }else{
      viewController?.presenApiNetworkError(message: "No Internet Connection")
    }
  }
  
  func checkApiUrlSerssion(isCanceled:Bool){
    viewController?.checkApiUrlSerssion(isCanceled: isCanceled)
  }
  
  func presenApiNetworkError(message: String?) {
    viewController?.presenApiNetworkError(message: message)
  }
  
}
