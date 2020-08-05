//
//  AppDelegate.swift
//  FlightApp
//
//  Created by João Palma on 30/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Sentry

fileprivate let _sentryDNS: String = "https://d3cace843c564cf993f7dd3e0803db9c@o155613.ingest.sentry.io/5374075"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _instantiateSentryService()
        return true
    }
    
    func _instantiateSentryService() {
        SentrySDK.start { options in
            options.dsn = _sentryDNS
            options.debug = true
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

