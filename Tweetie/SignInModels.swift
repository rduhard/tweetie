//
//  SignInModels.swift
//  Tweetie

enum SignInError: String {
    case noError = ""
    case invalidCredentials = "Invalid Credentials, please try again."
    case unknown = "Unknown error signing in, please try again."
}

struct SignIn {
    struct Request {
        let username: String
        let password: String
    }
    
    struct Response {
        let errorType: SignInError
    }
    
    struct ViewModel {
        let error: String
    }
}

