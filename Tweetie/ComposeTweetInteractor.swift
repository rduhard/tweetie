//
//  ComposeTweetInteractor.swift
//  Tweetie

import BrightFutures

protocol ComposeTweetInteractorInput {
  func sendTweet(request: ComposeTweet.Request)
}

protocol ComposeTweetInteractorOutput {
  func presentTweetResponse(response: ComposeTweet.Response)
}


class ComposeTweetInteractor: ComposeTweetInteractorInput {
    var output: ComposeTweetInteractorOutput!
    var worker: TweetsWorker!
  
    func sendTweet(request: ComposeTweet.Request) {
    
        let tweet = tweetFromRequest(request)
        Queue.global.async() {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.sendTweet(tweet) { error in
                guard error == .NoError else {
                    let response = ComposeTweet.Response(errorType: error)
                    self.output.presentTweetResponse(response)
                    return
                }
                
                self.worker.saveTweet(tweet) {
                    let response = ComposeTweet.Response(errorType: .NoError)
                    self.output.presentTweetResponse(response)
                }
            }
        }
    
    }
    
    private func tweetFromRequest(request: ComposeTweet.Request) -> Tweet {
        return Tweet(tweetId: NSUUID().UUIDString, tweeter: currentTweeter(), tweet: request.tweetText, timestamp: NSDate().timeIntervalSince1970)
    }
    
    private func currentTweeter() -> Tweeter {
        let user = User(dictionary: NSUserDefaults.standardUserDefaults().objectForKey("loggedInUser") as! Dictionary)
        return Tweeter(firstName: user.firstname, lastName: user.lastname, username: user.username)
    }
}
