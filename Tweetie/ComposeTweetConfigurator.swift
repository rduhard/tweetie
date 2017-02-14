//
//  ComposeTweetConfigurator.swift
//  Tweetie

import UIKit

extension ComposeTweetViewController: ComposeTweetPresenterOutput { }

extension ComposeTweetInteractor: ComposeTweetViewControllerOutput { }

extension ComposeTweetPresenter: ComposeTweetInteractorOutput { }

class ComposeTweetConfigurator
{
    static let sharedInstance = ComposeTweetConfigurator()
    
    private init() {}

    func configure(_ viewController: ComposeTweetViewController) {
    
        let presenter = ComposeTweetPresenter()
        presenter.output = viewController
    
        let interactor = ComposeTweetInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
      }
}
