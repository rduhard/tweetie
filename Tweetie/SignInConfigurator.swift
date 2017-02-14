//
//  SignInConfigurator.swift
//  Tweetie

import UIKit

extension SignInViewController: SignInPresenterOutput { }

extension SignInInteractor: SignInViewControllerOutput { }

extension SignInPresenter: SignInInteractorOutput { }

class SignInConfigurator {
    static let sharedInstance = SignInConfigurator()
    
    private init() {}

    func configure(_ viewController: SignInViewController) {
    
        let presenter = SignInPresenter()
        presenter.output = viewController
    
        let interactor = SignInInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
    }
}
