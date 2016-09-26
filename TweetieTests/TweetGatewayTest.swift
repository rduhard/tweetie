//
//  TweetGatewayTest.swift
//  Tweetie
//
//  Created by Rebecca Duhard on 9/25/16.
//  Copyright © 2016 Rebecca. All rights reserved.
//

@testable import Tweetie
import XCTest

class TweetGatewayTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setUpTweets()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        resetTweets()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
