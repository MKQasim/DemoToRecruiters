  //
  //  ScenesFactory.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 29/01/2023.
  //

import Foundation
import UIKit
import SwiftUI

protocol ScenesFactory {
  func makeUserDetailsVC(viewModel: DefaultUserDetailsViewModel,navigationController: UINavigationController) -> UIViewController
}

final class DefaultScenesFactory: ScenesFactory {
  func makeUserDetailsVC(viewModel: DefaultUserDetailsViewModel, navigationController: UINavigationController) -> UIViewController {
    DefaultUserItemDetailsConfigurator().configured(with: viewModel, navigationController: navigationController)
  }
}
