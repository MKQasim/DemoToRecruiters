//
//  UserBusiness.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation

protocol UserBusinessProtocol {
  func fetchUsers(parameters: [String : Any],completion:@escaping((_ UsersList:AppUsersList?,_ error:Error?) -> ()))
  func userStopApiCallStart(completion:@escaping((_ isCanceled : Bool) -> ()))
}

class UserBusiness: UserBusinessProtocol {
    // MARK: - User Services
  private lazy var userServices = UserServices()
    // MARK: - User Api Call
  
  func fetchUsers(parameters: [String : Any],completion:@escaping((_ UsersList:AppUsersList?,_ error:Error?) -> ())){
    userServices.fetchUsers(parameters:parameters) { UsersList, error in
      completion(UsersList,error)
    }
  }
  
  func userStopApiCallStart(completion:@escaping((_ isCanceled : Bool) -> ())){
    
    if userServices.urlSession != nil{
      userServices.urlSession?.invalidateAndCancel()
      completion(true)
    }else{
      completion(false)
    }
  }
}
