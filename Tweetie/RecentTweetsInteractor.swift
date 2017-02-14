//
//  RecentTweetsInteractor.swift
//  Tweetie

import BrightFutures

protocol RecentTweetsInteractorInput {
    func loadTweets(_ request: RecentTweets.Request)
    func refreshTweets(_ request: RecentTweets.Request)
    func signOut(_ request: RecentTweets.SignOut.Request)
}

protocol RecentTweetsInteractorOutput {
    func presentTweets(_ response: RecentTweets.Response)
    func presentSignOut(_ response: RecentTweets.SignOut.Response)
}


class RecentTweetsInteractor: RecentTweetsInteractorInput {
    var output: RecentTweetsInteractorOutput!
    var worker: TweetsWorker!
  
    func loadTweets(_ request: RecentTweets.Request) {
       
        guard authorizedUser() else {
            let response = RecentTweets.Response(tweets: [], error: .notAuthorized)
            self.output.presentTweets(response)
            return
        }
        
        DispatchQueue.global().async {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.fetchLocalTweets() { tweets in
                
                let response = RecentTweets.Response(tweets: tweets, error: .noError)
                self.output.presentTweets(response)
            }
        }

    }
        
    func refreshTweets(_ request: RecentTweets.Request) {
        
        guard authorizedUser() else {
            let response = RecentTweets.Response(tweets: [], error: .notAuthorized)
            self.output.presentTweets(response)
            return
        }
        
        DispatchQueue.global().async {
            
            self.worker = TweetsWorker(gateway: UserDefaultsTweetGateway())
            self.worker.syncRemoteTweets() { (error) in
                
                self.worker.fetchLocalTweets() { tweets in
                    let response = RecentTweets.Response(tweets: tweets, error: error)
                    self.output.presentTweets(response)
                }
                
            }
            
        }
    }
    
    func signOut(_ request: RecentTweets.SignOut.Request) {
        let signout = SignOutUseCase(usergateway: UserDefaultsUserGateway(), tweetGateway: UserDefaultsTweetGateway())
        signout.signOut()
        let response = RecentTweets.SignOut.Response()
        output.presentSignOut(response)
    }
    
    fileprivate func authorizedUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "userLoggedInKey")
    }
}
