//
//  AppDelegate.swift
//  Tweetie


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    fileprivate func userIsLoggedIn() -> Bool {
        
        return (UserDefaults.standard.value(forKey: "userLoggedInKey") as AnyObject).boolValue ?? false
    }
}

