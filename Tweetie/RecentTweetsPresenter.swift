//
//  RecentTweetsPresenter.swift
//  Tweetie

import BrightFutures

protocol RecentTweetsPresenterInput {
    func presentTweets(response: RecentTweets.Response)
    func presentSignOut(response: RecentTweets.SignOut.Response)
}

protocol RecentTweetsPresenterOutput: class {
    func displayTweets(viewModel: RecentTweets.ViewModel)
    func displayLogin()
    func signedOut()
}


class RecentTweetsPresenter: RecentTweetsPresenterInput {
    weak var output: RecentTweetsPresenterOutput!
    let dateFormatter: NSDateFormatter
    
    init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    }
    
    func presentTweets(response: RecentTweets.Response) {
        Queue.main.async {
            if response.error == .NotAuthorized {
                self.output.displayLogin()
            }
            let viewModel = RecentTweets.ViewModel(tweets: self.prepareTweetItems(response))
        
            self.output.displayTweets(viewModel)
        }
    }
    
    func presentSignOut(response: RecentTweets.SignOut.Response) {
        output.signedOut()
    }
    
    private func prepareTweetItems(response: RecentTweets.Response) -> [RecentTweets.ViewModel.ViewableTweetItem] {
        var items: [RecentTweets.ViewModel.ViewableTweetItem] = []
        for item in response.tweets {
            items.append(RecentTweets.ViewModel.ViewableTweetItem(name: "\(item.tweeter.firstName) \(item.tweeter.lastName)", username: item.tweeter.username, tweet: item.tweet, timestamp: formatTime(item.timestamp)))
        }
        return items
    }
    
    private func formatTime(timeInterval: NSTimeInterval) -> String {
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
}

