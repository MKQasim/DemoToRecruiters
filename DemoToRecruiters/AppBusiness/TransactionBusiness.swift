//
//  TransactionBusiness.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

protocol TransactionBusinessProtocol {
  func fetchTransactions(parameters: [String : Any],completion:@escaping((_ transactionsList:AppTransactionsList?,_ error:Error?) -> ()))
  func transactionStopApiCallStart(completion:@escaping((_ isCanceled : Bool) -> ()))
}

class TransactionBusiness: TransactionBusinessProtocol {
    // MARK: - Tansaction Services
  private lazy var transactionServices = TransactionServices()
    // MARK: - Transaction Api Call
  
  func fetchTransactions(parameters: [String : Any],completion:@escaping((_ transactionsList:AppTransactionsList?,_ error:Error?) -> ())){
    transactionServices.fetchTransactions(parameters:parameters) { transactionsList, error in
      completion(transactionsList,error)
    }
  }
  
  func transactionStopApiCallStart(completion:@escaping((_ isCanceled : Bool) -> ())){
    
    if transactionServices.urlSession != nil{
      transactionServices.urlSession?.invalidateAndCancel()
      completion(true)
    }else{
      completion(false)
    }
  }
}
