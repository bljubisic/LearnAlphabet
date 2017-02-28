//
//  ProfileModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/28/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import enum Result.NoError

final class ProfileModel: ProfileModelProtocol {
    var environment: EnvironmentProtocol?
    
    func set(Environment localEnvironment: EnvironmentProtocol) {
        self.environment = localEnvironment
    }
    
    init() {
        self.environment = nil
    }
    
    func availableProfiles() -> [ProfileSt] {
        guard let environment = self.environment else {
            return []
        }
        return environment.coreDataModel.getProfiles()
    }
    
    func add(profile newProfile: ProfileSt) -> ProfileSt {
        guard let environment = self.environment else {
            return ProfileSt()
        }
        return environment.coreDataModel.insert(profile: newProfile)
    }
    
    func change(profile oldProfile: ProfileSt, withProfile newProfile: ProfileSt) -> ProfileSt {
        return newProfile
    }
}
