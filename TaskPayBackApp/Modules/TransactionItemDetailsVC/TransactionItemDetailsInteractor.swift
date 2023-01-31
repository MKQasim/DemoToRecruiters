//
//  TransactionItemDetailsInteractor.swift
//  TaskPayBackApp
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
  var item: Items? { get set }
  var navigation : UINavigationController? {get set}
}

class TransactionItemDetailsInteractor: TransactionItemDetailsBusinessLogic, TransactionItemDetailsDataStore
{
  var navigation: UINavigationController?
  var item: Items?
  var presenter: TransactionItemDetailsPresentationLogic?
  var worker: TransactionItemDetailsWorker?

  
  // MARK: Do something
  
  func doSomething(request: TransactionItemDetails.TransactionDetails.Request)
  {
    worker = TransactionItemDetailsWorker()
    worker?.doSomeWork()
    item = Items(partnerDisplayName: "")
    let response = TransactionItemDetails.TransactionDetails.Response(item: item ?? Items())
    presenter?.presentSomething(response: response)
  }
}
