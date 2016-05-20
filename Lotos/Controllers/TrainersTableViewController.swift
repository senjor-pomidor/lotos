//
//  TrainersTableViewController.swift
//  Lotos
//
//  Created by Andrey Torlopov on 20/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit
import CoreData


//MARK:- properties
class TrainersTableViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext!
//    let dataModel = DataModel()
    var frc: NSFetchedResultsController!
    var coreDataStack: CoreDataStack!
}

//MARK:- lifecycle
extension TrainersTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.setBool(Constants.flagTrainersIsLoaded, value: false)
        setup()
        reloadFetchedResultsController()
    }
}


//MARK:- tableview datasource/delegate
extension TrainersTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return frc.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections: protocol<NSFetchedResultsSectionInfo> = self.frc.sections![section];
        return sections.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let item = frc.objectAtIndexPath(indexPath) as! Trainer
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: item.photoURL!)!)!)
        return cell
    }
}

//MARK:- logic
extension TrainersTableViewController {
    func setup() {
        
        if let appDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate) {
            self.coreDataStack = appDelegate.coreDataStack
            self.managedObjectContext = appDelegate.coreDataStack.managedObjectContext
        }
        assert(self.managedObjectContext != nil, "ManagedObjectContext can not be nil")
        assert(self.coreDataStack != nil, "CoreDataStack can not be nil")
        
        if !UserDefaultsManager.bool(Constants.flagTrainersIsLoaded) {
           loadTrainers()
        }
    }
    
    func loadTrainers() {
        
        let a = LotosApi.loadTrainers()
        let model = DataManager()
        model.importTrainers(<#T##trainersItems: NSArray##NSArray#>, intoManagedObjectContext: <#T##NSManagedObjectContext#>)
        UserDefaultsManager.setBool(Constants.flagTrainersIsLoaded, value: true)
    }
    
    func reloadFetchedResultsController() {
        frc = nil
        let fetchRequest = NSFetchRequest(entityName: "Trainer")
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext , sectionNameKeyPath: nil, cacheName: "GAME_ITEM_CASH")
        do {
            try frc.performFetch()
            self.tableView.reloadData()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}