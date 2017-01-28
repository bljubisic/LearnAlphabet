//
//  ProfileProgress+CoreDataProperties.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/28/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData


extension ProfileProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileProgress> {
        return NSFetchRequest<ProfileProgress>(entityName: "ProfileProgress");
    }

    @NSManaged public var alphabetname: String?
    @NSManaged public var character: String?
    @NSManaged public var profileCharacterProgress: Profile?

}
