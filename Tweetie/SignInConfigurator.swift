//
//  SignInConfigurator.swift
//  Tweetie
//

import UIKit

extension SignInViewController: SignInPresenterOutput {}

extension SignInInteractor: SignInViewControllerOutput { }

extension SignInPresenter: SignInInteractorOutput { }

class SignInConfigurator
{
  
  class var sharedInstance: SignInConfigurator
  {
    struct Static {
      static var instance: SignInConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = SignInConfigurator()
    }
    
    return Static.instance!
  }
  
  func configure(viewController: SignInViewController)
  {
    
    let presenter = SignInPresenter()
    presenter.output = viewController
    
    let interactor = SignInInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
  }
}
