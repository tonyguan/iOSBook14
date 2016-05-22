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

enum ActionTypes {
    case QUERY      //查询操作
    case REMOVE     //删除操作
    case ADD        //添加操作
    case MOD        //修改操作
}


class MasterViewController: UITableViewController {

    //请求动作标识
    var action = ActionTypes.QUERY
    //删除行号
    var deleteRowId = -1

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
        
        //查询请求数据
        action = ActionTypes.QUERY
        self.startRequest()
        
        //初始化UIRefreshControl
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
    }

    func refreshTableView() {
        
        if (self.refreshControl?.refreshing == true) {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中...")
            //查询请求数据
            action = ActionTypes.QUERY
            self.startRequest()
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        action = ActionTypes.QUERY
//        self.startRequest()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - 开始请求Web Service
    func startRequest() {

        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        var post = ""
        if action == ActionTypes.QUERY {
            //查询处理
            post = String(format: "email=%@&type=%@&action=%@", "<你的51work6.com用户邮箱>", "JSON", "query")
        } else if action == ActionTypes.REMOVE {
            //删除处理
            let dict = self.listData[deleteRowId] as! NSMutableDictionary
            let id = dict.objectForKey("ID") as! NSNumber
            post = String(format: "email=%@&type=%@&action=%@&id=%@", "<你的51work6.com用户邮箱>", "JSON", "remove", id)
        }
        let postData: NSData = post.dataUsingEncoding(NSUTF8StringEncoding)!

        let url = NSURL(string: strURL)!

        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData

        let defaultConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: defaultConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())

        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            NSLog("请求完成...")
            if error == nil {
                do {
                    let resDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary

                    if self.action == ActionTypes.QUERY {
                        //查询处理
                        self.reloadView(resDict)
                    } else if self.action == ActionTypes.REMOVE {
                        //删除处理
                        let resultCode: NSNumber = resDict["ResultCode"] as! NSNumber
                        var message = "操作成功。"
                        if (resultCode.integerValue < 0) {
                            message = resultCode.errorMessage
                        }

                        let alertController: UIAlertController = UIAlertController(title: "提示信息", message: message, preferredStyle: .Alert)
                        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(okAction)
                        //显示
                        self.presentViewController(alertController, animated: true, completion: nil)

                        //重新查询
                        self.action = ActionTypes.QUERY
                        self.startRequest()
                    }

                } catch {
                    NSLog("返回数据解析失败")
                }
            } else {
                NSLog("error : %@", error!.localizedDescription)
            }
        })

        task.resume()

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

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            //删除数据
            action = ActionTypes.REMOVE
            deleteRowId = indexPath.row
            self.startRequest()
        }
    }

    // MARK: -- 重新加载表视图
    func reloadView(res: NSDictionary) {
        
        self.refreshControl?.endRefreshing()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")

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