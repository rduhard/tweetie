//
//  ComposeTweetConfigurator.swift
//  Tweetie

import UIKit

extension ComposeTweetViewController: ComposeTweetPresenterOutput { }

extension ComposeTweetInteractor: ComposeTweetViewControllerOutput { }

extension ComposeTweetPresenter: ComposeTweetInteractorOutput { }

class ComposeTweetConfigurator
{
  
    class var sharedInstance: ComposeTweetConfigurator {
        struct Static {
            static var instance: ComposeTweetConfigurator?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = ComposeTweetConfigurator()
        }
    
        return Static.instance!
    }
    
    func configure(viewController: ComposeTweetViewController) {
    
        let presenter = ComposeTweetPresenter()
        presenter.output = viewController
    
        let interactor = ComposeTweetInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
      }
}
