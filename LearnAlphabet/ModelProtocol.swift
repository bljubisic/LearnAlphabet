//
//  ModelProtocol.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/19/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import ReactiveSwift
import enum Result.NoError


enum LanguageEnum: String {
    case English
    case Serbian
    case Chinese
}

enum Keys: String {
    case Firstname = "firstname"
    case Alphabetname = "alphabetname"
}

protocol EnvironmentProtocol {
    var coreDataModel: LearnAlphabetCoreDataProtocol { get }
    var jsonDataModel: LearnAlphabetJSONReaderProtocol { get }
    var validationModel: ValidationModelProtocol { get }
    var profileModel: ProfileModelProtocol { get }
    
    var alphabetStructArray: [Alphabet] { get }
    var avatarStructArray: [Avatar] { get }
}

protocol LearnAlphabetCoreDataProtocol {
    var environment: EnvironmentProtocol? { get }
    
    func set(Environment: EnvironmentProtocol) -> Void
    
    func getProfiles() -> [ProfileSt]
    func insert(profile newProfile:ProfileSt) -> ProfileSt
    func getProfileWith(name profileName: String) -> ProfileSt
    func set(avatar newAvatar: Avatar, toProfile profile:ProfileSt) -> ProfileSt
}

protocol LearnAlphabetJSONReaderProtocol {
    func readJSONAvatars() -> [Avatar]
    func readAlphabets() -> [Alphabet]
    
}

protocol ValidationModelProtocol {
    var environment: EnvironmentProtocol? { get }
    func set(Environment: EnvironmentProtocol) -> Void
}

protocol ProfileModelProtocol {
    var environment: EnvironmentProtocol? { get }
    func set(Environment: EnvironmentProtocol) -> Void
    func availableProfiles() -> [ProfileSt]
    func add(profile newProfile: ProfileSt) -> ProfileSt
    func change(profile oldProfile: ProfileSt, withProfile newProfile: ProfileSt) -> ProfileSt
}
