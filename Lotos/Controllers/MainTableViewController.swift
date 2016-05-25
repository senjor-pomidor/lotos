//
//  MainTableViewController.swift
//  Lotos
//
//  Created by Andrey Torlopov on 09/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit
import CoreData


//MARK:-properties
class MainTableViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext!
    var frc: NSFetchedResultsController!
    var coreDataStack: CoreDataStack!
}

//MARK:- lifecycle
extension MainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        reloadFetchedResultsController()
    }
    
}


//MARK:- tableview datasource/delegate
extension MainTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return frc.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections: protocol<NSFetchedResultsSectionInfo> = self.frc.sections![section];
        return sections.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = String(UTF8String: "Строка №\(indexPath.row)")!
        return cell
    }
}

//MARK:- actions
extension MainTableViewController {
    
}


//MARK:- logic
extension MainTableViewController {
    func setup() {
        if let appDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate) {
            self.coreDataStack = appDelegate.coreDataStack
            self.managedObjectContext = appDelegate.coreDataStack.managedObjectContext
        }
        assert(self.managedObjectContext != nil, "ManagedObjectContext can not be nil")
        assert(self.coreDataStack != nil, "CoreDataStack can not be nil")
        self.title = "Расписание"
        setPullRefreshControll()
        if !UserDefaultsManager.bool(Constants.flagTrainersIsLoaded) {
            loadTrainers()
        }
    }
    
    func loadTrainers() {
        LotosApi.loadTrainers(managedObjectContext, complition: {
            UserDefaultsManager.setBool(Constants.flagTrainersIsLoaded, value: true)
            self.reloadFetchedResultsController()
        })
    }
    
    func reloadFetchedResultsController() {
        frc = nil
        let fetchRequest = NSFetchRequest(entityName: Constants.entityTrainer)
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext , sectionNameKeyPath: nil, cacheName: "TRN_CACHE")
        do {
            try frc.performFetch()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func setPullRefreshControll() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(TrainersTableViewController.refreshTrainers(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
    }
    
    func refreshTrainers(sender: AnyObject) {
        print("refresh")
        coreDataStack.deleteEntity(Constants.entityTrainer)
        coreDataStack.save()
        FileManager.deleteFilesInDirectory(FileManager.userDirectory())
        self.loadTrainers()
    }
    
}