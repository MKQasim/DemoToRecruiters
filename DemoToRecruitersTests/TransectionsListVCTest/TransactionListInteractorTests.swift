//
//  UserListInteractorTests.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 26/01/2023.
//

@testable import DemoToRecruiters
import XCTest

class UserListInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: UserListInteractor!

  let presentationSpy = UserListPresentationLogicSpy()
  let UserBusiness = UserBusiness()
  let worker = UserListWorker()
  let UserBussinessLogicSpy = UserListBusinessLogicSpy()
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupUserListInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupUserListInteractor()
  {
    sut = UserListInteractor(UserBusiness: UserBusiness)
  }
  
  
    // MARK: Test doubles
  
  class UserListPresentationLogicSpy: UserListPresentationLogic {
    
    var Users : [User]?
    var presentFetchedUsersCalled = false
    var urlSessionisValid = false
    var urlSessionInvalidated = false
    var presenApiNetworkError = false
    var presentNoIterneConnection = false
    
    func presentFetchedUsers(response: DemoToRecruiters.UserList.Users.Response) {
      presentFetchedUsersCalled = true
      Users = response.UsersList?.User
      XCTAssertNotNil(response.UsersList)
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
  
  
  class UserListBusinessLogicSpy: UserListBusinessLogic {
    
    var Users : [User]?
    var fetchedUsersCalled = false
    var checkUrlSessionisCalled = false
    
    func fetchUsers(request: DemoToRecruiters.UserList.Users.Request) {
     fetchedUsersCalled = true
    }
  
    func checkApiUrlSerssion() {
      checkUrlSessionisCalled = true
    }
    
  }
    // MARK: Tests
  
  func testFetchUsersShouldAskToFetchUsers()
  {
      // Given
    let request = UserList.Users.Request()
      // When
    UserBussinessLogicSpy.fetchUsers(request: request)
    
      // Then
    XCTAssertTrue(UserBussinessLogicSpy.fetchedUsersCalled, "FetchUsers() should ask to fetch Users List")
  }
  
  func testcheckApiUrlSerssionIfAnySessionIsThereToInvalidate()
  {
    
      // When
    UserBussinessLogicSpy.checkApiUrlSerssion()
    
      // Then
    XCTAssertTrue(UserBussinessLogicSpy.checkUrlSessionisCalled, "checkApiUrlSerssion() should check Api UrlSerssion If AnySession Is There To Invalidate before Moving next Screen")
  }
  
  
  func testResultShouldFormatedByPresenter()
  {
      // Given
    sut.presenter = presentationSpy
    let UsersList = AppUsersList(User: [User(partnerDisplayName: "qasim",category: 9000)])
    let response = UserList.Users.Response(UsersList: UsersList)
      // When
    sut.presenter?.presentFetchedUsers(response: response)
      // Then
    XCTAssertEqual(presentationSpy.Users?.count == 1, true)
    XCTAssertTrue(presentationSpy.Users?.first?.partnerDisplayName == "qasim")
    XCTAssertTrue(presentationSpy.presentFetchedUsersCalled, "present Users should ask the presenter to format the result")
  }
  
  func testValidateSuccessUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    sut.presenter = presentationSpy
    let isInvalidate = true
      // When
    sut.presenter?.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertTrue(presentationSpy.urlSessionInvalidated, "Presenting fetched Users should ask view controller to check url Session Validation Success")
  }
  
  func testValidateErrorUrlSessionIfStartedBeforeMovingNextScreenDuringIfPaginationImplimented()
  {
      // Given
    sut.presenter = presentationSpy
    let isInvalidate = true
      // When
    sut.presenter?.checkApiUrlSerssion(isCanceled: isInvalidate)
      // Then
    XCTAssertFalse(presentationSpy.urlSessionisValid, "Presenting fetched Users should ask view controller to check urlSession Validation Success")
  }
}
