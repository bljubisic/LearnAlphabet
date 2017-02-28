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

protocol ViewModelProtocol {
    
}

protocol ProfileViewModelProtocolDataSource {
    var profilesAvailable: [ProfileSt] { get }
}
protocol ProfileViewModelProtocolOutputs {
    func selectProfileOn(index: Int) -> ProfileSt
    func availableProfilesCount() -> Int
    func getProfileName(withIndex index: Int) -> String
    func getProfileAvatar(withIndex index: Int) -> String?
}

protocol ProfileViewModelProtocolInputs {
    func add(newProfile profile: ProfileSt) -> ProfileSt
}


protocol ProfileViewModelProtocol: ViewModelProtocol, ProfileViewModelProtocolDataSource, ProfileViewModelProtocolOutputs, ProfileViewModelProtocolInputs {
    
    var environment: Environment? { get }
    var dataSource: ProfileViewModelProtocolDataSource { get }
    var outputs: ProfileViewModelProtocolOutputs { get }
    var inputs: ProfileViewModelProtocolInputs { get }
    
    func set(environment newEnvironment: Environment) -> Void
}

