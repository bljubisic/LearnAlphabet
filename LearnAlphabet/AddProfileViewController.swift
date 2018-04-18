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
        
        self.avatarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        self.avatarButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.firstNameText = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        self.firstNameText.borderStyle = UITextBorderStyle.roundedRect
        self.firstNameText.font = UIFont.systemFont(ofSize: 15)
        self.firstNameText.placeholder = "enter firstname"
        self.firstNameText.autocorrectionType = UITextAutocorrectionType.no
        self.firstNameText.keyboardType = UIKeyboardType.default
        self.firstNameText.returnKeyType = UIReturnKeyType.done
        self.firstNameText.clearButtonMode = UITextFieldViewMode.whileEditing
        self.firstNameText.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        self.lastNameText = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        self.lastNameText.borderStyle = UITextBorderStyle.roundedRect
        self.lastNameText.font = UIFont.systemFont(ofSize: 15)
        self.lastNameText.placeholder = "enter lastname"
        self.lastNameText.autocorrectionType = UITextAutocorrectionType.no
        self.lastNameText.keyboardType = UIKeyboardType.default
        self.lastNameText.returnKeyType = UIReturnKeyType.done
        self.lastNameText.clearButtonMode = UITextFieldViewMode.whileEditing
        self.lastNameText.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        self.yearBornLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        self.yearBornPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 325, height: 216))
        
        self.view.addSubview(avatarButton)
        self.view.addSubview(firstNameText)
        self.view.addSubview(lastNameText)
        self.view.addSubview(yearBornLabel)
        self.view.addSubview(yearBornPicker)
        
        self.avatarButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            //make.bottom.equalTo(self.firstNameText.snp.top).inset(-30)
            make.top.equalTo(self.view).inset(40)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        self.firstNameText.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).inset(10)
            make.left.equalTo(self.view).inset(10)
            make.height.equalTo(30)
            make.top.equalTo(self.avatarButton.snp.bottom).inset(-30)
            //make.bottom.equalTo(self.lastNameText.snp.top).inset(-30)
        }
        
        self.lastNameText.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).inset(10)
            make.left.equalTo(self.view).inset(10)
            make.height.equalTo(30)
            make.top.equalTo(self.firstNameText.snp.bottom).inset(-30)
            //make.bottom.equalTo(self.yearBornLabel.snp.top).inset(-30)
        }
        
        self.yearBornLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).inset(10)
            make.left.equalTo(self.view).inset(10)
            make.height.equalTo(30)
            make.top.equalTo(self.lastNameText.snp.bottom).inset(-30)
            //make.bottom.equalTo(self.yearBornPicker.snp.top).inset(-30)
        }
        
        self.yearBornPicker.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).inset(10)
            make.left.equalTo(self.view).inset(10)
            make.height.equalTo(216)
            make.top.equalTo(self.yearBornLabel.snp.bottom).inset(-30)
        }
    }

}
