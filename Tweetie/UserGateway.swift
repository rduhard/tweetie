//
//  UserGateway.swift
//  Tweetie
//

protocol UserGateway {
    func saveUser(user: User)
    func fetchCurrentUser() -> User?
    func removeCurrentUser()
}