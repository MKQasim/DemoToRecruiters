//
//  TransactionItemDetailsInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import UIKit

protocol TransactionItemDetailsBusinessLogic
{
  func doSomething(request: TransactionItemDetails.TransactionDetails.Request)
}

protocol TransactionItemDetailsDataStore
{
  var item: User? { get set }
  var navigation : UINavigationController? {get set}
}

class TransactionItemDetailsInteractor: TransactionItemDetailsBusinessLogic, TransactionItemDetailsDataStore
{
  var navigation: UINavigationController?
  var item: User?
  var presenter: TransactionItemDetailsPresentationLogic?
  var worker: TransactionItemDetailsWorker?

  
  // MARK: Do something
  
  func doSomething(request: TransactionItemDetails.TransactionDetails.Request)
  {
    worker = TransactionItemDetailsWorker()
    worker?.doSomeWork()
    item = User(id: 00, name: "")
    let response = TransactionItemDetails.TransactionDetails.Response(item: item ?? User())
    presenter?.presentSomething(response: response)
  }
}
