//
//  UserListWorkerTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class UserListWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: UserListWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupUserListWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupUserListWorker()
  {
    sut = UserListWorker()
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
