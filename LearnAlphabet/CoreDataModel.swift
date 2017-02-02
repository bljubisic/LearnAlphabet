//
//  CoreDataModel.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 1/27/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataModel: LearnAlphabetCoreDataProtocol {

// MARK: Variables
    var environment: EnvironmentProtocol?
    
    lazy var applicationDocumentsDirectory: NSURL? = {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.persukibo.LearnAlphabetSharingDefaults") ?? nil
    }() as NSURL?
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "LearnAlphabet", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory!.appendingPathComponent("LearnAlphabet.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            
            //error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as! [NSObject : AnyObject])
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //NSLog("Unresolved error \(error), \(error!.userInfo)")
            //abort()
        }
        catch _ {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    

    
    func set(Environment localEnvironment: EnvironmentProtocol) {
        self.environment = localEnvironment
    }
    
    init() {
        self.environment = nil
    }

    init(WithEnvironment localEnvironment: EnvironmentProtocol) {
        self.environment = localEnvironment
    }
    
    func getProfiles() -> [ProfileStruct] {
        
        var returnedProfiles: [ProfileStruct] = [ProfileStruct]()
        
        let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: self.managedObjectContext!)
        let request: NSFetchRequest<Profile> = NSFetchRequest()
        request.entity = profileEntity
        
        do {
            let fetchedProfiles = try self.managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Profile]
            for profile in fetchedProfiles {
                let avatarStruct: AvatarStruct = (self.environment!.avatarStructArray?.filter({
                        $0.name == profile.avatar
                }).first)!
                let alphabetStruct: AlphabetStruct = (self.environment!.alphabetStructArray?.filter({
                    $0.name == profile.alphabet
                }).first)!
                let tmpProfileStruct: ProfileStruct = ProfileStruct(firstname: profile.firstname, lastname: profile.lastname, language: LanguageEnum(rawValue: profile.language)!, yearsold: profile.yearsold, avatar: avatarStruct, alphabet: alphabetStruct)
                returnedProfiles.append(tmpProfileStruct)
            }
        } catch {
            fatalError("Failed to fetch profiles: \(error)")
        }
        return returnedProfiles
    }
    
    func insert(profile newProfile:ProfileStruct) {
        
    }
    
    func getProfileWith(name profileName: String) -> ProfileStruct {
        let profileStruct = ProfileStruct(firstname: "", lastname: "", language: LanguageEnum(rawValue: "")!, yearsold: 0, avatar: AvatarStruct()  , alphabet: AlphabetStruct())
        let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: self.managedObjectContext!)
        let request: NSFetchRequest<Profile> = NSFetchRequest()
        request.entity = profileEntity
        
        let predicate: NSPredicate = NSPredicate(format: "firstname = \(profileName)")
        
        request.predicate = predicate
        
        do {
            let fetchedProfiles = try self.managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Profile]
            for profile in fetchedProfiles {
                let avatarStruct: AvatarStruct = (self.environment!.avatarStructArray?.filter({
                    $0.name == profile.avatar
                }).first)!
                let alphabetStruct: AlphabetStruct = (self.environment!.alphabetStructArray?.filter({
                    $0.name == profile.alphabet
                }).first)!
                let tmpProfileStruct: ProfileStruct = ProfileStruct(firstname: profile.firstname, lastname: profile.lastname, language: LanguageEnum(rawValue: profile.language)!, yearsold: 0, avatar: avatarStruct, alphabet: alphabetStruct)
                return tmpProfileStruct
            }
        } catch {
            fatalError("Failed to fetch profiles: \(error)")
        }
        return profileStruct
        
    }
    
    func set(avatar newAvatar: AvatarStruct, toProfile profile:ProfileStruct) -> ProfileStruct {
        var profileStruct = ProfileStruct()
        
        return profileStruct
    }
    
}

