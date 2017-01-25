//
//  SelectProfileViewModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/6/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import ReactiveSwift
import enum Result.NoError


protocol ProfileViewModelProtocolOutputs {
    var profilesAvailable: MutableProperty<[ProfileStruct]> { get }
    
    func selectProfileOn(index: Int) -> ProfileStruct
}

protocol ProfileViewModelProtocolInputs {
    func add(newProfile profile: ProfileStruct)
}


protocol ProfileViewModelProtocol: ProfileViewModelProtocolOutputs, ProfileViewModelProtocolInputs {
    var outputs: ProfileViewModelProtocolOutputs { get }
    var inputs: ProfileViewModelProtocolInputs { get }
}

