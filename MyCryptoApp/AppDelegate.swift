//
//  AppDelegate.swift
//  MyCryptoApp
//
//  Created by Apple on 31/07/21.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = CryptoRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }


}

