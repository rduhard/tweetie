//
//  ComposeTweetPresenter.swift
//  Tweetie


import BrightFutures

protocol ComposeTweetPresenterInput {
  func presentTweetResponse(response: ComposeTweet.Response)
}

protocol ComposeTweetPresenterOutput: class {
  func displayTweetResponse(viewModel: ComposeTweet.ViewModel)
}

class ComposeTweetPresenter: ComposeTweetPresenterInput {
    weak var output: ComposeTweetPresenterOutput!
  
    func presentTweetResponse(response: ComposeTweet.Response) {
        Queue.main.async() {
            let viewModel = ComposeTweet.ViewModel(error: response.errorType.rawValue)
            self.output.displayTweetResponse(viewModel)
        }
    }
}
