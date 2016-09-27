//
//  AppDelegate.swift
//  Tweetie


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    private func userIsLoggedIn() -> Bool {
        
        return NSUserDefaults.standardUserDefaults().valueForKey("userLoggedInKey")?.boolValue ?? false
    }
}

