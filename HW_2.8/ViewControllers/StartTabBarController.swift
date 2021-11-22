//
//  StartTabBarController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 16.11.2021.
//

import UIKit

class StartTabBarController: UITabBarController {
    
    var persons: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        for viewController in viewControllers! {
            if let navigationVC = viewController as? UINavigationController {
                if let accountExistingVC = navigationVC.topViewController as? AccountExistingTableViewController {
                    accountExistingVC.persons = persons
                } else if let allTransactionVC = navigationVC.topViewController as? AllAccountTransactionTableViewController {
                    allTransactionVC.persons = persons
                } else if let moreVC = navigationVC.topViewController as? MoreTableViewController {
                    moreVC.persons = persons
                }
            }
        }
    }
}
