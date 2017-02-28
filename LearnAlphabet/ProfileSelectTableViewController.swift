//
//  ProfileSelectTableViewController.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/11/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ProfileSelectTableViewController: UIViewController{
    
    var tableView: UITableView!
    var viewModel: ProfileViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ProfileSelectTableViewController: ViewControllerProtocol {
    
    func bindTo(viewModel localViewModel: ViewModelProtocol) {
        viewModel = localViewModel as! ProfileViewModel
    }
}

extension ProfileSelectTableViewController: UITableViewDelegate {

}

extension ProfileSelectTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let viewModel = self.viewModel else {
            return 1
        }
        return viewModel.outputs.availableProfilesCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cellIdentifier = "addProfileCell"
            let cell: AddProfileTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AddProfileTableViewCell
            return cell
        } else {
            let cellIdentifier = "profileCell"
            let cell: ProfileTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProfileTableViewCell
            
            guard let viewModel = self.viewModel else {
                print("Error getting viewModel")
                return UITableViewCell()
            }
            guard let imageName = viewModel.outputs.getProfileAvatar(withIndex: indexPath.row - 1) else {
                print("Error avatar image is nil")
                return UITableViewCell()
            }
            cell.avatarImage.image = UIImage(named: imageName)
            cell.profileName.text = viewModel.outputs.getProfileName(withIndex: indexPath.row - 1)
            return cell
        }
    }
    
}
