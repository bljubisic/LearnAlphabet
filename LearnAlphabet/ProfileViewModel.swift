//
//  ProfileViewModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/6/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import ReactiveSwift
import enum Result.NoError

final class ProfileViewModel: ProfileViewModelProtocol, ProfileViewModelProtocolDataSource {
    
    var profilesAvailable: [ProfileSt]
    
    var environment: Environment?
    
    var dataSource: ProfileViewModelProtocolDataSource {
        return self
    }
    
    var outputs: ProfileViewModelProtocolOutputs {
        return self
    }
    
    var inputs: ProfileViewModelProtocolInputs {
        return self
    }
    
    init() {
        self.environment = nil
        profilesAvailable = []
    }
    
    func set(environment newEnvironment: Environment) -> Void {
        self.environment = newEnvironment
        guard let environment = self.environment else {
            profilesAvailable = []
            return
        }
        profilesAvailable = environment.coreDataModel.getProfiles()
    }
    
}

extension ProfileViewModel: ProfileViewModelProtocolOutputs {

    func selectProfileOn(index: Int) -> ProfileSt {
        return profilesAvailable[index]
    }
    
    func availableProfilesCount() -> Int {
        return profilesAvailable.count
    }
    
    func getProfileName(withIndex index: Int) -> String {
        let profile = self.profilesAvailable[index]
        return profile.firstname
    }
    
    func getProfileAvatar(withIndex index: Int) -> String? {
        let profile = self.profilesAvailable[index]
        return profile.avatar.image
    }
}

extension ProfileViewModel: ProfileViewModelProtocolInputs {
    
    func add(newProfile profile: ProfileSt) -> ProfileSt{
        guard let environment = self.environment else {
            NSLog("Error while inserting new profile")
            return profile
        }
        return environment.coreDataModel.insert(profile: profile)
    }
    
}
