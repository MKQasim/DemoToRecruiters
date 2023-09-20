//
//  TransactionListPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit

protocol TransactionListPresentationLogic
{
  func presentFetchedTransactions(response: TransactionList.Transactions.Response)
  func checkApiUrlSerssion(isCanceled: Bool)
  func presenApiNetworkError(message: String?)
  func presentNoIterneConnection(message: String?)
}

class TransactionListPresenter: TransactionListPresentationLogic
{
  
  
  let router = TransactionListRouter()
  weak var viewController: TransactionListDisplayLogic?
  
  // MARK: Do something
  
  func presentFetchedTransactions(response: TransactionList.Transactions.Response)
  {
    guard let transactionsList = response.transactionsList else { return  }
    let viewModel = TransactionList.Transactions.ViewModel(transactionsList: transactionsList)
    viewController?.displayFetchedTransactions(viewModel: viewModel)
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
