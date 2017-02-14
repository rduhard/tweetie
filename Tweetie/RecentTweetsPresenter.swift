//
//  RecentTweetsPresenter.swift
//  Tweetie

import BrightFutures

protocol RecentTweetsPresenterInput {
    func presentTweets(_ response: RecentTweets.Response)
    func presentSignOut(_ response: RecentTweets.SignOut.Response)
}

protocol RecentTweetsPresenterOutput: class {
    func displayTweets(_ viewModel: RecentTweets.ViewModel)
    func displayLogin()
    func signedOut(_ viewModel: RecentTweets.ViewModel)
}


class RecentTweetsPresenter: RecentTweetsPresenterInput {
    weak var output: RecentTweetsPresenterOutput!
    let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
    }
    
    func presentTweets(_ response: RecentTweets.Response) {
        DispatchQueue.main.async {
            if response.error == .notAuthorized {
                self.output.displayLogin()
            }
            let viewModel = RecentTweets.ViewModel(tweets: self.prepareTweetItems(response))
        
            self.output.displayTweets(viewModel)
        }
    }
    
    func presentSignOut(_ response: RecentTweets.SignOut.Response) {
        let viewModel = RecentTweets.ViewModel(tweets: [])
        output.signedOut(viewModel)
    }
    
    fileprivate func prepareTweetItems(_ response: RecentTweets.Response) -> [RecentTweets.ViewModel.ViewableTweetItem] {
        var items: [RecentTweets.ViewModel.ViewableTweetItem] = []
        for item in response.tweets {
            items.append(RecentTweets.ViewModel.ViewableTweetItem(name: "\(item.tweeter.firstName) \(item.tweeter.lastName)", username: item.tweeter.username, tweet: item.tweet, timestamp: formatTime(item.timestamp)))
        }
        return items
    }
    
    fileprivate func formatTime(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

