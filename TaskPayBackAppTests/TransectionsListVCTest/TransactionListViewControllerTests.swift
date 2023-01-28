//
//  TransactionListViewControllerTests.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

@testable import TaskPayBackApp
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
    var isFetchedTransectionCalled = false
    func fetchTransactions(request: TaskPayBackApp.TransactionList.Transactions.Request)
    {
      isFetchedTransectionCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldFetchedTransectionCallWhenViewIsLoaded()
  {
    // Given
    sut.interactor = transactionListBusinessLogicSpy
    // When
    loadView()
    // Then
    XCTAssertTrue(transactionListBusinessLogicSpy.isFetchedTransectionCalled, "loadView() should ask the interactor to Fetche Transections")
  }
  
  func testDisplaySomething()
  {
    // Given
    let viewModel = TransactionList.Transactions.ViewModel(transactionsList: <#AppTransactionsList?#>)
    
    // When
    loadView()
    sut.displayFetchedTransactions(viewModel: viewModel)
    
    // Then
//    XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
  }
}
