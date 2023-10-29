//
//  TransactionListViewControllerTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class TransactionListViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: TransactionListVC!
  var window: UIWindow!
  var transactionListBusinessLogicSpy = TransactionListBusinessLogicSpy()
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    window.rootViewController = UINavigationController(rootViewController: TransactionListVC())
    window.makeKeyAndVisible()
    setupTransactionListViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupTransactionListViewController()
  {
    sut = TransactionListVC()
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test BusinessLogic
  
  class TransactionListBusinessLogicSpy: TransactionListBusinessLogic
  {
      // MARK: Method call expectations
    
    var fetchTransactionsCalled = false
    var checkUrlSession = false
      // MARK: Spied methods
    
    func fetchTransactions(request: DemoToRecruiters.TransactionList.Transactions.Request) {
      fetchTransactionsCalled = true
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
  
  func testShouldFetchTransactionsWhenViewWillAppear()
  {
      // Given
    sut.interactor = transactionListBusinessLogicSpy
    loadView()
    
      // When
    sut.viewWillAppear(true)
    
      // Then
    XCTAssert(transactionListBusinessLogicSpy.fetchTransactionsCalled, "Should fetch Transactions right after the view appears")
  }
  
  func testShouldDisplayFetchedTransactions()
  {
      // Given
    let tableViewSpy = TableViewSpy()
    sut.tableView = tableViewSpy
      // When
    let transactionsList = AppTransactionsList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let viewModel = TransactionList.Transactions.ViewModel(transactionsList: transactionsList)
    sut.displayFetchedTransactions(viewModel: viewModel)
    
      // Then
    XCTAssertTrue(sut.transactionList!.first!.partnerDisplayName == "qasim")
  }
  
  func testcheckApiUrlSerssionIfAnySessionIsThereToInvalidate()
  {
    sut.interactor = transactionListBusinessLogicSpy
      // When
    transactionListBusinessLogicSpy.checkApiUrlSerssion()
      // Then
    XCTAssertTrue(transactionListBusinessLogicSpy.checkUrlSession, "checkApiUrlSerssion() should check Api UrlSerssion If AnySession Is There To Invalidate before Moving next Screen")
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
  
  func testNumberOfRowsInAnySectionShouldEqaulNumberOfTransactionsToDisplay()
  {
      // Given
    let tableView = sut.tableView
    let transactionList = AppTransactionsList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let viewModel = TransactionList.Transactions.ViewModel(transactionsList: transactionList)

    
    sut.transactionList = transactionList.User
    
      // When
    let numberOfRows = sut.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0)
    
      // Then
    XCTAssertEqual(numberOfRows, transactionList.User.count, "The number of table view rows should equal the number of Transactions to display")
  }

}
