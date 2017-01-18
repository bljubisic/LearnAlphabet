//
//  SelectProfileViewModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/6/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import UIKit

struct ProfileStruct {
    let name: String
    let surname: String
    let avatar: AvatarStruct
    
}

struct AvatarStruct {
    let name: String
    let image: UIImage
    
}


protocol ProfileViewModelProtocol {
    func getAllProfiles() -> [ProfileStruct]
    func getNumberOfAvailableProfiles() -> Int
    func addNewProfile(newProfile: ProfileStruct, closure: (ProfileStruct) -> Bool) -> Void
    func selectProfile(selectedProfile: ProfileStruct) -> ProfileStruct
    
}

