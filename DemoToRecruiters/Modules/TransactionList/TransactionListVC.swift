  //
  //  TransactionListViewController.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 26/01/2023.
  //

import UIKit
import SwiftUI

protocol TransactionListDisplayLogic: AnyObject
{
  func displayFetchedTransactions(viewModel: TransactionList.Transactions.ViewModel)
  func checkApiUrlSerssion(isCanceled:Bool)
  func presenApiNetworkError(message: String?)
}

class TransactionListVC: AppSuperVC, TransactionListDisplayLogic , NibInstantiatable
{
  var interactor: TransactionListBusinessLogic?
  var router: (NSObjectProtocol & TransactionListRoutingLogic & TransactionListDataPassing)?
  
    // MARK: Do something
  
  @IBOutlet weak var tableView: UITableView!
  
  let transparentView = UIView()
  var selectedButton = UIButton()
  var dataSource = [String]()
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
    
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    setGradientBackground()
    fetchTransactions()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    setGradientBackground()
  }
}

extension TransactionListVC{
    // MARK: Fetch Transactions
  
  func fetchTransactions()
  {
    let request = TransactionList.Transactions.Request()
    LoadingOverlay.shared.showOverlay(view: self.view)
    LoadingOverlay.shared.activityIndicator.startAnimating()
    self.tableView.isUserInteractionEnabled = false
    interactor?.fetchTransactions(request: request)
  }
    // MARK: Display Transactions
  
  func displayFetchedTransactions(viewModel: TransactionList.Transactions.ViewModel)
  {
    transactionList = viewModel.transactionsList?.items
    setCalculateSum(selectedCategory: "All Categories")
    if var route = self.router as? TransactionListRouter{
      route.dataStore?.itemList = viewModel.transactionsList?.items
      route.didTap = { [weak self] ( selectedCategory,filteredList, isTap) in
        if isTap {
          self?.transactionList = filteredList
        }else{
          self?.transactionList = filteredList
        }
        self?.setCalculateSum(selectedCategory: selectedCategory)
      }
    }
  }
  
  func setCalculateSum(selectedCategory: String)
  {
    DispatchQueue.main.asyncAfter(deadline: .now()){
      let totalAmount = self.transactionList?.reduce(0.0) { $0 + Double(($1.transactionDetail?.value?.amount  ?? 0)) }
      print(totalAmount)
      self.tableView.reloadData()
      self.navbarView?.setNavDoneButtonTitle(title: "\(totalAmount ?? 0)")
      self.navbarView?.rightSecondButton(image: "", title: "\(selectedCategory) \nTotal Amount")
      self.stopAnimating()
    }
  }
}

extension TransactionListVC {
  
  func stopAnimating(){
    if LoadingOverlay.shared.activityIndicator.isAnimating{
      LoadingOverlay.shared.activityIndicator.stopAnimating()
      LoadingOverlay.shared.hideOverlayView()
    }
    self.tableView.isHidden = false
    self.tableView.isUserInteractionEnabled = true
  }
  
  func checkApiUrlSerssion(){
    self.tableView.isUserInteractionEnabled = true
    interactor?.checkApiUrlSerssion()
  }
  
  func checkApiUrlSerssion(isCanceled: Bool)
  {
    self.tableView.isUserInteractionEnabled = false
    stopAnimating()
  }
  
  func presenApiNetworkError(message: String?)
  {
    DispatchQueue.main.async {
      self.stopAnimating()
      AlertHelper.showAlert("Alert",message: message!, style: .alert, actionTitles: ["FeedBack","Cancel"],autoDismiss : true ,  dismissDuration: 10 ,showCancel: false  ) { action in
        if action.title  == "FeedBack"{
          print(action.title)
          AlertHelper.feedBackController()
        }else{
          
        }
      }
    }
  }
}

extension TransactionListVC
{
  
  func setGradientBackground()
  {
    self.view.layer.cornerRadius = 25
    self.view.layer.masksToBounds = true
    self.view.layerGradient(startPoint: .centerRight, endPoint: .centerLeft, colorArray: [UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.first!).cgColor, UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.last!).cgColor], type: .axial)
  }
}

extension TransactionListVC : UITableViewDelegate{
  
  func tableViewinit()
  {
    tableView.register(UINib(nibName: TransactionPostCell.Identifier, bundle: nibBundle.self), forCellReuseIdentifier: TransactionPostCell.Identifier)
//    tableView.register(TransactionPostCell.self, forCellReuseIdentifier: TransactionPostCell.Identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

extension TransactionListVC
{
  func moveToItemDetails(item:Items?)
  {
    checkApiUrlSerssion()
    DispatchQueue.main.asyncAfter(deadline: .now())
    {  [weak self] in
      guard let self = self else{ return}
      if var route = self.router , let item = item
      {
        route.dataStore?.item = item
        route.routeToDetails()
      }
    }
  }
  
  func openFilterCategory()
  {
    checkApiUrlSerssion()
    DispatchQueue.main.asyncAfter(deadline: .now())
    {  [weak self] in
      if let strSelf = self , let route = strSelf.router as? TransactionListRouter
      {
        route.routeToSearchFilter()
        print("as? TransactionListRouter")
      }
    }
  }
}

extension TransactionListVC : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return transactionList?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
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


  // MARK: View Nav Actions

extension TransactionListVC {
  
  func navAction()
  {
    navTitle = "Transections List"
    self.navbarView?.setNavBackAction(isPushed:false, leftFirst: false, leftSecond: false, leftThird: true, title: false, rightFirst: true, rightSecond: false, rightThird: false , navTitle : navTitle)
    navbarView?.navBarAction = { [weak self] actiontype in
      guard let strSelf = self else { return }
      switch  ActionType(rawValue: actiontype.rawValue) {
      case .leftFirstButtonAction : print("profile leftFirstButtonAction")
        strSelf.openFilterCategory()
      case .leftSecondButtonAction:print("profile secondLeftButtonAction")
      case .rightThirdButtonAction:print("filter rightThirdButtonAction");
      default:print("No One")
      }
    }
  }
}
