//
//  RetrieveTweetsUseCase.swift
//  Tweetie


import Foundation
import BrightFutures
import SwiftyJSON

enum TweetsError: String {
    case noError = ""
    case notAuthorized = "You are not authorized"
    case networkError = "Unable to retrieve tweets due to a Network error. Please try again"
    case fetchError = "Unable to fetch local data, please try again"
    case unknownError = "Unable to retrieve tweets due to an unknown error. Please try again"
}

class TweetsWorker {
    let gateway: TweetGateway
    
    
    init(gateway: TweetGateway) {
        self.gateway = gateway
    }

    func fetchLocalTweets(_ completionHandler: (([Tweet]) -> Void)) {
        
        gateway.fetchAllTweets() { (localTweets, error) in
            completionHandler(localTweets)
        }
    }
    
    func syncRemoteTweets(_ completionHandler: @escaping ((TweetsError) -> Void)) {
        
        let newTweets = fetchNewTweets()
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastFetchTime")
        //simulate network response time (2 seconds to make it noticable)
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.gateway.saveTweets(newTweets)
            completionHandler( .noError)
        }
        
    }
    
    func sendTweet(_ tweet: Tweet, completionHandler: @escaping ((TweetsError) -> Void)) {
        //simulate network response time (1 second)
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            completionHandler(.noError)
        }
    }
    
    func saveTweet(_ tweet: Tweet, completionHandler: ((Void) -> Void)) {
        completionHandler(gateway.saveTweet(tweet))
    }
    
    
    fileprivate func fetchNewTweets() -> [Tweet] {
        let lastFetchTime = UserDefaults.standard.double(forKey: "lastFetchTime")
        
        let mockRemoteTweetsFilePathOlder = Bundle.main.path(forResource: "tweetsRemote", ofType: "json")
        let mockRemoteTweetsFilePathNewer = Bundle.main.path(forResource: "tweetsRemote2", ofType: "json")
        
        guard lastFetchTime != 0 else {
            return loadMockRemoteData(mockRemoteTweetsFilePathOlder)
        }
        
        return loadMockRemoteData(mockRemoteTweetsFilePathNewer)
        
    }
    
    fileprivate func loadMockRemoteData(_ path: String?) -> [Tweet] {
        
        guard let path  = path else {
            return []
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: []) else {
            return []
        }
        
        return createTweetsFromData(jsonData)
        
    }
    
    fileprivate func createTweetsFromData(_ jsonData: Data) -> [Tweet] {
        let json = JSON(data: jsonData)
        return tweetsFromDictionary(json)
    }
    
    fileprivate func tweetsFromDictionary(_ json: JSON) -> [Tweet] {
        var allTweets: [Tweet] = []
        for tweet in json.arrayValue {
            
            let tweeter = Tweeter(firstName: tweet["firstname"].stringValue, lastName: tweet["lastname"].stringValue, username: tweet["username"].stringValue)
            allTweets.append(Tweet(tweetId: tweet["guid"].stringValue, tweeter: tweeter, tweet: tweet["tweet"].stringValue, timestamp: tweet["timestamp"].doubleValue))
        }
        
        return allTweets.sorted { $0.timestamp > $1.timestamp }
    }
}
