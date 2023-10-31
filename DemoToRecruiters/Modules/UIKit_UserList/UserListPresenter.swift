//
//  UserListPresenter.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit
import Foundation
import Combine

protocol UserListPresentationLogic {
    func presentFetchedUsers(response: UserList.Users.Response)
}

class UserListPresenter: UserListPresentationLogic {
    weak var viewController: UserListDisplayLogic?

    private var cancellables = Set<AnyCancellable>()

    func presentFetchedUsers(response: UserList.Users.Response) {
        guard let usersList = response.usersList else { return }
        let viewModel = UserList.Users.ViewModel(usersList: usersList)
        viewController?.displayFetchedUsers(viewModel: viewModel)
    }

    func bindToViewModelPublisher(_ viewModelPublisher: AnyPublisher<UserList.Users.ViewModel, Never>) {
        viewModelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] viewModel in
                self?.viewController?.displayFetchedUsers(viewModel: viewModel)
            })
            .store(in: &cancellables)
    }
}



