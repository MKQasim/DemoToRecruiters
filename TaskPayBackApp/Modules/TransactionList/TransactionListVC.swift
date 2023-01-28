  //
  //  TransactionListViewController.swift
  //  TaskPayBackApp
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit
import SwiftUI

protocol TransactionListDisplayLogic: AnyObject
{
  func displayFetchedTransactions(viewModel: TransactionList.Transactions.ViewModel)
}

class TransactionListVC: AppSuperVC, TransactionListDisplayLogic
{
  var interactor: TransactionListBusinessLogic?
  var router: (NSObjectProtocol & TransactionListRoutingLogic & TransactionListDataPassing)?
  
    // MARK: Do something
  
    @IBOutlet weak var tableView: UITableView!
  
  var transactionList : [Items]?
  
    // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
    // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let presenter = TransactionListPresenter()
    let interactor = TransactionListInteractor()
    let router = TransactionListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
    
//    let viewController = self
//    let presenter = KQHomePresenter()
//    let interactor = KQHomeInteractor(presenter: presenter)
//    let router = KQHomeRouter()
    viewController.interactor = interactor
    viewController.router = router
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
  }
  
    // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
    // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.view.backgroundColor = AppColor.TransactionListScreen.TransactionListBackGroundView().backGroundColor
    navAction()
    tableViewinit()
    fetchUsers()
  }
  
  func displayFetchedTransactions(viewModel: TransactionList.Transactions.ViewModel)
  {
    transactionList = viewModel.transactionsList?.items
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
      self.tableView.reloadData()
    })
  }
}

extension TransactionListVC : UITableViewDelegate{
  func tableViewinit() {
    tableView.register(UINib(nibName: TransactionPostCell.Identifier, bundle: nibBundle.self), forCellReuseIdentifier: TransactionPostCell.Identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension TransactionListVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return transactionList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: TransactionPostCell.Identifier) as! TransactionPostCell
      let transaction = transactionList?[indexPath.row]
      cell.configureCell(transaction:transaction)
      cell.didTapOpen = { [weak self] selectedUser in
//        self?.openUpdateProfileVC(user: selectedUser)
      }
      return cell
    }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    250.0
  }
  }

extension TransactionListVC{
  
  func fetchUsers()
  {
    let request = TransactionList.Transactions.Request()
    interactor?.fetchTransactions(request: request)
  }
}
  // MARK: View Nav Actions

extension TransactionListVC {
  
  func navAction()
  {
    navTitle = "Transections List"
    self.navbarView?.setNavBackAction(leftFirst: true, leftSecond: false, leftThird: true, title: false, rightFirst: true, rightSecond: true, rightThird: false , navTitle : navTitle)
    navbarView?.navBarAction = { actiontype in
      switch  ActionType(rawValue: actiontype.rawValue) {
      case .leftSecondButtonAction:print("profile secondLeftButtonAction")
      case .rightThirdButtonAction:print("filter rightThirdButtonAction");
      default:print("No One")
      }
      return self
    }
  }
}
