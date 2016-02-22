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
    var bl: NoteBL!
    //删除数据索引
    var deletedIndex: Int!
    //删除数据
    var deletedNote: Note!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //        self.navigationItem.rightBarButtonItem = addButton
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.bl = NoteBL()
        self.bl.findAllNotes()
        
        //初始化UIRefreshControl
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findAllNotesFinished:", name: BLFindAllFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "findAllNotesFailed:", name: BLFindAllFailedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeNoteFinished:", name: BLRemoveFinishedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeNoteFailed:", name: BLRemoveFailedNotification, object: nil)
    }
    
    func refreshTableView() {
        
        if (self.refreshControl!.refreshing == true) {
            self.refreshControl!.attributedTitle = NSAttributedString(string: "加载中...")
            //查询所有的数据
            self.bl.findAllNotes()
        }
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
        cell.detailTextLabel!.text = note.date
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            self.deletedIndex = indexPath.row
            self.deletedNote = self.listData[indexPath.row] as! Note            
            self.bl.removeNote(self.deletedNote)
        }
    }
    
    // MARK:- 处理通知
    //查询所有数据方法 成功
    func findAllNotesFinished(notification: NSNotification)  {
        self.listData =  notification.object as! NSMutableArray
        self.tableView.reloadData()
        if self.refreshControl != nil {
            self.refreshControl!.endRefreshing()
            self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        }
    }
    
    //查询所有数据方法 失败
    func findAllNotesFailed(notification: NSNotification) {
        
        let error = notification.object as! NSError
        let errorStr = error.localizedDescription
        
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: errorStr, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        
        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
        
        if self.refreshControl != nil {
            self.refreshControl!.endRefreshing()
            self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        }
    }
    
    
    //删除Note方法 成功
    func removeNoteFinished(notification: NSNotification) {
        
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: "删除成功。", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        
        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
        
        self.listData.removeObjectAtIndex(self.deletedIndex)
        
        self.tableView.reloadData()
    }
    
    //删除Note方法 失败
    func removeNoteFailed(notification: NSNotification) {
        
        let error = notification.object as! NSError
        let errorStr = error.localizedDescription
        
        let alertController: UIAlertController = UIAlertController(title: "操作信息", message: errorStr, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel) {
            (alertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        
        //显示
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

