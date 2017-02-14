//
//  UserTests.swift
//  Tweetie

@testable import Tweetie
import XCTest

class UserTests: XCTestCase {

    var user: User!
    var userDict: [String: AnyObject]!
    var sut: User!
    
    override func setUp() {
        super.setUp()
        
        user = User(username: "username", firstname: "firstname", lastname: "lastname", verified: true)
        userDict = ["username": "username" as AnyObject, "firstname": "firstname" as AnyObject, "lastname": "lastname" as AnyObject, "verified": true as AnyObject]
        sut = user
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_UserAsDictionary() {
        let userDictionary = sut.dictionaryDescription.debugDescription
        
        XCTAssertEqual(userDictionary, userDict.debugDescription)
    }


    
}
