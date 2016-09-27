//
//  SignInUseCase.swift
//  Tweetie

import Foundation
import BrightFutures

class SignInUseCase {
    
    let gateway: UserGateway!
    
    let validUsername = "tweetieuser"
    let validPassword = "tweetie123"
    
    lazy var fakeUser = User(username: "@tweetieuser", firstname: "Tweetie", lastname: "User", verified: true)
    
    init(gateway: UserGateway) {
        self.gateway = gateway
    }
    
    func signIn(username: String, password: String, completionHandler: (SignInError -> Void)) {
        
        Queue.global.after(.In(1)) {
            var signInError: SignInError = .NoError
            guard let authorizedUser = self.authUser(username, password: password) else {
                signInError = .InvalidCredentials
                completionHandler(signInError)
                return
            }
            
            self.gateway.saveUser(authorizedUser)
            completionHandler(signInError)
        }
    }
    
    private func authUser(username: String, password: String) -> User? {
        guard username == self.validUsername && password == self.validPassword else {
            return nil
        }
        //parse user information from authorization request and create User object, for now return fake user object
        return fakeUser
    }
    
}