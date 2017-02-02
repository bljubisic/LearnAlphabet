//
//  ManagedObjectTypeProtocol.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 2/1/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectContextSettable: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}


public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension ManagedObjectType {
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    public static var sortedFetchRequest: NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

extension ManagedObjectType where Self: ManagedObject {
    public static func findOrCreateInContext(moc: NSManagedObjectContext, matchingPredicate predicate:NSPredicate, configure: (Self) -> ()) -> Self {
        guard let obj = findOrFetchInContext(moc: moc, matchingPredicate: predicate) else {
            let newObject: Self = moc.insertObject()
            configure(newObject)
            return newObject
        }
        return obj
    }
    
    public static func findOrFetchInContext(moc: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> Self? {
        guard let obj = materializedObjectInContext(moc: moc, matchingPredicate: predicate)
            else {
                return fetchInContext(context: moc) { request in
                    request.predicate = predicate
                    request.returnsObjectsAsFaults = false
                    request.fetchLimit = 1
                }.first
        }
        return obj
    }
}

extension ManagedObjectType where Self: ManagedObject {
    public static func materializedObjectInContext(moc: NSManagedObjectContext, matchingPredicate predicate:NSPredicate) -> Self? {
        for obj in moc.registeredObjects where !obj.isFault {
            guard let res = obj as? Self, predicate.evaluate(with: res)
                else { continue }
            return res
        }
        return nil
    }
}

extension ManagedObjectType where Self: ManagedObject {
    public static func fetchInContext(context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<NSFetchRequestResult>) -> () = {_ in }) -> [Self] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Self.entityName)
        configurationBlock(request)
        guard let result = try! context.fetch(request) as? [Self]
            else {
                fatalError("Fetched object have wrong type")
        }
        return result
    }
}

public class ManagedObject: NSManagedObject {
    
}

extension NSManagedObjectContext {
    public func insertObject<A: ManagedObject> () -> A where A: ManagedObjectType {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A
            else { fatalError("Wrong object type") }
        return obj
    }
}

extension NSManagedObjectContext {
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    public func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            self.saveOrRollback()
        }
    }
}
