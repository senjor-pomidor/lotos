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
    var frc: NSFetchedResultsController!
    var coreDataStack: CoreDataStack!
}

//MARK:- lifecycle
extension TrainersTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaultsManager.setBool(Constants.flagTrainersIsLoaded, value: false)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        let item = frc.objectAtIndexPath(indexPath) as! Trainer
        
        cell.nameLabel.text = item.name
        cell.idLabel.text = item.id
        if let localImage: UIImage = FileManager.loadLocalImage(item.id!) {
            dispatch_async(dispatch_get_main_queue(), {
                cell.avatarImageView.image = localImage
            })
        } else {
            cell.avatarImageView.loadAndCropToSquare(item.photoURL, complited: { () in
                if let imageToSave = cell.avatarImageView.image,
                   let fileName = item.id {
                    FileManager.saveImage(imageToSave, withName: fileName)
                } else {
                    cell.avatarImageView.image = UIImage(named: "no_photo")
                }
            })
        }        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        self.title = "Инструкторы"
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
        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext , sectionNameKeyPath: nil, cacheName: "GAME_ITEM_CASH")
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
//        self.refreshControl!.attributedTitle = NSAttributedString(string: "Refresh")
        self.refreshControl!.addTarget(self, action: Selector("refreshTrainers:"), forControlEvents: UIControlEvents.ValueChanged)
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