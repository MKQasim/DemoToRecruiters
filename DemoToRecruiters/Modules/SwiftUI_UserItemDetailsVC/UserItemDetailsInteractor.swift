//
//  UserItemDetailsInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

protocol UserItemDetailsBusinessLogic
{
  func doSomething(request: UserItemDetails.UserDetails.Request)
}

protocol UserItemDetailsDataStore
{
  var item: User? { get set }
  var navigation : UINavigationController? {get set}
}

class UserItemDetailsInteractor: UserItemDetailsBusinessLogic, UserItemDetailsDataStore
{
  var navigation: UINavigationController?
  var item: User?
  var presenter: UserItemDetailsPresentationLogic?
  var worker: UserItemDetailsWorker?

  
  // MARK: Do something
  
  func doSomething(request: UserItemDetails.UserDetails.Request)
  {
    worker = UserItemDetailsWorker()
    worker?.doSomeWork()
    item = User(id: 00, name: "")
    let response = UserItemDetails.UserDetails.Response(item: item ?? User())
    presenter?.presentSomething(response: response)
  }
}
