//
//  UserGateway.swift
//  Tweetie
//

protocol UserGateway {
    func saveUser(_ user: User)
    func fetchCurrentUser() -> User?
    func removeCurrentUser()
}
