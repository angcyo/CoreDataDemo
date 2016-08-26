//
//  TestEntity+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by angcyo on 16/08/26.
//  Copyright © 2016年 angcyo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TestEntity {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var time: NSDate?

}
