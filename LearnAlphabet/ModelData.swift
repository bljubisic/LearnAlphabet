//
//  ModelData.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Gloss

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

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

extension ProfileSt {
    static let firstnameLens = Lens<ProfileSt, String> (
        get: {$0.firstname },
        set: { (f, p) in ProfileSt(firstname: f, lastname: p.lastname, language: p.language, yearsold: p.yearsold, avatar: p.avatar, alphabet: p.alphabet) }
    )
    
    static let lastnameLens = Lens<ProfileSt, String> (
        get: {$0.lastname},
        set: {(l, p) in ProfileSt(firstname: p.firstname, lastname: l, language: p.language, yearsold: p.yearsold, avatar: p.avatar, alphabet: p.alphabet) }
    )
    
    static let languageLens = Lens<ProfileSt, LanguageEnum> (
        get: {$0.language},
        set: { (l, p) in ProfileSt(firstname: p.firstname, lastname: p.lastname, language: l, yearsold: p.yearsold, avatar: p.avatar, alphabet: p.alphabet) }
    )
    
    static let yearsoldLens = Lens<ProfileSt, Int> (
        get: {$0.yearsold},
        set: {(y,p) in ProfileSt(firstname: p.firstname, lastname: p.lastname, language: p.language, yearsold: y, avatar: p.avatar, alphabet: p.alphabet) }
    )
    
    static let avatarLens = Lens<ProfileSt, Avatar> (
        get: { $0.avatar },
        set: { (a, p) in ProfileSt(firstname: p.firstname, lastname: p.lastname, language: p.language, yearsold: p.yearsold, avatar: a, alphabet: p.alphabet) }
    )
    
    static let alphabetLens = Lens<ProfileSt, Alphabet> (
        get: { $0.alphabet },
        set: { (a, p) in ProfileSt(firstname: p.firstname, lastname: p.lastname, language: p.language, yearsold: p.yearsold, avatar: p.avatar, alphabet: a) }
    )
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
