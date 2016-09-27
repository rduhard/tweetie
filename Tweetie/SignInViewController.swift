//
//  SignInViewController.swift
//  Tweetie

import UIKit

protocol SignInViewControllerInput
{
  func displaySignInResult(viewModel: SignIn.ViewModel)
}

protocol SignInViewControllerOutput
{
  func signIn(request: SignIn.Request)
}

class SignInViewController: UIViewController, SignInViewControllerInput
{
    var output: SignInViewControllerOutput!
  
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

  
    override func awakeFromNib() {
        super.awakeFromNib()
        SignInConfigurator.sharedInstance.configure(self)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    func displaySignInResult(viewModel: SignIn.ViewModel) {
    
        guard viewModel.error.isEmpty else {
            let alert = UIAlertController(title: "Oops", message: viewModel.error, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signInClicked(sender: AnyObject) {
        signIn()
    }
    
    private func signIn() {
        
        let request = SignIn.Request(username: usernameField.text ?? "", password: passwordField.text ?? "")
        output.signIn(request)
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            signIn()
        }
        
        return false
    }
}
