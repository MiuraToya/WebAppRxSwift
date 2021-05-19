//
//  AppDelegate.swift
//  WebAppMVVM
//
//  Created by 三浦　登哉 on 2021/05/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: WebViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

