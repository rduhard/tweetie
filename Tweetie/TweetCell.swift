//
//  TweetCell.swift
//  Tweetie


import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var tweet: UILabel!
    
}

extension TweetCell {
    
    func populate(tweetItem: RecentTweets.ViewModel.ViewableTweetItem) {
        name.text = tweetItem.name
        username.text = tweetItem.username
        tweet.text = tweetItem.tweet
        timestamp.text = tweetItem.timestamp
    }
}
