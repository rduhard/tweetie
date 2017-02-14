//
//  SignInPresenter.swift
//  Tweetie

import BrightFutures

protocol SignInPresenterInput {
  func presentSignInResponse(_ response: SignIn.Response)
}

protocol SignInPresenterOutput: class {
  func displaySignInResult(_ viewModel: SignIn.ViewModel)
}

class SignInPresenter: SignInPresenterInput {
    weak var output: SignInPresenterOutput!
  
    func presentSignInResponse(_ response: SignIn.Response) {
        let viewModel = SignIn.ViewModel(error: response.errorType.rawValue)
        DispatchQueue.main.async() {
            self.output.displaySignInResult(viewModel)
        }
    }
}
