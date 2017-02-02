//
//  ProfileProgress.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/1/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData

public final class ProfileProgress: ManagedObject {
    @NSManaged public private(set) var firstname: String
    @NSManaged public private(set) var alphabetname: String
    @NSManaged public private(set) var character: String
    @NSManaged public private(set) var profile: Profile
    
    public static func insertIntoContext(moc: NSManagedObjectContext, profileProgress: ProfileProgressStruct) -> ProfileProgress {
        let localProfileProgress: ProfileProgress = moc.insertObject()
        localProfileProgress.firstname = profileProgress.firstname
        localProfileProgress.alphabetname = profileProgress.alphabet.name
        localProfileProgress.character = profileProgress.character
        localProfileProgress.profile = Profile.findOrCreateProfileWithProgress(firstname: profileProgress.firstname, inContext: moc)
        
        return localProfileProgress
    }
}

extension ProfileProgress: ManagedObjectType {
    public static var entityName: String {
        return "ProfileProgress"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "alphabetname", ascending: false)]
    }
}
