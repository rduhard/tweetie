//
//  TweetsWorkerTests.swift
//  Tweetie

@testable import Tweetie
import XCTest

class TweetsWorkerTests: XCTestCase {
    
    var tweetGateway: TweetGateway?
    var sut: TweetsWorker?
    var tweet: Tweet!
    
    override func setUp() {
        super.setUp()
        tweetGateway = DummyTweetGateway()
        sut = TweetsWorker(gateway: tweetGateway!)
        tweet = Tweet(tweetId: "1", tweeter: Tweeter(firstName: "first", lastName: "last", username: "username"), tweet: "tweetText", timestamp: 1234.0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }

    func test_FetchLocalTweets_WhenNoTweets_ShouldReturnEmptyArray() {
        let expectation = expectationWithDescription("Fetch Empty Tweets")
        var localTweets: [Tweet] = []
        sut?.fetchLocalTweets() { tweets in
            localTweets = tweets
            expectation.fulfill()
        }
        
        waitForExpectation()
        XCTAssertEqual(localTweets.count, 0)
    }

    func test_SaveTweet_ShouldBeSaved() {
        
    }
    
    private func waitForExpectation() {
        waitForExpectationsWithTimeout(2, handler: nil)
    }

}

class DummyTweetGateway: TweetGateway {
    
    var tweets: [Tweet] = []
    
    func fetchAllTweets(completionHandler: ([Tweet], TweetsError) -> Void) {
        completionHandler([], .NoError)
    }
    
    func saveTweets(tweets: [Tweet]) {
    }
    
    func saveTweet(tweet: Tweet) {
        tweets.append(tweet)
    }
    
    func clearData() {
        
    }
}