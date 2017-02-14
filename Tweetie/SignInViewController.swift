//
//  SignInViewController.swift
//  Tweetie

import UIKit

protocol SignInViewControllerInput
{
  func displaySignInResult(_ viewModel: SignIn.ViewModel)
}

protocol SignInViewControllerOutput
{
  func signIn(_ request: SignIn.Request)
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
  
    func displaySignInResult(_ viewModel: SignIn.ViewModel) {
    
        guard viewModel.error.isEmpty else {
            let alert = UIAlertController(title: "Oops", message: viewModel.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInClicked(_ sender: AnyObject) {
        signIn()
    }
    
    fileprivate func signIn() {
        
        let request = SignIn.Request(username: usernameField.text ?? "", password: passwordField.text ?? "")
        output.signIn(request)
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            signIn()
        }
        
        return false
    }
}
