//
//  ComposeTweetInteractor.swift
//  Tweetie

import BrightFutures

protocol ComposeTweetInteractorInput {
  func sendTweet(_ request: ComposeTweet.Request)
}

protocol ComposeTweetInteractorOutput {
  func presentTweetResponse(_ response: ComposeTweet.Response)
}


class ComposeTweetInteractor: ComposeTweetInteractorInput {
    var output: ComposeTweetInteractorOutput!
    var worker: TweetsWorker!
  
    func sendTweet(_ request: ComposeTweet.Request) {
    
        let tweet = tweetFromRequest(request)
        DispatchQueue.global().async {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.sendTweet(tweet) { error in
                guard error == .noError else {
                    let response = ComposeTweet.Response(errorType: error)
                    self.output.presentTweetResponse(response)
                    return
                }
                
                self.worker.saveTweet(tweet) {
                    let response = ComposeTweet.Response(errorType: .noError)
                    self.output.presentTweetResponse(response)
                }
            }
        }
    
    }
    
    fileprivate func tweetFromRequest(_ request: ComposeTweet.Request) -> Tweet {
        return Tweet(tweetId: NSUUID().uuidString, tweeter: currentTweeter(), tweet: request.tweetText, timestamp: NSDate().timeIntervalSince1970)
    }
    
    fileprivate func currentTweeter() -> Tweeter {
        let user = User(dictionary: UserDefaults.standard.object(forKey: "loggedInUser") as! Dictionary)
        return Tweeter(firstName: user.firstname, lastName: user.lastname, username: user.username)
    }
}
