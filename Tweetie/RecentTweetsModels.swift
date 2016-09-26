//
//  RecentTweetsModels.swift
//  Tweetie


struct RecentTweets {
    struct Request { }
    struct Response {
        let tweets: [Tweet]
        let error: TweetsError
    }
    struct ViewModel {
        let tweets: [ViewableTweetItem]
        var tweetCount: Int {
            get {
                return tweets.count
            }
        }
        
        struct ViewableTweetItem {
            let name: String
            let username: String
            let tweet: String
            let timestamp: String
        }

    }
    
    struct SignOut {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}




