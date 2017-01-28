//
//  ProfileModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/28/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation


final class ProfileModel: ProfileModelProtocol {
    var environment: EnvironmentProtocol?
    
    func set(Environment localEnvironment: EnvironmentProtocol) {
        self.environment = localEnvironment
    }
    
    init() {
        self.environment = nil
    }
    
}
