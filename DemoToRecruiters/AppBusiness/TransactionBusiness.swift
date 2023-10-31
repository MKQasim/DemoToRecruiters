//
//  UserBusiness.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 27/01/2023.
//

import Foundation
import Combine


protocol UserBusinessProtocol {
    func fetchUsers(parameters: [String: Any]) -> AnyPublisher<AppUsersList, Error>
}

class UserBusiness: UserBusinessProtocol {
    private let userServices: UserServices
    private var cancellables: Set<AnyCancellable> = []
    
    init(userServices: UserServices = UserServices()) {
        self.userServices = userServices
    }

    func fetchUsers(parameters: [String: Any]) -> AnyPublisher<AppUsersList, Error> {
        return Future { promise in
            self.userServices.fetchUsers(parameters: parameters)
                .sink(
                    receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: { appUsersList in
                        promise(.success(appUsersList))
                    }
                )
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }
}
