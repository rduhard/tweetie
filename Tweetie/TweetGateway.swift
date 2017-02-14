//
//  TweetGateway.swift
//  Tweetie

protocol TweetGateway {
    func fetchAllTweets(_ completionHandler: ([Tweet], TweetsError) -> Void)
    func saveTweets(_ tweets: [Tweet])
    func saveTweet(_ tweet: Tweet)
    func clearData()
}
