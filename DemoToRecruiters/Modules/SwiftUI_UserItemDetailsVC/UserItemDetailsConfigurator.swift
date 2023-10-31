//
//  UserItemDetailsConfigurator.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import Foundation
import UIKit

protocol UserItemDetailsConfigurator {
  func configured(with viewModel: DefaultUserDetailsViewModel,navigationController: UINavigationController) -> UserItemDetailsVC
}

final class DefaultUserItemDetailsConfigurator: UserItemDetailsConfigurator {
  func configured(with viewModel: DefaultUserDetailsViewModel, navigationController: UINavigationController) -> UserItemDetailsVC {
    return UserItemDetailsVC(model: viewModel, navigationController: navigationController)
  }
}
