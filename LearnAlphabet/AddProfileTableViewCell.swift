//
//  AddProfileTableViewCell.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class AddProfileTableViewCell: UITableViewCell {
    
    var addProfile: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        self.addProfile.setBackgroundImage(#imageLiteral(resourceName: "addProfile"), for: .normal)
        
        self.addProfile.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.centerY.equalTo(self.contentView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
