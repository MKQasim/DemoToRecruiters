//
//  CategorFilterInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 31/01/2023.
//

import UIKit

protocol CategorFilterBusinessLogic
{
  func doSomething(request: CategorFilter.Category.Request)
}

protocol CategorFilterDataStore
{
  var item: Items? {
    get set
  }
  
  var itemList: [Items]? {
    get set
  }
  
  var filterdItemList: [Items]? {
    get set
  }
  
  var selectedCategory: String? {
    get set
  }
}

class CategorFilterInteractor: CategorFilterBusinessLogic, CategorFilterDataStore
{
  var selectedCategory: String?
  var filterdItemList: [Items]?
  var itemList: [Items]?
  var item: Items?
  var presenter: CategorFilterPresentationLogic?
  var worker: CategorFilterWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CategorFilter.Category.Request)
  {
    worker = CategorFilterWorker()
    worker?.doSomeWork()
    guard let itemList =  itemList else { return  }
    let response = CategorFilter.Category.Response(itemList: itemList)
    presenter?.presentSomething(response: response)
  }
}
