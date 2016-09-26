//
//  SignInModels.swift
//  Tweetie

enum SignInError: String {
    case NoError = ""
    case InvalidCredentials = "Invalid Credentials, please try again."
    case Unknown = "Unknown error signing in, please try again."
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

