//
//  LearnAlphabetJSONReader.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/22/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Gloss

final class LearnAlphabetJSONReader: LearnAlphabetJSONReaderProtocol {
    
    func readAlphabets() -> [Alphabet] {
        let bundle =  Bundle.main
        if let path = bundle.path(forResource: "alphabets", ofType: "json") {
            do {
                let content = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: content)
                    
                guard let dictionary = json as? [String: Any] else {
                    print("Error: json is not Dictionary[String: Any]")
                    return []
                }
                    
                guard let arrayOfAlphabets = Alphabtes(json: dictionary) else {
                    print("Error initializing object")
                    return []
                }
                    
                guard let alphabets = arrayOfAlphabets.alphabets else {
                    print("Error initializing object")
                    return []
                }
                return alphabets
            } catch let error as NSError {
                print(error.localizedDescription)
                return []
            }
        }
        return []
    }
    
    func readJSONAvatars() -> [Avatar] {
        let bundle =  Bundle.main
        if let path = bundle.path(forResource: "avatars", ofType: "json") {
            do {
                let content = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: content)
                    
                guard let dictionary = json as? [String: Any] else {
                    print("Error: json is not Dictionary[String: Any]")
                    return []
                }
                    
                guard let arrayOfAvatars = Avatars(json: dictionary) else {
                    print("Error initializing object")
                    return []
                }
                    
                guard let avatars = arrayOfAvatars.avatars else {
                    print("Error initializing object")
                    return []
                }
                return avatars
            } catch let error as NSError {
                print(error.localizedDescription)
                return []
            }
        }
        return []
    }
    
}
