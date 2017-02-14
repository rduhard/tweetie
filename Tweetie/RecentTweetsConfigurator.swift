//
//  RecentTweetsConfigurator.swift
//  Tweetie

import UIKit

extension RecentTweetsViewController: RecentTweetsPresenterOutput { }

extension RecentTweetsInteractor: RecentTweetsViewControllerOutput { }

extension RecentTweetsPresenter: RecentTweetsInteractorOutput { }

class RecentTweetsConfigurator {
  
    static let sharedInstance = RecentTweetsConfigurator()
    
    private init() {}

    func configure(_ viewController: RecentTweetsViewController) {
    
        let presenter = RecentTweetsPresenter()
        presenter.output = viewController
    
        let interactor = RecentTweetsInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
    }
}
