//
//  StartTabBarController.swift
//  HW_2.8
//
//  Created by Ilya Pokhodin on 16.11.2021.
//

import UIKit

class StartTabBarController: UITabBarController {
    
    var person: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
          
//        guard let allAcountTransVC = navigationVC.topViewController as? AllAccountTransactionTableViewController else { return }
//        allAcountTransVC.persons = person
//        print("ПРОВЕРКА")
        
//        guard let navigationVCthree = viewControllers?.last as? UINavigationController else { return }
        
        
//        for viewController in viewControllers! {
//            let persons = Person.getPerson()
//            if let AccountExistingVC = viewController as? AccountExistingTableViewController {
//                //AccountExistingVC.persons = persons
//            }
//        }
        //guard let pirsonDeteilVC = viewControllers?.last as? PirsonDetailTableViewController else { return }
        //pirsonDeteilVC.personsList = persons
    }
}
