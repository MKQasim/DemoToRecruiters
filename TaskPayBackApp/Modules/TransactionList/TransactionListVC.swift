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

class TransactionListVC: AppSuperVC, TransactionListDisplayLogic , NibInstantiatable
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
    navAction()
    tableViewinit()
    fetchUsers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setGradientBackground()
  }
  
  func displayFetchedTransactions(viewModel: TransactionList.Transactions.ViewModel)
  {
    transactionList = viewModel.transactionsList?.items
    let sum = transactionList?.reduce(0) {$1.transactionDetail?.value?.amount ?? 0 }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: { [weak self] in
      self?.tableView.reloadData()
      self?.navbarView?.setNavDoneButtonTitle(title: "\(sum ?? 0)")
      self?.navbarView?.rightSecondButton(image: "", title: "Total Amount")
    })
  }
}

extension TransactionListVC {
  func setGradientBackground() {
    self.view.layer.cornerRadius = 25
    self.view.layer.masksToBounds = true
    self.view.layerGradient(startPoint: .centerRight, endPoint: .centerLeft, colorArray: [UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.first!).cgColor, UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.last!).cgColor], type: .axial)
  }
}

extension TransactionListVC : UITableViewDelegate{
  func tableViewinit() {
    tableView.register(UINib(nibName: TransactionPostCell.Identifier, bundle: nibBundle.self), forCellReuseIdentifier: TransactionPostCell.Identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension TransactionListVC {
  func moveToItemDetails(item:Items?) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {  [weak self] in
      guard let self = self else{ return}
      if var rout = self.router , let item = item {
        rout.dataStore?.item = item
        rout.routeToDetails()
      }
    }
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
    cell.contentView.backgroundColor = .clear
    cell.selectionStyle = .none
    cell.didTapOpen = { [weak self] selectedTransactionItem in
      guard let router = self?.router , var dataStore = router.dataStore else { return }
      dataStore.item = selectedTransactionItem
      self?.moveToItemDetails(item:selectedTransactionItem)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    guard let item = transactionList?[indexPath.row] else { return }
    moveToItemDetails(item: item)
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
    self.navbarView?.setNavBackAction(leftFirst: true, leftSecond: false, leftThird: true, title: false, rightFirst: true, rightSecond: false, rightThird: false , navTitle : navTitle)
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
