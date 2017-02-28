//
//  ProfileTableViewCell.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {

    var avatarImage: UIImageView!
    var profileName: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.avatarImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
        self.profileName = UILabel()
        
        self.avatarImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).inset(10)
        }
        
        self.profileName.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).inset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
