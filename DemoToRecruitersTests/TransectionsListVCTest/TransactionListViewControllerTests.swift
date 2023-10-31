//
//  UserListViewControllerTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class UserListViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: UserListVC!
  var window: UIWindow!
  var UserListBusinessLogicSpy = UserListBusinessLogicSpy()
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    window.rootViewController = UINavigationController(rootViewController: UserListVC())
    window.makeKeyAndVisible()
    setupUserListViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupUserListViewController()
  {
    sut = UserListVC()
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test BusinessLogic
  
  class UserListBusinessLogicSpy: UserListBusinessLogic
  {
      // MARK: Method call expectations
    
    var fetchUsersCalled = false
    var checkUrlSession = false
      // MARK: Spied methods
    
    func fetchUsers(request: DemoToRecruiters.UserList.Users.Request) {
      fetchUsersCalled = true
    }
    
    func checkApiUrlSerssion() {
      checkUrlSession  = true
    }
    
  }
  
  class TableViewSpy: UITableView
  {
      // MARK: Method call expectations
    
    var reloadDataCalled = false
    
      // MARK: Spied methods
    
    override func reloadData()
    {
      reloadDataCalled = true
    }
  }
  
    // MARK: - Tests
  
  func testShouldFetchUsersWhenViewWillAppear()
  {
      // Given
    sut.interactor = UserListBusinessLogicSpy
    loadView()
    
      // When
    sut.viewWillAppear(true)
    
      // Then
    XCTAssert(UserListBusinessLogicSpy.fetchUsersCalled, "Should fetch Users right after the view appears")
  }
  
  func testShouldDisplayFetchedUsers()
  {
      // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
      // When
    let UsersList = AppUsersList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let viewModel = UserList.Users.ViewModel(UsersList: UsersList)
    sut.displayFetchedUsers(viewModel: viewModel)
    
      // Then
    XCTAssertTrue(sut.UserList!.first!.partnerDisplayName == "qasim")
  }
  
  func testcheckApiUrlSerssionIfAnySessionIsThereToInvalidate()
  {
    sut.interactor = UserListBusinessLogicSpy
      // When
    UserListBusinessLogicSpy.checkApiUrlSerssion()
      // Then
    XCTAssertTrue(UserListBusinessLogicSpy.checkUrlSession, "checkApiUrlSerssion() should check Api UrlSerssion If AnySession Is There To Invalidate before Moving next Screen")
  }
  
  func testNumberOfSectionsInTableViewShouldAlwaysBeOne()
  {
      // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
    
      // When
    let numberOfSections = sut.tableView.numberOfSections
    
      // Then
    XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
  }
  
  func testNumberOfRowsInAnySectionShouldEqaulNumberOfUsersToDisplay()
  {
      // Given
    let tableView = sut.tableView
    let UserList = AppUsersList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let viewModel = UserList.Users.ViewModel(UsersList: UserList)

    
    sut.UserList = UserList.User
    
      // When
    let numberOfRows = sut.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0)
    
      // Then
    XCTAssertEqual(numberOfRows, UserList.User.count, "The number of table view rows should equal the number of Users to display")
  }

}
