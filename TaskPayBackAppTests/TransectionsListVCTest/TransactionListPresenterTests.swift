//
//  TransactionListPresenterTests.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

@testable import TaskPayBackApp
import XCTest

class TransactionListPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: TransactionListPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupTransactionListPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupTransactionListPresenter()
  {
    sut = TransactionListPresenter()
  }
  
  // MARK: Test doubles
  
  class TransactionListDisplayLogicSpy: TransactionListDisplayLogic
  {
    var displayFetchedTransactionsCalled = false
    func displayFetchedTransactions(viewModel: TaskPayBackApp.TransactionList.Transactions.ViewModel) {
      displayFetchedTransactionsCalled = true
    }
  }
  
  // MARK: Tests
  
  func testPresentSomething()
  {
    // Given
    let spy = TransactionListDisplayLogicSpy()
    sut.viewController = spy
    let response = TransactionList.Transactions.Response()
    
    // When
    sut.presentFetchedTransactions(response: response)
    
    // Then
    XCTAssertTrue(spy.displayFetchedTransactionsCalled, "presentFetchedTransactions(response:) should ask the view controller to display the result")
  }
}
