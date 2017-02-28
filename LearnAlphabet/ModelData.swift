//
//  ModelData.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Gloss

public struct ProfileSt {
    let firstname: String
    let lastname: String
    let language: LanguageEnum
    let yearsold: Int
    let avatar: Avatar
    let alphabet: Alphabet
}

extension ProfileSt {
    init() {
        firstname = ""
        lastname = ""
        language = LanguageEnum(rawValue: "")!
        yearsold = 0
        avatar = Avatar()
        alphabet = Alphabet()
    }
}

public struct ProfileProgressSt {
    let firstname: String
    let alphabet: Alphabet
    let character: String
}

extension ProfileProgressSt {
    init() {
        firstname = ""
        alphabet = Alphabet()
        character = ""
    }
}

struct Avatars: Decodable {
    let avatars: [Avatar]?
    
    public init?(json: JSON) {
        avatars = "avatars" <~~ json
    }
}

struct Avatar {
    let name: String?
    let image: String?
}

extension Avatar: Decodable {
    init() {
        name = ""
        image = ""
    }
    
    public init?(json: JSON) {
        name = "name" <~~ json
        image = "image" <~~ json
    }
}

struct Alphabtes: Decodable {
    let alphabets: [Alphabet]?
    
    public init?(json: JSON) {
        alphabets = "alphabets" <~~ json
    }
}

struct Alphabet{
    let name: String?
    let characters: [String]?
    let numofCharacters: Int?
    

}

extension Alphabet: Decodable {
    init() {
        name = ""
        characters = [""]
        numofCharacters = 0
    }
    
    public init?(json: JSON) {
        name = "name" <~~ json
        characters = "letters" <~~ json
        numofCharacters = "length" <~~ json
    }
}
