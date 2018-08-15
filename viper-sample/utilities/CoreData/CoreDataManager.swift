//
//  CoreDataManager.swift
//  viper-sample
//
//  Created by hicka04 on 2018/08/15.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit
import CoreData

private extension NSFetchRequestResult {
    
    static var entityName: String {
        return String(describing: self)
    }
}

class CoreDataManager: NSObject {
    
    private let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var managedObjectContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    private func createFetchRequest<Entity: NSFetchRequestResult>(entityType: Entity.Type, where predicate: NSPredicate?) -> NSFetchRequest<Entity> {
        let fetchReqest = NSFetchRequest<Entity>(entityName: Entity.entityName)
        fetchReqest.predicate = predicate
        
        return fetchReqest
    }
}

extension CoreDataManager: CoreDataUsecase {
    
    func insert<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, apply: (_ entity: Entity) -> Void) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: Entity.entityName,
                                                         into: managedObjectContext) as! Entity
        apply(entity)
        
        appDelegate.saveContext()
    }
    
    func select<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate?) -> [Entity] {
        let fetchRequest = createFetchRequest(entityType: entityType, where: predicate)
        
        return try! managedObjectContext.fetch(fetchRequest)
    }
    
    func contains<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate) -> Bool {
        let entities = select(entityType, where: predicate)
        return !entities.isEmpty
    }
    
    func update<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate?, apply: (_ entities: [Entity]) -> Void) {
        let fetchRequest = createFetchRequest(entityType: entityType, where: predicate)
        
        let entities = try! managedObjectContext.fetch(fetchRequest)
        apply(entities)
        
        appDelegate.saveContext()
    }
    
    func delete<Entity: NSManagedObject>(_ entityType: Entity.Type, where predicate: NSPredicate?) {
        let fetchReqest = createFetchRequest(entityType: entityType, where: predicate)
        
        let entities = try! managedObjectContext.fetch(fetchReqest)
        for entity in entities {
            managedObjectContext.delete(entity)
        }
        
        appDelegate.saveContext()
    }
}
