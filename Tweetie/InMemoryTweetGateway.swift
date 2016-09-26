//
//  InMemoryTweetGateway.swift
//  Tweetie

import Foundation
import SwiftyJSON

class InMemoryTweetGateway: TweetGateway {
    var tweets: [Tweet] = []
    
    init() {
        loadTweets()
    }
    
    func fetchAllTweets() -> [Tweet] {
        return tweets.sort { $0.timestamp > $1.timestamp }
    }
    
    func fetchTweetById(tweetId: TweetID) -> Tweet? {
        return tweets.filter{ $0.tweetId == tweetId }.first
    }
    
    func saveTweet(tweet: Tweet) {
        tweets.append(tweet)
    }
    
    func saveTweets(tweets: [Tweet]) {
        self.tweets.appendContentsOf(tweets)
    }
    
    private func loadTweets() {
        
        guard let filePath  = NSBundle.mainBundle().pathForResource("tweets", ofType: "json") else {
            self.tweets = []
            return
        }
        guard let jsonData = try? NSData(contentsOfFile: filePath, options: []) else {
            self.tweets = []
            return
        }
        
        tweets = createTweetsFromData(jsonData)
        
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
