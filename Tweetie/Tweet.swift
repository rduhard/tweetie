//
//  Tweet.swift
//  Tweetie
//

import Foundation

typealias TweetID = String

struct Tweet {
    let tweetId: TweetID
    let tweeter: Tweeter
    let tweet: String
    let timestamp: Double
    
    var jsonRepresentation : String {
        return "{\"guid\":\"\(tweetId)\",\"firstname\":\"\(tweeter.firstName)\",\"lastname\":\"\(tweeter.lastName)\",\"username\":\"\(tweeter.username)\",\"tweet\":\"\(tweet)\",\"timestamp\":\"\(timestamp)\"}"
    }
    
    var dictionaryRepresentation: [String: String] {
        return ["guid":"\(tweetId)", "firstname":"\(tweeter.firstName)", "lastname":"\(tweeter.lastName)", "username":"\(tweeter.username)", "tweet":"\(tweet)","timestamp":"\(timestamp)"]
    }
}