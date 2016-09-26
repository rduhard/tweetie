//
//  ComposeTweetModels.swift
//  Tweetie


struct ComposeTweet {
    
    struct Request {
        let tweetText: String
    }
    
    struct Response {
        let errorType: TweetsError
    }
    
    struct ViewModel {
        let error: String?
    }
}
