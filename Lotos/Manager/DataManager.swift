//
//  DataManager.swift
//  TTEnigma
//
//  Created by Andrey Torlopov on 01/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit
import CoreData


// import array of NSDictionary into coreData
class DataManager: NSObject {
    
    func importTrainers(trainersItems: NSArray,intoManagedObjectContext context: NSManagedObjectContext) {
        for item in trainersItems {
            let itemValue  = NSEntityDescription.insertNewObjectForEntityForName("Trainer", inManagedObjectContext: context) as! Trainer
            if let nameValue = item["name"] as? String,
               let trainerIdValue = item["trainer_id"] as? NSNumber,
               let photoURL = item["photo"] as? String {
                itemValue.name = nameValue
                itemValue.id =  trainerIdValue.doubleValue
                itemValue.photoURL = Constants.serverURL + photoURL
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
    }

    func importDictionary(dictionaryItems: NSArray, intoManagedObjectContext context: NSManagedObjectContext) {
//        for item in dictionaryItems {
////            let c: AnyClass = NSClassFromString("String")
//
//
//            let gameItem  = NSEntityDescription.insertNewObjectForEntityForName("GameItem", inManagedObjectContext: context) as! GameItem
//            if let value = item["id"] as? NSNumber {
//                gameItem.id = value.stringValue
//            }
//            gameItem.title = item["title"] as! String?
//            if let value = item["idcategory"] as? NSNumber {
//                gameItem.idcategory = value.stringValue
//            }
//            gameItem.category = item["category"] as! String?
//            gameItem.itemDescription =  item["description"] as! String?
//            gameItem.imageURL = item["image"] as! String?
//            if let value = item["created_at"] as? String {
//                let d: Double = Double(value)!
//                gameItem.created_at = NSDate(timeIntervalSinceReferenceDate: d).datetimeInReadeableFormat()
//            } else {
//                print(item["created_at"])
//            }
//        }
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Error \(error.localizedDescription)")
//        }
        
    }
    
}