//
//  LearnAlphabetJSONReader.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/22/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import SwiftyJSON

final class LearnAlphabetJSONReader: LearnAlphabetJSONReaderProtocol {
    
    func readAlphabets() -> [AlphabetStruct]? {
        let bundle =  Bundle.main
        if let path = bundle.path(forResource: "alphabets", ofType: "json") {
            do {
                let content = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = JSON(content)
                var arrayOfAlphabets: [AlphabetStruct] = [AlphabetStruct]()
                for alphabet in json["alphabets"].arrayValue {
                    let alphabetStruct = AlphabetStruct(name: alphabet["name"].stringValue, characters: alphabet["letters"].arrayObject as! [String], numofCharacters: alphabet["length"].intValue)
                    arrayOfAlphabets.append(alphabetStruct)
                }
                return arrayOfAlphabets
            
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    func readJSONAvatars() -> [AvatarStruct]? {
        let bundle =  Bundle.main
        if let path = bundle.path(forResource: "avatars", ofType: "json") {
            do {
                let content = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = JSON(content)
                var arrayOfAvatars: [AvatarStruct] = [AvatarStruct]()
                for avatar in json["avatars"].arrayValue {
                    let avatarStruct = AvatarStruct(name: avatar["name"].stringValue, image: avatar["image"].stringValue)
                    arrayOfAvatars.append(avatarStruct)
                }
                return arrayOfAvatars
                
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
}
