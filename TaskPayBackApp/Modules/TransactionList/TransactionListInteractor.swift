//
//  TransactionListInteractor.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

protocol TransactionListBusinessLogic
{
  func fetchTransactions(request: TransactionList.Transactions.Request)
}

protocol TransactionListDataStore
{
  //var name: String { get set }
}

class TransactionListInteractor: TransactionListBusinessLogic, TransactionListDataStore
{
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
        print(error.debugDescription)
      }
    })
    
    
    
  
  }
}
