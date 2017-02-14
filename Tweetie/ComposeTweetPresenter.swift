//
//  ComposeTweetPresenter.swift
//  Tweetie


import BrightFutures

protocol ComposeTweetPresenterInput {
  func presentTweetResponse(_ response: ComposeTweet.Response)
}

protocol ComposeTweetPresenterOutput: class {
  func displayTweetResponse(_ viewModel: ComposeTweet.ViewModel)
}

class ComposeTweetPresenter: ComposeTweetPresenterInput {
    weak var output: ComposeTweetPresenterOutput!
  
    func presentTweetResponse(_ response: ComposeTweet.Response) {
        DispatchQueue.main.async() {
            let viewModel = ComposeTweet.ViewModel(error: response.errorType.rawValue)
            self.output.displayTweetResponse(viewModel)
        }
    }
}
