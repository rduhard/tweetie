//
//  UserDefaultsTweetGateway.swift
//  Tweetie
//

import Foundation
import SwiftyJSON

class UserDefaultsTweetGateway: TweetGateway {
    

    func fetchAllTweets(_ completionHandler: ([Tweet], TweetsError) -> Void) {
        completionHandler(loadTweetsFromUserDefaults(), .noError)
    }
       
    func saveTweets(_ tweets: [Tweet]) {
        var storedTweets = loadTweetsFromUserDefaults()
        storedTweets.append(contentsOf: tweets)
        storeTweets(storedTweets)
    }
    
    func saveTweet(_ tweet: Tweet){
        saveTweets([tweet])
    }
 
    func clearData()  {
        UserDefaults.standard.removeObject(forKey: "tweets")
        UserDefaults.standard.removeObject(forKey: "lastFetchTime")
    }
}

extension UserDefaultsTweetGateway {
    
    fileprivate func loadTweetsFromUserDefaults() -> [Tweet] {
        let jsonString = UserDefaults.standard.object(forKey: "tweets") as? String ?? ""
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8) else {
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
    
    fileprivate func storeTweets(_ tweets: [Tweet]) {
        var jsonArray: [JSON] = []
        for tweet in tweets {
            jsonArray.append(JSON(tweet.dictionaryRepresentation))
        }
        let jsonString = jsonArray.description
        UserDefaults.standard.set(jsonString, forKey: "tweets")
    }
    

}
