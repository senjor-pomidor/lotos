//
//  TngItem+CoreDataProperties.swift
//  Lotos
//
//  Created by Andrey Torlopov on 25/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TngItem {

    @NSManaged var date: NSTimeInterval
    @NSManaged var disciplite: String?
    @NSManaged var hall: Int32
    @NSManaged var time: NSTimeInterval
    @NSManaged var townId: Int32
    @NSManaged var townName: String?
    @NSManaged var trainerId: Int32
    @NSManaged var weekDay: Int32

}
