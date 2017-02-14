//
//  UserDefaultsUserGateway.swift
//  Tweetie
//

import Foundation

class UserDefaultsUserGateway: UserGateway {
    
    func saveUser(_ user: User) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(user.dictionaryDescription, forKey: "loggedInUser")
        UserDefaults.standard.set(true, forKey: "userLoggedInKey")
        userDefaults.synchronize()

    }
    
    func fetchCurrentUser() -> User? {
        
        guard let userDictionary = UserDefaults.standard.dictionary(forKey: "loggedInUser") else {
            return nil
        }
        return User(dictionary: userDictionary as [String : AnyObject])
    }
    
    func removeCurrentUser() {
        UserDefaults.standard.set(false, forKey: "userLoggedInKey")

    }
}
