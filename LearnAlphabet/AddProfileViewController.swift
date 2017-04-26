//
//  AddProfileViewController.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 3/8/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class AddProfileViewController: UIViewController {

    var avatarButton: UIButton!
    var firstNameText: UITextField!
    var lastNameText: UITextField!
    var yearBornLabel: UILabel!
    var yearBornPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarButton = UIButton()
        self.firstNameText = UITextField()
        self.lastNameText = UITextField()
        self.yearBornLabel = UILabel()
        self.yearBornPicker = UIPickerView()
        
        self.view.addSubview(avatarButton)
        self.view.addSubview(firstNameText)
        self.view.addSubview(lastNameText)
        self.view.addSubview(yearBornLabel)
        self.view.addSubview(yearBornPicker)
        
        self.avatarButton.snp.makeConstraints { (make) in
            make.edges.centerX.equalTo(self.view)
        }
        
        
    }

}
