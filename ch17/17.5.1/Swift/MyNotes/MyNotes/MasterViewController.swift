//
//  MasterViewController.swift
//  MyNotes
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
import Alamofire

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    
    //保存数据列表
    var listData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.startRequest()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 开始请求Web Service
    func startRequest() {
        //测试
        Alamofire.request(.GET, "https://www.51work6.com")
        
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dict = self.listData[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = dict
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let dict = self.listData[indexPath.row] as! NSDictionary
        cell.textLabel!.text = dict["Content"] as? String
        cell.detailTextLabel!.text = dict["CDate"] as? String
        
        return cell
    }
    
    
    // MARK: -- 重新加载表视图
    func reloadView(res : NSDictionary) {
        
        let resultCode: NSNumber = res["ResultCode"] as! NSNumber
        
        if (resultCode.integerValue >= 0) {
            self.listData = res["Record"] as! NSArray
            self.tableView.reloadData()
        } else {
            let errorStr = resultCode.errorMessage
            let alertController: UIAlertController = UIAlertController(title: "错误信息", message: errorStr, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            //显示
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
}