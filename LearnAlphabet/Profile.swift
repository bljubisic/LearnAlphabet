//
//  Profile.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/1/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData

public final class Profile: ManagedObject {
    
    @NSManaged public private(set) var alphabet: String
    @NSManaged public private(set) var avatar: String
    @NSManaged public private(set) var firstname: String
    @NSManaged public private(set) var language: String
    @NSManaged public private(set) var lastname: String
    @NSManaged public private(set) var yearsold: Int
    @NSManaged public private(set) var progresses: Set<ProfileProgress>
    
    public static func insertIntoContext(moc: NSManagedObjectContext, profile: ProfileSt) -> Profile {
        let localProfile:Profile = moc.insertObject()
        localProfile.alphabet = profile.alphabet.name!
        localProfile.avatar = profile.avatar.name!
        localProfile.firstname = profile.firstname
        localProfile.lastname = profile.lastname
        
        return localProfile
    }
    
    static func findOrCreateProfileWithProgress(firstname: String, inContext moc: NSManagedObjectContext) -> Profile {
        let predicate: NSPredicate = NSPredicate(format: "%K == %@", Keys.Firstname.rawValue, firstname)
        let profile = findOrCreateInContext(moc: moc, matchingPredicate: predicate) {
            $0.firstname = firstname
            $0.alphabet = ""
            $0.avatar = ""
            $0.language = ""
            $0.lastname = ""
            $0.yearsold = 0
        }
        return profile
    }
}

extension Profile: ManagedObjectType {
    public static var entityName: String {
        return "Profile"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "firstname", ascending: false)]
    }
}
