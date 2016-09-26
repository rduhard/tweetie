//
//  TweetieService.swift
//  Tweetie

protocol TweetieService {
    func fetchNewTweets() -> [Tweet]
}