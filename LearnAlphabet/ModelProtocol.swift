//
//  ModelProtocol.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/19/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation


public struct ProfileStruct {
    let firstname: String
    let lastname: String
    let language: LanguageEnum
    let yearsold: Int
    let avatar: AvatarStruct
    let alphabet: AlphabetStruct
}

extension ProfileStruct {
    init() {
        firstname = ""
        lastname = ""
        language = LanguageEnum(rawValue: "")!
        yearsold = 0
        avatar = AvatarStruct()
        alphabet = AlphabetStruct()
    }
}

public struct ProfileProgressStruct {
    let firstname: String
    let alphabet: AlphabetStruct
    let character: String
}

extension ProfileProgressStruct {
    init() {
        firstname = ""
        alphabet = AlphabetStruct()
        character = ""
    }
}

struct AvatarStruct {
    let name: String
    let image: String
}

extension AvatarStruct {
    init() {
        name = ""
        image = ""
    }
}

struct AlphabetStruct {
    let name: String
    let characters: [String]
    let numofCharacters: Int
}

extension AlphabetStruct {
    init() {
        name = ""
        characters = [""]
        numofCharacters = 0
    }
}
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
    
    var alphabetStructArray: [AlphabetStruct]? { get }
    var avatarStructArray: [AvatarStruct]? { get }
}

protocol LearnAlphabetCoreDataProtocol {
    var environment: EnvironmentProtocol? { get }
    
    func set(Environment: EnvironmentProtocol) -> Void
    
    func getProfiles() -> [ProfileStruct]
    func insert(profile newProfile:ProfileStruct)
    func getProfileWith(name profileName: String) -> ProfileStruct
    func set(avatar newAvatar: AvatarStruct, toProfile profile:ProfileStruct) -> ProfileStruct
}

protocol LearnAlphabetJSONReaderProtocol {
    func readJSONAvatars() -> [AvatarStruct]?
    func readAlphabets() -> [AlphabetStruct]?
    
}

protocol ValidationModelProtocol {
    var environment: EnvironmentProtocol? { get }
    func set(Environment: EnvironmentProtocol) -> Void
}

protocol ProfileModelProtocol {
    var environment: EnvironmentProtocol? { get }
    func set(Environment: EnvironmentProtocol) -> Void
}
