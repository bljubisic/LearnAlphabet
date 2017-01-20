//
//  ModelProtocol.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/19/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation


struct ProfileStruct {
    let profileid: Int
    let firstname: String
    let lastname: String
    let avatar: AvatarStruct
    let alphabet: AlphabetStruct
}

struct ProfileProgressStruct {
    let profileid: Int
    let alphabet: AlphabetStruct
    let character: String
}

struct AvatarStruct {
    let name: String
    let image: String
}

struct AlphabetStruct {
    let name: String
    let characters: [String]
    let numofCharacters: Int
}


protocol LearnAlphabetCoreDataProtocol {
    func getProfiles() -> [ProfileStruct]
    func insert(profile newProfile:ProfileStruct)
    func getProfileWith(name profileName: String) -> ProfileStruct
    func set(avatar newAvatar: AvatarStruct, toProfile profile:ProfileStruct) -> ProfileStruct
}

protocol LearnAlphabetJSONReaderProtocol {
    func readJSONAvatars() -> [AvatarStruct]
    func readAlphabets() -> [AlphabetStruct]
    
}

protocol ValidateModelProtocol {
    
}

protocol ProfileModelProtocol {
    
}
