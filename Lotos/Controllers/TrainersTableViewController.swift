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
    var dataSource = [Trainer]()
}



//MARK:- lifecycle
extension TrainersTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}



//MARK:- tableview datasource/delegate
extension TrainersTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        let trainer = dataSource[indexPath.row]
        cell.nameLabel.text = trainer.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}



//MARK:- logic
extension TrainersTableViewController {
    func setup() {
        self.title = "Инструкторы"
        setPullRefreshControll()
        if !UserDefaultsManager.bool(Constants.flagTrainersIsLoaded) {
           loadTrainers()
        }
    }
    
    func loadTrainers() {
        LotosApi.loadTrainers {[unowned self] (array) in
            
            UserDefaultsManager.setBool(Constants.flagTrainersIsLoaded, value: true)
            self.dataSource = (array as? [Trainer])!
            
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func setPullRefreshControll() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(TrainersTableViewController.refreshTrainers(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
    }
    
    func refreshTrainers(sender: AnyObject) {
        print("refresh")
        FileManager.deleteFilesInDirectory(FileManager.userDirectory())
        self.loadTrainers()
    }
}



