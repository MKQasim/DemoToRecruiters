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
    
      // MARK: Method call expectations
    
    var displayFetchedTransactionCalled = false
    var urlSessionisValid = false
    var urlSessionInvalidated = false
    var presenApiNetworkError = false
      // MARK: Argument expectations
    
    var viewModel: TransactionList.Transactions.ViewModel!
    
      // MARK: Spied methods
    
    var displayFetchedTransactionsCalled = false
    func displayFetchedTransactions(viewModel: TaskPayBackApp.TransactionList.Transactions.ViewModel) {
      displayFetchedTransactionsCalled = true
      self.viewModel = viewModel
    }
    
    
    func checkApiUrlSerssion(isCanceled: Bool) {
      if isCanceled{
        urlSessionInvalidated = true
      }else{
        urlSessionisValid = false
      }
    }
    
    func presenApiNetworkError(message: String?) {
      presenApiNetworkError = true
    }
    
  }
  
  // MARK: Tests
  
  func testPresentSomething()
  {
    // Given
    let spy = TransactionListDisplayLogicSpy()
    sut.viewController = spy
    let transactionsList = AppTransactionsList(items: [Items(partnerDisplayName: "qasim",category: 9000)])
    let response = TransactionList.Transactions.Response(transactionsList: transactionsList)
    
    // When
    sut.presentFetchedTransactions(response: response)
    
    // Then
    XCTAssertTrue(spy.displayFetchedTransactionsCalled, "presentFetchedTransactions(response:) should ask the view controller to display the result")
  }
  
  func testPresentFetchedTransactionsShouldAskViewControllerToDisplayFetchedTransactions()
  {
      // Given
    let transactionsListDisplayLogicSpy = TransactionListDisplayLogicSpy()
    sut.viewController = transactionsListDisplayLogicSpy
    
      // When
    let transactionsList = AppTransactionsList(items: [Items(partnerDisplayName: "qasim",category: 9000)])
    let response = TransactionList.Transactions.Response(transactionsList: transactionsList)
    
    sut.presentFetchedTransactions(response: response)
    
      // Then
    XCTAssert(transactionsListDisplayLogicSpy.displayFetchedTransactionsCalled, "Presenting fetched Transactions should ask view controller to display them")
  }
  
  func testValidateSuccessUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    let transactionsListDisplayLogicSpy = TransactionListDisplayLogicSpy()
    sut.viewController = transactionsListDisplayLogicSpy
    let isInvalidate = true
      // When
    
    sut.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertTrue(transactionsListDisplayLogicSpy.urlSessionInvalidated, "Presenting fetched Transactions should ask view controller to check url Session Validation Success")
  }
  
  
  func testValidateErrorUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    let transactionsListDisplayLogicSpy = TransactionListDisplayLogicSpy()
    sut.viewController = transactionsListDisplayLogicSpy
    let isInvalidate = false
      // When
    sut.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertFalse(transactionsListDisplayLogicSpy.urlSessionisValid, "Presenting fetched Transactions should ask view controller to check urlSession Validation Success")
  }
  
  
  func testshowApiNetworkError()
  {
      // Given
    let transactionsListDisplayLogicSpy = TransactionListDisplayLogicSpy()
    sut.viewController = transactionsListDisplayLogicSpy
    let message = "Error Message"
      // When
    sut.presenApiNetworkError(message: message)
      // Then
    XCTAssertFalse(transactionsListDisplayLogicSpy.urlSessionisValid, "Show Error Message to ViewController")
  }
}
