  //
  //  ScenesFactory.swift
  //  TaskPayBackApp
  //
  //  Created by KamsQue on 29/01/2023.
  //

import Foundation
import UIKit
import SwiftUI

protocol ScenesFactory {
  func makeTransactionDetailsVC(viewModel: DefaultTransactionDetailsViewModel,navigationController: UINavigationController) -> UIViewController
}

final class DefaultScenesFactory: ScenesFactory {
  func makeTransactionDetailsVC(viewModel: DefaultTransactionDetailsViewModel, navigationController: UINavigationController) -> UIViewController {
    DefaultTransactionItemDetailsConfigurator().configured(with: viewModel, navigationController: navigationController)
  }
}
