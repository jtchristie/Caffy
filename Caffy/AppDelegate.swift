//
//  AppDelegate.swift
//  Caffy
//c
//  Created by Jonathan Christie on 1/24/20.
//  Copyright © 2020 Jonathan Christie. All rights reserved.
//

import UIKit

import UIKit
import Firebase
import GooglePlaces
import GoogleSignIn



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    
    let newFont = UIFont(name: "GT Eesti Pro Text", size: 20.0)!
    let color = UIColor.white

    UITableView.appearance().backgroundColor = UIColor(red:0.44, green:0.49, blue:0.65, alpha:1.00)



    GMSPlacesClient.provideAPIKey("AIzaSyA1wdv2LE_mGvng6pl8lok7YeXdqAAs2Ls")
    
    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: newFont], for: .normal)
    
    return true
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




