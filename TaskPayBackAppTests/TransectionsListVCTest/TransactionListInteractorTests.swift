//
//  TransactionListInteractorTests.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

@testable import TaskPayBackApp
import XCTest

class TransactionListInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: TransactionListInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupTransactionListInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupTransactionListInteractor()
  {
    sut = TransactionListInteractor()
  }
  
  // MARK: Test doubles
  
  class TransactionListPresentationLogicSpy: TransactionListPresentationLogic
  {
    var presentFetchedTransactionsCalled = false
    func presentFetchedTransactions(response: TaskPayBackApp.TransactionList.Transactions.Response) {
      presentFetchedTransactionsCalled = true
    }
  }
  
  // MARK: Tests
  
  func testfetchTransactions()
  {
    // Given
    let spy = TransactionListPresentationLogicSpy()
    sut.presenter = spy
    let request = TransactionList.Transactions.Request()
    
    // When
    sut.fetchTransactions(request: request)
    
    // Then
    XCTAssertTrue(spy.presentFetchedTransactionsCalled, "fetchTransactions(request:) should ask the presenter to format the result")
  }
}
