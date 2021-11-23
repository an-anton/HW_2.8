//
//  DevTableViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 23.11.2021.
//

import UIKit

class DevTableViewController: UITableViewController {
    
     // MARK: - Privet preference
    let developers = Developer.getDev()

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDeveloper", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let dev = developers[indexPath.row]
        content.text = dev.fullName
        content.imageProperties.maximumSize = CGSize(width: 60 , height: 60)
        content.imageProperties.cornerRadius = content.imageProperties.maximumSize.width / 2
        content.image = UIImage(named: dev.avatar)
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailDevVC = segue.destination as? DetailDeveloperViewController else { return }
        guard let indexPathRow = tableView.indexPathForSelectedRow else { return }
        let developer = developers[indexPathRow.row]
        detailDevVC.developer = developer
    }
}
