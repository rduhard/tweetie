//
//  TweetGateway.swift
//  Tweetie

protocol TweetGateway {
    func fetchAllTweets(completionHandler: ([Tweet], TweetsError) -> Void)
    func saveTweets(tweets: [Tweet])
    func saveTweet(tweet: Tweet)
    func clearData()
}