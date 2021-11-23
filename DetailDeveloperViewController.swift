//
//  DetailDeveloperViewController.swift
//  HW_2.8
//
//  Created by Anton Anan'eV on 23.11.2021.
//

import UIKit

class DetailDeveloperViewController: UIViewController {
    
    var developer: Developer!

    @IBOutlet var avatarImageView: UIImageView! 
    
    override func viewDidLayoutSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: developer.avatar)
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        title = developer.fullName
    }

}
 // MARK: - EXTENSION
extension DetailDeveloperViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCellname", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = developer.descriprions
        cell.contentConfiguration = content
        return cell
    }
    
    
}
