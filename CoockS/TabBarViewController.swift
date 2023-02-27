//
//  TabBarViewController.swift
//  CoockS
//
//  Created by BigSynt on 10.09.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: URL's:
       
    let urlAddUser = "https://x8ki-letl-twmt.n7.xano.io/api:4ooykH8y/musicdataAddUser?UID="
    let urlGetMusic = "https://x8ki-letl-twmt.n7.xano.io/api:4ooykH8y/musicDataGet?UID="
    let urlAddLoveMusic = ""

    //var UID: String = ""
    var UID = ""//AuthViewController().UID
    
    let musicNote = UIImage(named: "music.note")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "new"
    }
    
    func getData(data: String) {
        self.UID = data
        let musicLoveVC = msuciLoveVCConfig()
        setViewControllers([musicLoveVC], animated: false)
    }
    
    private func msuciLoveVCConfig() -> UINavigationController {
        let presenter = MainMusicPresenter()
        let mainMusicController = MainMusicController()
        mainMusicController.presenter = presenter
        presenter.view = mainMusicController
        mainMusicController.urlGetMusic = urlGetMusic
        mainMusicController.UID = UID
        presenter.urlGetMusic = urlGetMusic
        presenter.UID = UID
        let musicNavVC = UINavigationController(rootViewController: mainMusicController)
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "music", image: musicNote, tag: 1)
        musicNavVC.tabBarItem = tabBarItem
        return musicNavVC
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//
//        print(tabBarIndex)
//        if tabBarIndex == 0 {
//            self.navigationController?.isNavigationBarHidden = false
//            self.navigationItem.title = "new"
//        }
//        if tabBarIndex == 1 {
//            self.navigationController?.isNavigationBarHidden = false
//            self.navigationItem.title = "123"
//        }
//        if tabBarIndex == 2 {
//            self.navigationController?.isNavigationBarHidden = true
//
//        }
//    }
}
