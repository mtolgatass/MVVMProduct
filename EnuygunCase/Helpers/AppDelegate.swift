//
//  AppDelegate.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let productListBuilder = ProductScreenBuilderImpl()
        let navigationController = UINavigationController(rootViewController: productListBuilder.build())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

