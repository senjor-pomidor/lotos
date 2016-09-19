//Core Data Stack.

import Foundation
import CoreData

class CoreDataStack {
    let modelName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String    
    private lazy var  appDocDir: NSURL =  {
       let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask)
        return urls[urls.count - 1]
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.appDocDir.URLByAppendingPathComponent(self.modelName)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true]
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch {
            print("Can't add persistent store")
        }
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError
            {
                print("error \(error.localizedDescription)")
                abort() // выходим из сохранения
            }
        }
    }
    
    func deleteEntity(entityName: String) {
        let fr = NSFetchRequest(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fr.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        } catch {
            print("cant perform fetch to delete objects")
        }
        let dataAry = frc.fetchedObjects as! [NSManagedObject]
        
        for item in dataAry {
            self.managedObjectContext.deleteObject(item)
        }
        
        if self.managedObjectContext.hasChanges {
            self.save()
        }
        
    }
    
}