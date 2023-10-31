//
//  UserListInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

protocol UserListBusinessLogic
{
  func fetchUsers(request: UserList.Users.Request)
  func checkApiUrlSerssion()
  
}

protocol UserListDataStore
{
  var item: User? {
    get set
  }
  
  var itemList: [User]? {
    get set
  }
  
  var filteredList: [User]? {
    get
    set
  }
}

extension UserListDataStore {
  
}

class UserListInteractor: UserListBusinessLogic, UserListDataStore
{
  var filteredList: [User]?
  var itemList: [User]?
  var item: User?
  var presenter: UserListPresentationLogic?
  var worker: UserListWorker?
  var userBusiness: UserBusinessProtocol?
  
  init(userBusiness: UserBusinessProtocol =  UserBusiness()) {
    self.userBusiness = userBusiness
  }
  // MARK: Do something
  
  func fetchUsers(request: UserList.Users.Request)
  {
    worker = UserListWorker()
    worker?.apiRequestValidation()
      userBusiness?.fetchUsers(parameters: ["": ""]) { [weak self] (usersList, error) in
          guard let self = self else { return }
          
          if let error = error {
              if let err = error as? Error {
                  if err._code == -1003 {
                      self.presenter?.presenApiNetworkError(message: error.localizedDescription)
                  } else {
                      self.presenter?.presentNoIterneConnection(message: "\(err)")
                  }
              } else {
                  self.presenter?.presenApiNetworkError(message: error.localizedDescription)
              }
          } else {
              guard let usersList = usersList else { return }
              let response = UserList.Users.Response(UsersList: usersList)
              self.presenter?.presentFetchedUsers(response: response)
          }
      }

  }
  
  func checkApiUrlSerssion(){
    self.userBusiness?.userStopApiCallStart(completion: { isCanceled in
      self.presenter?.checkApiUrlSerssion(isCanceled: isCanceled)
    })
  }
}
