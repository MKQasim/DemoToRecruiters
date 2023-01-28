//
//  TransactionListWorkerTests.swift
//  TaskPayBackApp
//
//  Created by KamsQue on 26/01/2023.
//

@testable import TaskPayBackApp
import XCTest

class TransactionListWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: TransactionListWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupTransactionListWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupTransactionListWorker()
  {
    sut = TransactionListWorker()
  }
  
  // MARK: Test doubles
  
  // MARK: Tests
  
  func testSomething()
  {
    // Given
    
    // When
    
    // Then
  }
}
