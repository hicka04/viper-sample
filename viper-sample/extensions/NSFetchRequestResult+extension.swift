//
//  NSFetchRequestResult+extension.swift
//  viper-sample
//
//  Created by hicka04 on 2018/08/25.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit
import CoreData

private extension NSFetchRequestResult {
    
    static var entityName: String {
        return String(describing: self)
    }
    
    static var managedObjectContext: NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func createFetchRequest(where predicate: NSPredicate? = nil,
                                   orderBy sortDescriptors: [NSSortDescriptor]? = nil,
                                   limit: Int? = nil, offset: Int? = nil) -> NSFetchRequest<Self> {
        let fetchReqest = NSFetchRequest<Self>(entityName: entityName)
        fetchReqest.predicate = predicate
        fetchReqest.sortDescriptors = sortDescriptors
        if let limit = limit {
            fetchReqest.fetchLimit = limit
        }
        if let offset = offset {
            fetchReqest.fetchOffset = offset
        }
        
        return fetchReqest
    }
}

extension NSFetchRequestResult {
    
    static func select(where predicate: NSPredicate? = nil,
                       orderBy sortDescriptors: [NSSortDescriptor]? = nil,
                       limit: Int? = nil, offset: Int? = nil) -> [Self]? {
        let fetchRequest = createFetchRequest(where: predicate, orderBy: sortDescriptors, limit: limit, offset: offset)
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    static func insert(apply: (_ entity: Self) -> Void) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                         into: managedObjectContext) as! Self
        apply(entity)
        
        try! managedObjectContext.save()
    }
}
