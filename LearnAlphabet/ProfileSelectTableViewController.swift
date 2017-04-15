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
import SnapKit

class ProfileSelectTableViewController: UIViewController{
    
    var tableView: UITableView!
    var viewModel: ProfileViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(AddProfileTableViewCell.self, forCellReuseIdentifier: "addProfileCell")
        self.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profileCell")
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(20, 5, 5, 0))
        }
        self.tableView.setContentOffset(CGPoint.zero, animated:true)
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
            cell.addProfile.addTarget(self, action: #selector(self.pressedButton(sender:)), for: .touchUpInside)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func pressedButton(sender: UIButton!) {
        print("Add profile button pressed")
    }
    
}
