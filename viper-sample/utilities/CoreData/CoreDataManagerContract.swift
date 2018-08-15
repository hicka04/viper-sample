//
//  CoreDataManagerContract.swift
//  viper-sample
//
//  Created by hicka04 on 2018/08/15.
//  Copyright © 2018 hicka04. All rights reserved.
//

import CoreData

protocol CoreDataUsecase {
    
    func insert<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, apply: (_ entity: Entity) -> Void)
    func select<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate?) -> [Entity]
    func contains<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate) -> Bool
    func update<Entity: NSFetchRequestResult>(_ entityType: Entity.Type, where predicate: NSPredicate?, apply: (_ entities: [Entity]) -> Void)
    func delete<Entity: NSManagedObject>(_ entityType: Entity.Type, where predicate: NSPredicate?)
}
