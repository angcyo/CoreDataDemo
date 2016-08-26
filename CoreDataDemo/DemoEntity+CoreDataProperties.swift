//
//  DemoEntity+CoreDataProperties.swift
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

extension DemoEntity {

	@NSManaged var username: String?
	@NSManaged var password: NSNumber?
	@NSManaged var age: NSNumber?
	@NSManaged var time: NSNumber?

	override var description: String {
		return "username:\(username) password:\(password) age:\(age) time:\(time)"
	}
}
