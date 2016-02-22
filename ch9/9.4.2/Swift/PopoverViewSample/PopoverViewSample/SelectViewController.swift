//
//  SelectViewController.swift
//  PopoverViewSample
//
//  Created by 关东升 on 16/2/6.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class SelectViewController: UITableViewController {
    
    var listData: NSArray!
    var lastIndexPath: NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.listData = ["红色", "蓝色", "黄色"]
        self.preferredContentSize = CGSizeMake(200, 140)
        self.tableView.scrollEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: --UITableViewDataSource 协议方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        
        cell.textLabel?.text = self.listData[indexPath.row] as? String

        return cell
    }
    
    // MARK: --UITableViewDelegate 协议方法
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newRow = indexPath.row
        
        let oldRow = (self.lastIndexPath != nil) ? self.lastIndexPath.row : -1
        
        if (newRow != oldRow) {
            let newCell = tableView.cellForRowAtIndexPath(indexPath)
            newCell!.accessoryType = .Checkmark
            
            if self.lastIndexPath != nil {
                let oldCell = tableView.cellForRowAtIndexPath(self.lastIndexPath)
                oldCell!.accessoryType = .None
            }
            
            self.lastIndexPath = indexPath
        }
    }

}
