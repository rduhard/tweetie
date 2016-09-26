//
//  ComposeTweetViewController.swift
//  Tweetie


import UIKit

protocol ComposeTweetViewControllerInput {
    func displayTweetResponse(viewModel: ComposeTweet.ViewModel)
}

protocol ComposeTweetViewControllerOutput {
    func sendTweet(request: ComposeTweet.Request)
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
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendTweetClicked(sender: AnyObject) {
        output.sendTweet(ComposeTweet.Request(tweetText: textView.text))
    }
  
    
}


extension ComposeTweetViewController: ComposeTweetViewControllerInput {
    func displayTweetResponse(viewModel: ComposeTweet.ViewModel) {
        guard viewModel.error?.isEmpty != nil else {
            displayTweetError(viewModel.error!)
            return
        }
        
        tweetSentSuccessfully()
    }
    
    private func tweetSentSuccessfully() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func displayTweetError(errorText: String) {
        let alert = UIAlertController(title: "Uh Oh!", message: errorText, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}


extension ComposeTweetViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.characters.count > 0 {
            tweetButton.enabled = true
        } else {
            tweetButton.enabled = false
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return isMaxCharacterCountReached(range, text: text)
    }
    
    private func isMaxCharacterCountReached(range: NSRange, text: String) -> Bool {
        
        let charCount = textView.text.characters.count
        if range.length + range.location > charCount {
            return false
        }
        
        let length = charCount + text.characters.count - range.length
        
        return length <= maxTweetCharacterCount

    }
}
