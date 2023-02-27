//
//  AppDelegate.swift
//  CoockS
//
//  Created by BigSynt on 04.08.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.showModalAuth()
            }
        }
        
        //requestDataManager()
        
        return true
    }
    
//    func requestDataManager() {
//        let presenter = MainMusicPresenter()
//        let mainMusicController = MainMusicController()
//        mainMusicController.presenter = presenter
//        presenter.view = mainMusicController
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = mainMusicController
//        window.makeKeyAndVisible()
//        self.window = window
//    }
    
    func showModalAuth() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let newVc = UINavigationController(rootViewController: AuthViewController())
        newVc.setNavigationBarHidden(true, animated: true)
        window.rootViewController = newVc
        window.makeKeyAndVisible()
        self.window = window
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let newVc = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
//        self.window?.rootViewController?.present(newVc, animated: true, completion: nil)
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

