//
//  TransactionService.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import KQTaskNetworkManager

class TransactionServices {

  var urlSession : URLSession?
    // MARK: - Post List

  func fetchTransactions(parameters: [String: Any], completion: @escaping (AppTransactionsList?, Error?) -> ()) {
      // api
    let api = TransactionApiHandler()
      // api loader
    urlSession = APILoader(apiRequest: api).urlSession
    let apiTaskLoader = APILoader(apiRequest: api)
    apiTaskLoader.loadAPIRequest(requestData: parameters) { (result) in
      switch result{
      case  .success(let transactionsList):
        completion(transactionsList,nil)
      case .failure(let error):
//        guard let error = error as? NetworkError else { return  }
//        print(error.localizedDescription)
        
        completion(nil,error)
      }
    }
  }

  func cancelAPiCall()-> Bool{
    urlSession?.invalidateAndCancel()
    return true
  }
}
