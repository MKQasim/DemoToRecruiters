//
//  TransactionListInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

protocol TransactionListBusinessLogic
{
  func fetchTransactions(request: TransactionList.Transactions.Request)
  func checkApiUrlSerssion()
  
}

protocol TransactionListDataStore
{
  var item: Items? {
    get set
  }
  
  var itemList: [Items]? {
    get set
  }
  
  var filteredList: [Items]? {
    get
    set
  }
}

extension TransactionListDataStore {
  
}

class TransactionListInteractor: TransactionListBusinessLogic, TransactionListDataStore
{
  var filteredList: [Items]?
  var itemList: [Items]?
  var item: Items?
  var presenter: TransactionListPresentationLogic?
  var worker: TransactionListWorker?
  var transactionBusiness: TransactionBusinessProtocol?
  
  init(transactionBusiness: TransactionBusinessProtocol =  TransactionBusiness()) {
    self.transactionBusiness = transactionBusiness
  }
  // MARK: Do something
  
  func fetchTransactions(request: TransactionList.Transactions.Request)
  {
    worker = TransactionListWorker()
    worker?.apiRequestValidation()
    transactionBusiness?.fetchTransactions(parameters: ["":""], completion: { (transactionsList, error) in
      if error == nil {
        guard let transactionsList = transactionsList else { return  }
        let response = TransactionList.Transactions.Response(transactionsList: transactionsList)
        self.presenter?.presentFetchedTransactions(response: response)
      }else{
        if let err = error as? Error {
          if err._code == -1003 {
            self.presenter?.presenApiNetworkError(message: error?.localizedDescription)
          }else{
            self.presenter?.presentNoIterneConnection(message: "\(err)".description)
          }
        } else {
          self.presenter?.presenApiNetworkError(message: error?.localizedDescription)
        }
      }
    })
  }
  
  func checkApiUrlSerssion(){
    self.transactionBusiness?.transactionStopApiCallStart(completion: { isCanceled in
      self.presenter?.checkApiUrlSerssion(isCanceled: isCanceled)
    })
  }
}
