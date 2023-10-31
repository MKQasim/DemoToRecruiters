//
//  UserListInteractor.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//
import UIKit
import Combine


protocol UserListBusinessLogic {
    func fetchUsers(request: UserList.Users.Request) -> AnyPublisher<[User]?, Error>
}

protocol UserListDataStore {
    var selectedUser: User? { get set }
    var userList: [User]? { get set }
    var filteredUserList: [User]? { get set }
}

class UserListInteractor: UserListBusinessLogic, UserListDataStore {
    var selectedUser: User?
    var userList: [User]?
    var filteredUserList: [User]?
    var presenter: UserListPresentationLogic?
    var worker: UserListWorker?
    var userBusiness: UserBusinessProtocol

    init(userBusiness: UserBusinessProtocol = UserBusiness()) {
        self.userBusiness = userBusiness
    }

    func fetchUsers(request: UserList.Users.Request) -> AnyPublisher<[User]?, Error> {
        worker = UserListWorker()
        worker?.apiRequestValidation()

        return userBusiness.fetchUsers(parameters: ["": ""])
            .map { appUsersList in
                return appUsersList.users
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
