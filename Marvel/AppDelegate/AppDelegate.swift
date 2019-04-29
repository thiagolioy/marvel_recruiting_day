//
//  AppDelegate.swift
//  Marvel
//
//  Created by Thiago Lioy on 14/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApperanceProxyHelper.customizeNavigationBar()
        window = UIWindow()
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

    func createRootViewController() -> UIViewController {
        let viewController = CharactersViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.barTintColor = ColorPalette.red
        navController.navigationBar.isTranslucent = false
        
        return navController
    }
}

