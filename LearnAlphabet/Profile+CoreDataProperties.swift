//
//  Profile+CoreDataProperties.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/28/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile");
    }

    @NSManaged public var avatar: String?
    @NSManaged public var firstname: String?
    @NSManaged public var language: String?
    @NSManaged public var lastname: String?
    @NSManaged public var yearsold: Int16
    @NSManaged public var alphabet: String?
    @NSManaged public var profileCharacterProgress: NSSet?

}

// MARK: Generated accessors for profileCharacterProgress
extension Profile {

    @objc(addProfileCharacterProgressObject:)
    @NSManaged public func addToProfileCharacterProgress(_ value: ProfileProgress)

    @objc(removeProfileCharacterProgressObject:)
    @NSManaged public func removeFromProfileCharacterProgress(_ value: ProfileProgress)

    @objc(addProfileCharacterProgress:)
    @NSManaged public func addToProfileCharacterProgress(_ values: NSSet)

    @objc(removeProfileCharacterProgress:)
    @NSManaged public func removeFromProfileCharacterProgress(_ values: NSSet)

}
