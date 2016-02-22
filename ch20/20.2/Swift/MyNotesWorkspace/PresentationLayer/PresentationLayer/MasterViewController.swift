//
//  MasterViewController.swift
//  PresentationLayer
//
//  Created by 关东升 on 15/12/31.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//



import UIKit
import BusinessLogicLayer
import PersistenceLayer



class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    //保存数据列表
    var listData = NSMutableArray()
    //业务逻辑对象BL
    var bl = NoteBL()

    override func viewDidLoad() {
        super.viewDidLoad()

        for var i = 0; i < 10; i++ {
            let b = i * i
            NSLog("b = %i", b)
        }
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
   
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1]
                        as! UINavigationController).topViewController
                            as? DetailViewController
        }
        
        //查询所有的数据
        self.listData = self.bl.findAll()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                    selector: "reloadView1:",
                    name: "reloadViewNotification",
                    object: nil)
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let note = self.listData[indexPath.row] as! Note
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = note
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let note = self.listData[indexPath.row] as! Note
        cell.textLabel!.text = note.content
        cell.detailTextLabel!.text = note.date.description
     
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = self.listData[indexPath.row] as! Note
            self.listData = bl.remove(note)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: --处理通知
    func reloadView(notification : NSNotification) {
        let resList = notification.object as! NSMutableArray
        self.listData = resList
        self.tableView.reloadData()
    }
}

