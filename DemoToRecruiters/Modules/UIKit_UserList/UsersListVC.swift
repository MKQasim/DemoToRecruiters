//
//  UsersListVC.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

import UIKit
import SwiftUI
import KQTaskNetworkManager
import Combine

protocol UserListDisplayLogic: AnyObject
{
    func displayFetchedUsers(viewModel: UserList.Users.ViewModel)
}

class UsersListVC: AppSuperVC, UserListDisplayLogic, NibInstantiatable {
    
    var interactor: UserListBusinessLogic?
    var router: (NSObjectProtocol & UserListRoutingLogic & UserListDataPassing)?

    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!

    let transparentView = UIView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var userList: [User]?
    private var cancellables: Set<AnyCancellable> = []
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let presenter = UserListPresenter()
        let interactor = UserListInteractor()
        let router = UserListRouter()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navAction()
        tableViewinit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        fetchUsers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGradientBackground()
        let image = Services.getResources()
        if let image = Services.getResources() {
            // TaskImageView.image = image
        }
        print(image)
    }

    // MARK: Fetch Users

    func fetchUsers() {
           let request = UserList.Users.Request()
           LoadingOverlay.shared.showOverlay(view: self.view)
           LoadingOverlay.shared.activityIndicator.startAnimating()
           self.tableView.isUserInteractionEnabled = false

           // Use Combine to handle the API call and errors
           interactor?.fetchUsers(request: request)
               .receive(on: DispatchQueue.main)
               .sink(receiveCompletion: { [weak self] completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       // Handle API network errors
                       self?.presenApiNetworkError(message: error.localizedDescription)
                   }
               }, receiveValue: { [weak self] response in
                   // Handle the fetched data
                   let vm = UserList.Users.ViewModel(usersList: AppUsersList(users: response ?? []))
                   self?.displayFetchedUsers(viewModel:vm)
                   self?.stopAnimating()
               })
               .store(in: &cancellables)
       }

    // MARK: Display Users

    func displayFetchedUsers(viewModel: UserList.Users.ViewModel) {
        userList = viewModel.usersList?.users
        updateRouterDataStore(with: viewModel.usersList?.users)
    }

    func checkApiUrlSerssion(isCanceled: Bool) {
        if isCanceled {
            // Handle the case when the API call was canceled
            print("API call was canceled")
            // Add your code to handle cancellation here
        } else {
            // Handle the case when the API call was not canceled
            print("API call was not canceled")
            // Add your code to handle the non-cancellation case here
        }
    }

    func presenApiNetworkError(message: String?) {
        if let errorMessage = message {
            // Handle the API network error with the provided message
            print("API network error: \(errorMessage)")
            // Add your code to handle the error here
        } else {
            // Handle the API network error without a specific message
            print("API network error occurred without a specific message")
            // Add your code to handle the error here
        }
    }
    
    func updateRouterDataStore(with itemList: [User]?) {
        if let route = self.router as? UserListRouter {
            route.dataStore?.userList = itemList
            self.updateUserList(userList, false)
            self.setCalculateSum(selectedCategory: "0")
            route.didTap = { [weak self] selectedCategory, filteredList, isTap in
                self?.updateUserList(filteredList, isTap)
                self?.setCalculateSum(selectedCategory: selectedCategory)
            }
        }
    }

    func updateUserList(_ filteredList: [User]?, _ isTap: Bool) {
        userList = filteredList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func setCalculateSum(selectedCategory: String) {
        DispatchQueue.main.async {
            let totalAmount = self.userList?.reduce(0.0) { $0 + Double($1.id ?? 0) } ?? 0
            print(totalAmount)
            self.tableView.reloadData()
            self.navbarView?.setNavDoneButtonTitle(title: "\(totalAmount)")
            self.navbarView?.rightSecondButton(image: "", title: "\(selectedCategory) \nTotal Amount")
            self.stopAnimating()
        }
    }

    // MARK: View Nav Actions

    func navAction() {
        navTitle = "Users List"
        self.navbarView?.setNavBackAction(isPushed: false, leftFirst: false, leftSecond: false, leftThird: true, title: false, rightFirst: true, rightSecond: false, rightThird: false, navTitle: navTitle)
        navbarView?.navBarAction = { [weak self] actionType in
            guard let strSelf = self else { return }
            switch ActionType(rawValue: actionType.rawValue) {
            case .leftFirstButtonAction:
                strSelf.openFilterCategory()
            case .leftSecondButtonAction:
                print("profile secondLeftButtonAction")
            case .rightThirdButtonAction:
                print("filter rightThirdButtonAction")
            default:
                print("No One")
            }
        }
    }
}

extension UsersListVC: UITableViewDelegate {

    func tableViewinit() {
        tableView.register(UINib(nibName: UserPostCell.Identifier, bundle: nibBundle.self), forCellReuseIdentifier: UserPostCell.Identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UsersListVC {

    func moveToItemDetails(item: User?) {
        self.checkApiUrlSession()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            if var route = self.router, let item = item {
                route.dataStore?.selectedUser = item
                route.routeToDetails()
            }
        }
    }

    func openFilterCategory() {
        self.checkApiUrlSession()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            if let strSelf = self, let route = strSelf.router as? UserListRouter {
                route.routeToSearchFilter()
            }
        }
    }
}

extension UsersListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserPostCell.Identifier) as! UserPostCell
        let user = userList?[indexPath.row]
        cell.configureCell(user: user)
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.didTapOpen = { [weak self] selectedUserItem in
            guard let router = self?.router, var dataStore = router.dataStore else { return }
            dataStore.selectedUser = selectedUserItem
            self?.moveToItemDetails(item: selectedUserItem)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = userList?[indexPath.row] else { return }
        moveToItemDetails(item: item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
}

extension UsersListVC {
    func stopAnimating() {
        if LoadingOverlay.shared.activityIndicator.isAnimating {
            LoadingOverlay.shared.activityIndicator.stopAnimating()
            LoadingOverlay.shared.hideOverlayView()
        }
        self.tableView.isHidden = false
        self.tableView.isUserInteractionEnabled = true
    }
    
    func checkApiUrlSession() {
        self.tableView.isUserInteractionEnabled = true
//        interactor?.checkApiUrlSession()
    }

}

extension UsersListVC {
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor] // Customize the gradient colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}


