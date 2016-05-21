//
//  Trainer+CoreDataProperties.swift
//  Lotos
//
//  Created by Andrey Torlopov on 21/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trainer {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var photoURL: String?

}
