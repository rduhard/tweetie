//
//  AppDelegate.swift
//  Tweetie


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        guard userIsLoggedIn() else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let signInViewController = storyboard.instantiateViewControllerWithIdentifier("SignInViewController")
//            window?.makeKeyAndVisible()
//            window?.rootViewController?.presentViewController(signInViewController, animated: true, completion: nil)
//            return true
//        }
        
        return true
    }

    private func userIsLoggedIn() -> Bool {
        
        return NSUserDefaults.standardUserDefaults().valueForKey("userLoggedInKey")?.boolValue ?? false
    }
}

