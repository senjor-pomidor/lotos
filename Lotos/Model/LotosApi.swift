import UIKit

typealias Complition = (array: [AnyObject]?)->Void


class LotosApi: NSObject {

    class func loadTrainers(complition: Complition) {
            let array = Database.getTrainers()
            complition(array: array)
    }
    
    class func loadSchedule(complition: Complition) {
            let array = Database.getSchedule()
            complition(array: array)
//        }
    }

}


extension LotosApi {
//    
//    class func importTrainers(trainersItems: NSArray,intoManagedObjectContext context: NSManagedObjectContext) {
//        for item in trainersItems {
//            
//            let itemValue  = NSEntityDescription.insertNewObjectForEntityForName("Trainer", inManagedObjectContext: context) as! Trainer
//            
//            if let nameValue = item["name"] as? String,
//                let trainerIdValue = item["trainer_id"] as? NSNumber,
//                let photoURL = item["photo"] as? String {
//                itemValue.name = nameValue
//                itemValue.id =  trainerIdValue.intValue
//                itemValue.photoURL = Constants.serverURL + photoURL
//            }
//        }
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Error \(error.localizedDescription)")
//        }
//    }
//    
//
//    class func importSchedule(scheduleItems: NSArray, intoManagedObjectContext context: NSManagedObjectContext) {
//        for item in scheduleItems {
//            let itemValue  = NSEntityDescription.insertNewObjectForEntityForName("TngItem", inManagedObjectContext: context) as! Trainer
//            
////            if let nameValue = item["name"] as? String,
////                let trainerIdValue = item["trainer_id"] as? NSNumber,
////                let photoURL = item["photo"] as? String {
////                itemValue.name = nameValue
////                itemValue.id =  trainerIdValue.intValue
////                itemValue.photoURL = Constants.serverURL + photoURL
////            }
//            
//        }
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Error \(error.localizedDescription)")
//        }
//    }

}


