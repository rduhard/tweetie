//
//  RecentTweetsConfigurator.swift
//  Tweetie

import UIKit

extension RecentTweetsViewController: RecentTweetsPresenterOutput { }

extension RecentTweetsInteractor: RecentTweetsViewControllerOutput { }

extension RecentTweetsPresenter: RecentTweetsInteractorOutput { }

class RecentTweetsConfigurator {
  
    class var sharedInstance: RecentTweetsConfigurator {
        struct Static {
          static var instance: RecentTweetsConfigurator?
          static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
          Static.instance = RecentTweetsConfigurator()
        }
        
        return Static.instance!
      }
  
    func configure(viewController: RecentTweetsViewController) {
    
        let presenter = RecentTweetsPresenter()
        presenter.output = viewController
    
        let interactor = RecentTweetsInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
    }
}
