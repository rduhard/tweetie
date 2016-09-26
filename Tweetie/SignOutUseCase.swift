//
//  SignOutUseCase.swift
//  Tweetie

import Foundation

class SignOutUseCase {
    
    let userGateway: UserGateway!
    let tweetGateway: TweetGateway!
    
    init(usergateway: UserGateway, tweetGateway: TweetGateway) {
        self.userGateway = usergateway
        self.tweetGateway = tweetGateway
    }
    
    func signOut() {
        clearLocalData()
    }
    
    private func clearLocalData() {
        userGateway.removeCurrentUser()
        tweetGateway.clearData()
    }
    
}