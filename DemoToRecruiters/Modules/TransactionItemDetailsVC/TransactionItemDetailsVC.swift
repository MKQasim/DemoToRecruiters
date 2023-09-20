  //
  //  TransactionItemDetailsViewController.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 29/01/2023.
  //

import UIKit
import SwiftUI

protocol TransactionItemDetailsDisplayLogic: AnyObject
{
  func displaySomething(viewModel: TransactionItemDetails.TransactionDetails.ViewModel)
  var viewModel: TransactionItemDetailsViewModel? { get set }
  var router:  (NSObjectProtocol & TransactionItemDetailsRoutingLogic & TransactionItemDetailsDataPassing)? { get set }
}

typealias TransactionItemDetailsVCOutput = TransactionItemDetailsDisplayLogic

class TransactionItemDetailsVC: UIHostingController<TransactionDetailsView> {
  var viewModel : TransactionItemDetailsViewModel?
  var interactor: TransactionItemDetailsBusinessLogic?
  var router: (NSObjectProtocol & TransactionItemDetailsRoutingLogic & TransactionItemDetailsDataPassing)?
  
  
  init(model: DefaultTransactionDetailsViewModel,navigationController :  UINavigationController)
  {
    self.viewModel = model
    let detailsView = TransactionDetailsView(viewModel: model, navigationController :  navigationController)
    super.init(rootView: detailsView)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
  }
    // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = TransactionItemDetailsInteractor()
    let presenter = TransactionItemDetailsPresenter()
    let router = TransactionItemDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    router.viewController = viewController
    router.dataStore = interactor
    self.viewModel?.delegate = self
  }
}

extension TransactionItemDetailsVC: TransactionItemDetailsViewDelegate {
  func didSelectButton(_ sender: String) {
  }
}
