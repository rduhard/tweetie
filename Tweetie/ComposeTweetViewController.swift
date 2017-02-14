//
//  ComposeTweetViewController.swift
//  Tweetie


import UIKit

protocol ComposeTweetViewControllerInput {
    func displayTweetResponse(_ viewModel: ComposeTweet.ViewModel)
}

protocol ComposeTweetViewControllerOutput {
    func sendTweet(_ request: ComposeTweet.Request)
}


class ComposeTweetViewController: UIViewController {
    
    let maxTweetCharacterCount: Int = 140
    
    var output: ComposeTweetViewControllerOutput!
  
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tweetButton: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ComposeTweetConfigurator.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonClicked(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendTweetClicked(_ sender: AnyObject) {
        output.sendTweet(ComposeTweet.Request(tweetText: textView.text))
    }
  
    
}


extension ComposeTweetViewController: ComposeTweetViewControllerInput {
    func displayTweetResponse(_ viewModel: ComposeTweet.ViewModel) {
        guard viewModel.error?.isEmpty != nil else {
            displayTweetError(viewModel.error!)
            return
        }
        
        tweetSentSuccessfully()
    }
    
    fileprivate func tweetSentSuccessfully() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func displayTweetError(_ errorText: String) {
        let alert = UIAlertController(title: "Uh Oh!", message: errorText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


extension ComposeTweetViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count > 0 {
            tweetButton.isEnabled = true
        } else {
            tweetButton.isEnabled = false
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return isMaxCharacterCountReached(range, text: text)
    }
    
    fileprivate func isMaxCharacterCountReached(_ range: NSRange, text: String) -> Bool {
        
        let charCount = textView.text.characters.count
        if range.length + range.location > charCount {
            return false
        }
        
        let length = charCount + text.characters.count - range.length
        
        return length <= maxTweetCharacterCount

    }
}
