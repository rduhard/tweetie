//
//  SignInPresenter.swift
//  Tweetie

import BrightFutures

protocol SignInPresenterInput {
  func presentSignInResponse(response: SignIn.Response)
}

protocol SignInPresenterOutput: class {
  func displaySignInResult(viewModel: SignIn.ViewModel)
}

class SignInPresenter: SignInPresenterInput {
    weak var output: SignInPresenterOutput!
  
    func presentSignInResponse(response: SignIn.Response) {
        let viewModel = SignIn.ViewModel(error: response.errorType.rawValue)
        Queue.main.async() {
            self.output.displaySignInResult(viewModel)
        }
    }
}
