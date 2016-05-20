//
//  MainTableViewController.swift
//  Lotos
//
//  Created by Andrey Torlopov on 09/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit

//MARK:-properties
class MainTableViewController: UITableViewController {
}

//MARK:- lifecycle
extension MainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    // MARK: - Table view data source
}


//MARK:- tableview datasource/delegate
extension MainTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
    
}