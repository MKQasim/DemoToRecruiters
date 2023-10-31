  //
  //  UserItemDetailsViewController.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 29/01/2023.
  //

import UIKit
import SwiftUI

protocol UserItemDetailsDisplayLogic: AnyObject
{
  func displaySomething(viewModel: UserItemDetails.UserDetails.ViewModel)
  var viewModel: UserItemDetailsViewModel? { get set }
  var router:  (NSObjectProtocol & UserItemDetailsRoutingLogic & UserItemDetailsDataPassing)? { get set }
}

typealias UserItemDetailsVCOutput = UserItemDetailsDisplayLogic

class UserItemDetailsVC: UIHostingController<UserDetailsView> {
  var viewModel : UserItemDetailsViewModel?
  var interactor: UserItemDetailsBusinessLogic?
  var router: (NSObjectProtocol & UserItemDetailsRoutingLogic & UserItemDetailsDataPassing)?
  
  
  init(model: DefaultUserDetailsViewModel,navigationController :  UINavigationController)
  {
    self.viewModel = model
    let detailsView = UserDetailsView(viewModel: model, navigationController :  navigationController)
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
    let interactor = UserItemDetailsInteractor()
    let presenter = UserItemDetailsPresenter()
    let router = UserItemDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    router.viewController = viewController
    router.dataStore = interactor
    self.viewModel?.delegate = self
  }
}

extension UserItemDetailsVC: UserItemDetailsViewDelegate {
  func didSelectButton(_ sender: String) {
  }
}
