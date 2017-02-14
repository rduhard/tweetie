//
//  SignOutUseCaseTests.swift
//  Tweetie
//

@testable import Tweetie
import XCTest

class SignOutUseCaseTests: XCTestCase {

    var sut: SignOutUseCase!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_SignOut_RemoveDataMethodsCalled() {
        let tweetGateway = TweetGatewaySpy()
        let userGateway = UserGatewaySpy()
        let sut = SignOutUseCase(usergateway: userGateway, tweetGateway: tweetGateway)
        
        sut.signOut()
        
        XCTAssertTrue(tweetGateway.clearDataCalled)
        XCTAssertTrue(userGateway.removeCurrentUserCalled)
    }

    
}

class TweetGatewaySpy: TweetGateway {
    
    var clearDataCalled = false
    
    func fetchAllTweets(_ completionHandler: ([Tweet], TweetsError) -> Void) {}
    func saveTweets(_ tweets: [Tweet]) {}
    func saveTweet(_ tweet: Tweet) {}
    func clearData() {
        clearDataCalled = true
    }
}
