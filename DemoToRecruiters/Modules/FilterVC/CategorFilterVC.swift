  //
  //  CategorFilterVC.swift
  //  DemoToRecruiters
  //
  //  Created by KamsQue on 31/01/2023.
  //

import UIKit
import SwiftUI

protocol CategorFilterDisplayLogic: AnyObject
{
  func displaySomething(viewModel: CategorFilter.Category.ViewModel)
}

class CategorFilterVC: AppSuperVC, CategorFilterDisplayLogic , NibInstantiatable
{
  var interactor: CategorFilterBusinessLogic?
  var router: (NSObjectProtocol & CategorFilterRoutingLogic & CategorFilterDataPassing)?
  let transparentView = UIView()
  @IBOutlet weak var tableView: UITableView!
  var dataSource = [Int]()
  var isTap = false
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
    let interactor = CategorFilterInteractor()
    let presenter = CategorFilterPresenter()
    let router = CategorFilterRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
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
    if let route = self.router , let itemList = route.dataStore?.itemList
    {
        dataSource = Set(itemList.map { $0.id ?? 0}).sorted()
    }
    tableViewinit()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    setGradientBackground()
    navAction()
  }
  
    // MARK: Do something
  
  func displaySomething(viewModel: CategorFilter.Category.ViewModel)
  {
    dataSource = Set(viewModel.itemList.map { $0.id ?? 0}).sorted()
    print(viewModel.itemList)
  }
}

extension CategorFilterVC
{
  func tableViewinit()
  {
    tableView.register(UINib(nibName: SeclectFilterCell.Identifier, bundle: nibBundle.self), forCellReuseIdentifier: SeclectFilterCell.Identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension CategorFilterVC: UITableViewDelegate, UITableViewDataSource
{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: SeclectFilterCell.Identifier, for: indexPath) as! SeclectFilterCell
    cell.configureCell(item:"\( dataSource[indexPath.row])")
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 80
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    if var route = self.router , let itemList = route.dataStore?.itemList
    {
      route.dataStore?.filterdItemList = itemList.filter(
        {
          $0.id == dataSource[indexPath.row];
        })
      isTap = true
      route.dataStore?.selectedCategory = "Category   \(dataSource[indexPath.row] ?? 0)"
      route.routeToTransactionList()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool)
  {
    super.viewWillDisappear(animated)
    dismissAction()
  }
  
  func dismissAction(){
    if let route = self.router as? CategorFilterRouter , !isTap{
      route.dataStore?.selectedCategory = "All Categories"
      route.dismissCall(source: self, tapIn: false)
    }
  }
}

extension CategorFilterVC
{
  func setGradientBackground()
  {
    self.view.layer.cornerRadius = 25
    self.view.layer.masksToBounds = true
    self.view.layerGradient(startPoint: .centerRight, endPoint: .centerLeft, colorArray: [UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.first!).cgColor, UIColor(AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor.last!).cgColor], type: .axial)
  }
}
extension CategorFilterVC {
  
  func navAction()
  {
    navTitle = "Select Category"
    self.navbarView?.setNavBackAction(isPushed:true, leftFirst: true, leftSecond: false, leftThird: true, title: false, rightFirst: true, rightSecond: false, rightThird: false , navTitle : navTitle)
    self.navbarView?.rightThirdButton(image: ImageFactory.NavBar.navBarSettings)
    self.navbarView?.rightSecondButton(image:ImageFactory.NavBar.cartCircle, title: "")
    navbarView?.navBarAction = { [weak self] actiontype in
      guard let strSelf = self else { return }
      switch  ActionType(rawValue: actiontype.rawValue) {
      case .leftFirstButtonAction : strSelf.dismissAction()
      case .rightSecondButtonAction: strSelf.addCartAlert()
      case .rightThirdButtonAction : strSelf.settingAlert()
      default:print("No One")
      }
    }
  }
  
  func settingAlert(){
    AlertHelper.showAlert("Setting",message: "Comming Soon", style: .alert, actionTitles: ["Thanks"],autoDismiss : true ,  dismissDuration: 10 ,showCancel: false  ) { action in
    
    }
  }
  
  func addCartAlert(){
    AlertHelper.showAlert("Add Cart",message: "Comming Soon", style: .alert, actionTitles: ["Thanks"],autoDismiss : true ,  dismissDuration: 10 ,showCancel: false  ) { action in
      
    }
  }
}



