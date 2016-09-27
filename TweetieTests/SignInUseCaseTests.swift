//
//  SignInUseCaseTests.swift
//  Tweetie


@testable import Tweetie
import XCTest

class SignInUseCaseTests: XCTestCase {

//    var usergateway: UserGateway!
    var sut: SignInUseCase!
    
    override func setUp() {
        super.setUp()
        
//        usergateway = UserGatewaySpy()
//        sut = SignInUseCase(gateway: usergateway)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_SignIn_AuthorizedUser_ShouldCallSaveUser() {
        let expectation = expectationWithDescription("Save User Called on Successful Sign In")
        
        let usergateway = UserGatewaySpy()
        sut = SignInUseCase(gateway: usergateway)
        
        sut.signIn("tweetieuser", password: "tweetie123") { error in
            expectation.fulfill()
            
        }
        
        waitForExpectation()
        XCTAssertTrue(usergateway.saveUserCalled)
    }
    
    
    func test_SignIn_UnauthorizedUser_ShouldNotCallSaveUser() {
        let expectation = expectationWithDescription("Save User not called on Unsuccessful Sign In")
        
        let usergateway = UserGatewaySpy()
        sut = SignInUseCase(gateway: usergateway)
        
        sut.signIn("wronguser", password: "wrongpassword") { error in
            expectation.fulfill()
            
        }
        
        waitForExpectation()
        XCTAssertFalse(usergateway.saveUserCalled)
    }
    
    func test_SignIn_UnuthorizedUser_ShouldReturnError() {
        let expectation = expectationWithDescription("Error returned on unsuccessful Sign In")
        
        let usergateway = UserGatewaySpy()
        sut = SignInUseCase(gateway: usergateway)
        var signInError: SignInError?
        
        sut.signIn("wronguser", password: "wrongpassword") { error in
            signInError = error
            expectation.fulfill()
        }
        
        waitForExpectation()
        XCTAssert(signInError == .InvalidCredentials)
    }

    private func waitForExpectation() {
        
        waitForExpectationsWithTimeout(3, handler: nil)
    }
}

class UserGatewaySpy: UserGateway {
    
    var saveUserCalled = false
    var removeCurrentUserCalled = true
    
    func saveUser(user: User) {
        saveUserCalled = true
        return
    }
    
    func fetchCurrentUser() -> User? { return nil }
    func removeCurrentUser() {
        removeCurrentUserCalled = true
    }
}