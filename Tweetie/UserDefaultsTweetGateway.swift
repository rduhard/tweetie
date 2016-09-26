//
//  UserDefaultsTweetGateway.swift
//  Tweetie
//

import Foundation
import SwiftyJSON

class UserDefaultsTweetGateway: TweetGateway {
    

    func fetchAllTweets(completionHandler: ([Tweet], TweetsError) -> Void) {
        completionHandler(loadTweetsFromUserDefaults(), .NoError)
    }
       
    func saveTweets(tweets: [Tweet]) {
        var storedTweets = loadTweetsFromUserDefaults()
        storedTweets.appendContentsOf(tweets)
        storeTweets(storedTweets)
    }
    
    func saveTweet(tweet: Tweet){
        saveTweets([tweet])
    }
 
    func clearData()  {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("tweets")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("lastFetchTime")
    }
}

extension UserDefaultsTweetGateway {
    
    private func loadTweetsFromUserDefaults() -> [Tweet] {
        let jsonString = NSUserDefaults.standardUserDefaults().objectForKey("tweets") as? String ?? ""
        
        guard let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) else {
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
    
    private func storeTweets(tweets: [Tweet]) {
        var jsonArray: [JSON] = []
        for tweet in tweets {
            jsonArray.append(JSON(tweet.dictionaryRepresentation))
        }
        let jsonString = jsonArray.description
        NSUserDefaults.standardUserDefaults().setObject(jsonString, forKey: "tweets")
    }
    

}