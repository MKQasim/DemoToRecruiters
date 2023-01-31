//
//  TransactionItemDetailsConfigurator.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 29/01/2023.
//

import Foundation
import UIKit

protocol TransactionItemDetailsConfigurator {
  func configured(with viewModel: DefaultTransactionDetailsViewModel,navigationController: UINavigationController) -> TransactionItemDetailsVC
}

final class DefaultTransactionItemDetailsConfigurator: TransactionItemDetailsConfigurator {
  func configured(with viewModel: DefaultTransactionDetailsViewModel, navigationController: UINavigationController) -> TransactionItemDetailsVC {
    return TransactionItemDetailsVC(model: viewModel, navigationController: navigationController)
  }
}
