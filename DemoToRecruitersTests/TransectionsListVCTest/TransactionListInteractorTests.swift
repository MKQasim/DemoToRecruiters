//
//  TransactionListInteractorTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class TransactionListInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: TransactionListInteractor!

  let presentationSpy = TransactionListPresentationLogicSpy()
  let transactionBusiness = TransactionBusiness()
  let worker = TransactionListWorker()
  let transactionBussinessLogicSpy = TransactionListBusinessLogicSpy()
  
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
    sut = TransactionListInteractor(transactionBusiness: transactionBusiness)
  }
  
  
    // MARK: Test doubles
  
  class TransactionListPresentationLogicSpy: TransactionListPresentationLogic {
    
    var transactions : [Items]?
    var presentFetchedtransactionsCalled = false
    var urlSessionisValid = false
    var urlSessionInvalidated = false
    var presenApiNetworkError = false
    var presentNoIterneConnection = false
    
    func presentFetchedTransactions(response: DemoToRecruiters.TransactionList.Transactions.Response) {
      presentFetchedtransactionsCalled = true
      transactions = response.transactionsList?.items
      XCTAssertNotNil(response.transactionsList)
    }
    
    func presentNoIterneConnection(message: String?) {
      presentNoIterneConnection = true
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
  
  
  class TransactionListBusinessLogicSpy: TransactionListBusinessLogic {
    
    var transactions : [Items]?
    var fetchedtransactionsCalled = false
    var checkUrlSessionisCalled = false
    
    func fetchTransactions(request: DemoToRecruiters.TransactionList.Transactions.Request) {
     fetchedtransactionsCalled = true
    }
  
    func checkApiUrlSerssion() {
      checkUrlSessionisCalled = true
    }
    
  }
    // MARK: Tests
  
  func testFetchTransactionsShouldAskToFetchTransactions()
  {
      // Given
    let request = TransactionList.Transactions.Request()
      // When
    transactionBussinessLogicSpy.fetchTransactions(request: request)
    
      // Then
    XCTAssertTrue(transactionBussinessLogicSpy.fetchedtransactionsCalled, "FetchTransactions() should ask to fetch Transactions List")
  }
  
  func testcheckApiUrlSerssionIfAnySessionIsThereToInvalidate()
  {
    
      // When
    transactionBussinessLogicSpy.checkApiUrlSerssion()
    
      // Then
    XCTAssertTrue(transactionBussinessLogicSpy.checkUrlSessionisCalled, "checkApiUrlSerssion() should check Api UrlSerssion If AnySession Is There To Invalidate before Moving next Screen")
  }
  
  
  func testResultShouldFormatedByPresenter()
  {
      // Given
    sut.presenter = presentationSpy
    let transactionsList = AppTransactionsList(items: [Items(partnerDisplayName: "qasim",category: 9000)])
    let response = TransactionList.Transactions.Response(transactionsList: transactionsList)
      // When
    sut.presenter?.presentFetchedTransactions(response: response)
      // Then
    XCTAssertEqual(presentationSpy.transactions?.count == 1, true)
    XCTAssertTrue(presentationSpy.transactions?.first?.partnerDisplayName == "qasim")
    XCTAssertTrue(presentationSpy.presentFetchedtransactionsCalled, "present Transactions should ask the presenter to format the result")
  }
  
  func testValidateSuccessUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    sut.presenter = presentationSpy
    let isInvalidate = true
      // When
    sut.presenter?.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertTrue(presentationSpy.urlSessionInvalidated, "Presenting fetched Transactions should ask view controller to check url Session Validation Success")
  }
  
  func testValidateErrorUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    sut.presenter = presentationSpy
    let isInvalidate = true
      // When
    sut.presenter?.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertFalse(presentationSpy.urlSessionisValid, "Presenting fetched Transactions should ask view controller to check urlSession Validation Success")
  }
}
