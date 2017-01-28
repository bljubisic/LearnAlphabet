//
//  Environment.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation


final class Environment: EnvironmentProtocol {
    
    var coreDataModel: LearnAlphabetCoreDataProtocol
    var jsonDataModel: LearnAlphabetJSONReaderProtocol
    var validationModel: ValidationModelProtocol
    var profileModel: ProfileModelProtocol
    var alphabetStructArray: [AlphabetStruct]?
    var avatarStructArray: [AvatarStruct]?
    
    init() {
        coreDataModel = CoreDataModel()
        jsonDataModel = LearnAlphabetJSONReader()
        validationModel = ValidationModel()
        profileModel = ProfileModel()
        
        avatarStructArray = jsonDataModel.readJSONAvatars()
        alphabetStructArray = jsonDataModel.readAlphabets()
        
        coreDataModel.set(Environment: self)
        validationModel.set(Environment: self)
        profileModel.set(Environment: self)
    }
    
}
