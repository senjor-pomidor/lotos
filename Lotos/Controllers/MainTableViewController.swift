
import UIKit
import CoreData


//MARK:-properties
class MainTableViewController: UITableViewController {
    var dataSource: [TngItem] = []
}

//MARK:- lifecycle
extension MainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


//MARK:- tableview datasource/delegate
extension MainTableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
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
        self.title = "Расписание"
        setPullRefreshControll()
        if !UserDefaultsManager.bool(Constants.flagScheduleIsLoaded) {
            loadSchedule()
        }
    }
    
    func loadSchedule() {
        print("load schedule...")
        LotosApi.loadSchedule({ [unowned self] (array: [AnyObject]?) in
            UserDefaultsManager.setBool(Constants.flagScheduleIsLoaded, value: true)
            print("Schedule is loaded:  array = \(array)")
            self.dataSource = (array as! [TngItem])
            self.tableView.reloadData()
        })
    }
    
    func setPullRefreshControll() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(TrainersTableViewController.refreshTrainers(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!) // not required when using UITableViewController
    }
    
    func refreshTrainers(sender: AnyObject) {
        print("refresh")
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
        FileManager.deleteFilesInDirectory(FileManager.userDirectory())
        self.loadSchedule()
    }
    
}


















