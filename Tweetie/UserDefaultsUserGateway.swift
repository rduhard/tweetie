//
//  UserDefaultsUserGateway.swift
//  Tweetie
//

import Foundation

class UserDefaultsUserGateway: UserGateway {
    
    func saveUser(user: User) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(user.dictionaryDescription, forKey: "loggedInUser")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userLoggedInKey")
        userDefaults.synchronize()

    }
    
    func fetchCurrentUser() -> User? {
        
        guard let userDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey("loggedInUser") else {
            return nil
        }
        return User(dictionary: userDictionary)
    }
    
    func removeCurrentUser() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "userLoggedInKey")

    }
}