//
//  TabViewController.swift
//  CoockS
//
//  Created by BigSynt on 07.08.2022.
//  Copyright © 2022 BigSynt. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }

}
