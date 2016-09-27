//
//  RecentTweetsInteractor.swift
//  Tweetie

import BrightFutures

protocol RecentTweetsInteractorInput {
    func loadTweets(request: RecentTweets.Request)
    func refreshTweets(request: RecentTweets.Request)
    func signOut(request: RecentTweets.SignOut.Request)
}

protocol RecentTweetsInteractorOutput {
    func presentTweets(response: RecentTweets.Response)
    func presentSignOut(response: RecentTweets.SignOut.Response)
}


class RecentTweetsInteractor: RecentTweetsInteractorInput {
    var output: RecentTweetsInteractorOutput!
    var worker: TweetsWorker!
  
    func loadTweets(request: RecentTweets.Request) {
       
        guard authorizedUser() else {
            let response = RecentTweets.Response(tweets: [], error: .NotAuthorized)
            self.output.presentTweets(response)
            return
        }
        
        Queue.global.async() {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.fetchLocalTweets() { tweets in
                
                let response = RecentTweets.Response(tweets: tweets, error: .NoError)
                self.output.presentTweets(response)
            }
        }

    }
        
    func refreshTweets(request: RecentTweets.Request) {
        
        guard authorizedUser() else {
            let response = RecentTweets.Response(tweets: [], error: .NotAuthorized)
            self.output.presentTweets(response)
            return
        }
        
        Queue.global.async() {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.syncRemoteTweets() { (error) in
                
                self.worker.fetchLocalTweets() { tweets in
                    let response = RecentTweets.Response(tweets: tweets, error: error)
                    self.output.presentTweets(response)
                }
                
            }
            
        }
    }
    
    func signOut(request: RecentTweets.SignOut.Request) {
        let signout = SignOutUseCase(usergateway: UserDefaultsUserGateway(), tweetGateway: UserDefaultsTweetGateway())
        signout.signOut()
        let response = RecentTweets.SignOut.Response()
        output.presentSignOut(response)
    }
    
    private func authorizedUser() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("userLoggedInKey")
    }
}