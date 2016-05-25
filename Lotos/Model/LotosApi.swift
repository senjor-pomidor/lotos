//
//  LotosApi.swift
//  Lotos
//
//  Created by Andrey Torlopov on 20/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit
import CoreData

typealias Complition = ()->Void

class LotosApi: NSObject {

    class func loadTrainers(context: NSManagedObjectContext, complition: Complition) {
        NetManager.getJSONData(Constants.trainersURL) { (success: NSArray?, failure: NSError?) in
            LotosApi.importTrainers(success!, intoManagedObjectContext: context)
            complition()
        }
    }
    class func importTrainers(trainersItems: NSArray,intoManagedObjectContext context: NSManagedObjectContext) {
        for item in trainersItems {
            let itemValue  = NSEntityDescription.insertNewObjectForEntityForName("Trainer", inManagedObjectContext: context) as! Trainer
            if let nameValue = item["name"] as? String,
                let trainerIdValue = item["trainer_id"] as? NSNumber,
                let photoURL = item["photo"] as? String {
                itemValue.name = nameValue
                itemValue.id =  trainerIdValue.intValue
                itemValue.photoURL = Constants.serverURL + photoURL
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
    }

}


