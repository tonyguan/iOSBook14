//
//  ViewController.swift
//  RefreshControlSample
//
//  Created by 关东升 on 15/12/22.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UITableViewController {
    
    var Logs : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化变量和时间
        self.Logs = NSMutableArray()
        let date = NSDate()
        self.Logs.addObject(date)
        
        //初始化UIRefreshControl
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshTableView() {
        
        if (self.refreshControl?.refreshing == true) {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中...")
            //添加新的模拟数据
            let date = NSDate()
            self.Logs.addObject(date)
            
            self.refreshControl?.endRefreshing()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: --UITableViewDataSource 协议方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Logs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
        }        
        
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"

        let theDate = self.Logs[indexPath.row] as! NSDate
        cell.textLabel?.text = dateFormatter.stringFromDate(theDate)
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }


}

