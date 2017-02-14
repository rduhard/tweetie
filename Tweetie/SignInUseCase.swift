//
//  SignInUseCase.swift
//  Tweetie

import Foundation

class SignInUseCase {
    
    let gateway: UserGateway!
    
    let validUsername = "tweetieuser"
    let validPassword = "tweetie123"
    
    lazy var fakeUser = User(username: "@tweetieuser", firstname: "Tweetie", lastname: "User", verified: true)
    
    init(gateway: UserGateway) {
        self.gateway = gateway
    }
    
    func signIn(_ username: String, password: String, completionHandler: @escaping ((SignInError) -> Void)) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            var signInError: SignInError = .noError
            guard let authorizedUser = self.authUser(username, password: password) else {
                signInError = .invalidCredentials
                completionHandler(signInError)
                return
            }
            
            self.gateway.saveUser(authorizedUser)
            completionHandler(signInError)
        }
    }
    
    fileprivate func authUser(_ username: String, password: String) -> User? {
        guard username == self.validUsername && password == self.validPassword else {
            return nil
        }
        //parse user information from authorization request and create User object, for now return fake user object
        return fakeUser
    }
    
}
