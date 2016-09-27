//
//  TweetTests.swift
//  Tweetie


@testable import Tweetie
import XCTest

class TweetTests: XCTestCase {

    var sut: Tweet!
    var tweet: Tweet!
    var tweetDict: [String:String]!
    let tweeter = Tweeter(firstName: "first", lastName: "last", username: "username")
    
    override func setUp() {
        super.setUp()
        tweet = Tweet(tweetId: "1", tweeter: tweeter, tweet: "TweetText", timestamp: 1234)
        tweetDict = ["guid":"1", "firstname":"first", "lastname":"last", "username":"username", "tweet":"TweetText","timestamp":"1234.0"]
        sut = tweet
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TweetAsDictionary() {
        
        let tweetDictionary = sut.dictionaryRepresentation.debugDescription
        
        XCTAssertEqual(tweetDictionary, tweetDict.debugDescription)
    }
    
    func test_TweetAsJson() {
        
    }

}
