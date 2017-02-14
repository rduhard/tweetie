//
//  User.swift
//  Tweetie
//

struct User {
    let username: String
    let firstname: String
    let lastname: String
    let verified: Bool
    
    var dictionaryDescription: [String: AnyObject] {
        return ["username":"\(username)" as AnyObject,"firstname":"\(firstname)" as AnyObject,"lastname":"\(lastname)" as AnyObject,"verified":verified as AnyObject]
    }
    
    init(username: String, firstname: String, lastname: String, verified: Bool) {
        self.username = username
        self.lastname = lastname
        self.firstname = firstname
        self.verified = verified
    }
    
    init(dictionary: [String: AnyObject]) {
        self.username = dictionary["username"] as! String
        self.lastname = dictionary["lastname"] as! String
        self.firstname = dictionary["firstname"] as! String
        self.verified = dictionary["verified"] as! Bool
    }
}
