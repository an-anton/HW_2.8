//
//  StartTabBarController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 16.11.2021.
//

import UIKit

protocol UpdateTabBatTest {
    func updateTabBar(with newPerson: Person)
}

class StartTabBarController: UITabBarController {
    
    var persons: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        for viewController in viewControllers! {
            if let navigationVC = viewController as? UINavigationController {
                if let accountExistingVC = navigationVC.topViewController as? AccountExistingTableViewController {
                    accountExistingVC.persons = persons
                    accountExistingVC.delegate = self
                } else if let allTransactionVC = navigationVC.topViewController as? AllAccountTransactionTableViewController {
                    allTransactionVC.persons = persons
                    allTransactionVC.delegate = self
                } else if let moreVC = navigationVC.topViewController as? MoreTableViewController {
                    moreVC.persons = persons
                    moreVC.delegate = self
                }
            }
        }
    }
}

extension StartTabBarController: UpdateTabBatTest {
    func updateTabBar(with newPerson: Person) {
        persons = newPerson
    }
}
