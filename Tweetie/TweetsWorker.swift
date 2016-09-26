//
//  RetrieveTweetsUseCase.swift
//  Tweetie


import Foundation
import BrightFutures
import SwiftyJSON

enum TweetsError: String {
    case NoError = ""
    case NotAuthorized = "You are not authorized"
    case NetworkError = "Unable to retrieve tweets due to a Network error. Please try again"
    case FetchError = "Unable to fetch local data, please try again"
    case UnknownError = "Unable to retrieve tweets due to an unknown error. Please try again"
}

class TweetsWorker {
    let gateway: TweetGateway
    
    
    init(gateway: TweetGateway) {
        self.gateway = gateway
    }

    func fetchLocalTweets(completionHandler: ([Tweet] -> Void)) {
        
        gateway.fetchAllTweets() { (localTweets, error) in
            completionHandler(localTweets)
        }
    }
    
    func syncRemoteTweets(completionHandler: (TweetsError -> Void)) {
        
        let newTweets = fetchNewTweets()
        NSUserDefaults.standardUserDefaults().setDouble(NSDate().timeIntervalSince1970, forKey: "lastFetchTime")
        //simulate network response time (2 seconds to make it noticable)
        Queue.global.after(.In(2)) {
            self.gateway.saveTweets(newTweets)
            completionHandler( .NoError)
        }
        
    }
    
    func sendTweet(tweet: Tweet, completionHandler: (TweetsError -> Void)) {
        //simulate network response time (1 second)
        Queue.global.after(.In(1)) {
            completionHandler(.NoError)
        }
    }
    
    func saveTweet(tweet: Tweet, completionHandler: (Void -> Void)) {
        completionHandler(gateway.saveTweet(tweet))
    }
    
    
    private func fetchNewTweets() -> [Tweet] {
        let lastFetchTime = NSUserDefaults.standardUserDefaults().doubleForKey("lastFetchTime")
        
        let mockRemoteTweetsFilePathOlder = NSBundle.mainBundle().pathForResource("tweetsRemote", ofType: "json")
        let mockRemoteTweetsFilePathNewer = NSBundle.mainBundle().pathForResource("tweetsRemote2", ofType: "json")
        
        guard lastFetchTime != 0 else {
            return loadMockRemoteData(mockRemoteTweetsFilePathOlder)
        }
        
        return loadMockRemoteData(mockRemoteTweetsFilePathNewer)
        
    }
    
    private func loadMockRemoteData(path: String?) -> [Tweet] {
        
        guard let path  = path else {
            return []
        }
        guard let jsonData = try? NSData(contentsOfFile: path, options: []) else {
            return []
        }
        
        return createTweetsFromData(jsonData)
        
    }
    
    private func createTweetsFromData(jsonData: NSData) -> [Tweet] {
        let json = JSON(data: jsonData)
        return tweetsFromDictionary(json)
    }
    
    private func tweetsFromDictionary(json: JSON) -> [Tweet] {
        var allTweets: [Tweet] = []
        for tweet in json.arrayValue {
            
            let tweeter = Tweeter(firstName: tweet["firstname"].stringValue, lastName: tweet["lastname"].stringValue, username: tweet["username"].stringValue)
            allTweets.append(Tweet(tweetId: tweet["guid"].stringValue, tweeter: tweeter, tweet: tweet["tweet"].stringValue, timestamp: tweet["timestamp"].doubleValue))
        }
        
        return allTweets.sort { $0.timestamp > $1.timestamp }
    }
}