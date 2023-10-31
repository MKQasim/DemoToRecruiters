//
//  UserListPresenterTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class UserListPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: UserListPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupUserListPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupUserListPresenter()
  {
    sut = UserListPresenter()
  }
  
  // MARK: Test doubles
  
  class UserListDisplayLogicSpy: UserListDisplayLogic
  {
    
      // MARK: Method call expectations
    
    var displayFetchedUserCalled = false
    var urlSessionisValid = false
    var urlSessionInvalidated = false
    var presenApiNetworkError = false
      // MARK: Argument expectations
    
    var viewModel: UserList.Users.ViewModel!
    
      // MARK: Spied methods
    
    var displayFetchedUsersCalled = false
    func displayFetchedUsers(viewModel: DemoToRecruiters.UserList.Users.ViewModel) {
      displayFetchedUsersCalled = true
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
    let spy = UserListDisplayLogicSpy()
    sut.viewController = spy
    let UsersList = AppUsersList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let response = UserList.Users.Response(UsersList: UsersList)
    
    // When
    sut.presentFetchedUsers(response: response)
    
    // Then
    XCTAssertTrue(spy.displayFetchedUsersCalled, "presentFetchedUsers(response:) should ask the view controller to display the result")
  }
  
  func testPresentFetchedUsersShouldAskViewControllerToDisplayFetchedUsers()
  {
      // Given
    let UsersListDisplayLogicSpy = UserListDisplayLogicSpy()
    sut.viewController = UsersListDisplayLogicSpy
    
      // When
    let UsersList = AppUsersList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let response = UserList.Users.Response(UsersList: UsersList)
    
    sut.presentFetchedUsers(response: response)
    
      // Then
    XCTAssert(UsersListDisplayLogicSpy.displayFetchedUsersCalled, "Presenting fetched Users should ask view controller to display them")
  }
  
  func testValidateSuccessUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    let UsersListDisplayLogicSpy = UserListDisplayLogicSpy()
    sut.viewController = UsersListDisplayLogicSpy
    let isInvalidate = true
      // When
    
    sut.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertTrue(UsersListDisplayLogicSpy.urlSessionInvalidated, "Presenting fetched Users should ask view controller to check url Session Validation Success")
  }
  
  
  func testValidateErrorUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    let UsersListDisplayLogicSpy = UserListDisplayLogicSpy()
    sut.viewController = UsersListDisplayLogicSpy
    let isInvalidate = false
      // When
    sut.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertFalse(UsersListDisplayLogicSpy.urlSessionisValid, "Presenting fetched Users should ask view controller to check urlSession Validation Success")
  }
  
  
  func testshowApiNetworkError()
  {
      // Given
    let UsersListDisplayLogicSpy = UserListDisplayLogicSpy()
    sut.viewController = UsersListDisplayLogicSpy
    let message = "Error Message"
      // When
    sut.presenApiNetworkError(message: message)
      // Then
    XCTAssertFalse(UsersListDisplayLogicSpy.urlSessionisValid, "Show Error Message to ViewController")
  }
}
