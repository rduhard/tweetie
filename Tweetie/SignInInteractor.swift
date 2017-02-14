//
//  SignInInteractor.swift
//  Tweetie
//

import BrightFutures

protocol SignInInteractorInput {
  func signIn(_ request: SignIn.Request)
}

protocol SignInInteractorOutput {
  func presentSignInResponse(_ response: SignIn.Response)
}

class SignInInteractor: SignInInteractorInput {
    
    var output: SignInInteractorOutput!
  
    func signIn(_ request: SignIn.Request) {
    
        DispatchQueue.global().async {
            
            let signInUC = SignInUseCase(gateway: UserDefaultsUserGateway())
            signInUC.signIn(request.username, password: request.password) { error in
                
                let response = SignIn.Response(errorType: error)
                self.output.presentSignInResponse(response)
            }
        }
    
    }
}
