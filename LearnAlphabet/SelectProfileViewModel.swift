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
    let avatar: String
    
}

protocol ProfileViewModelProtocol {
    func getAllProfiles() -> [ProfileStruct]
    func getNumberOfAvailableProfiles() -> Int
    func addNewProfile(newProfile: ProfileStruct) -> Void
    func selectProfile(selectedProfile: ProfileStruct) -> ProfileStruct
    
}


struct SelectProfileViewModel: ProfileViewModelProtocol {
    
    internal func selectProfile(selectedProfile: ProfileStruct) -> ProfileStruct {
        
    }

    internal func addNewProfile(newProfile: ProfileStruct) {
        
    }

    
    internal func getNumberOfAvailableProfiles() -> Int {
        
    }

    internal func getAllProfiles() -> [ProfileStruct] {
        
    }

    
    
    
}
