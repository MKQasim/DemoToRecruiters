//
//  UserService.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//


import Foundation
import Combine
import KQTaskNetworkManager

class UserServices {

    private var urlSession: URLSession?
    
    func fetchUsers(parameters: [String: Any]) -> AnyPublisher<AppUsersList, Error> {
        let api = UserApiHandler()
        urlSession = APILoader(apiRequest: api).urlSession

        return Future { promise in
            let apiTaskLoader = APILoader(apiRequest: api)
            apiTaskLoader.loadAPIRequest(requestData: parameters) { result in
                switch result {
                case .success(let usersList):
                    promise(.success(AppUsersList(users: usersList ?? [])))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

