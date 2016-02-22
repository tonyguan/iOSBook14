//
//  ScheduleViewController.swift
//  RioOlympics2016
//
//  Created by 关东升 on 16/2/2.
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

class ScheduleViewController: UITableViewController {
    
    //表视图使用的数据
    var data: NSDictionary!
    //比赛日期列表
    var arrayGameDateList: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  self.data == nil || self.data.count == 0 {
            let bl = ScheduleBL()
            self.data = bl.readData()
            let keys = self.data.allKeys as NSArray
            //对key进行排序
            self.arrayGameDateList = keys.sortedArrayUsingSelector("compare:") as NSArray
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: --表视图数据源
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = self.data.allKeys as NSArray
        return keys.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //比赛日期
        let strGameDate = self.arrayGameDateList[section] as! String
        //比赛日期下的比赛日程表
        let schedules = self.data[strGameDate] as! NSArray
        
        return schedules.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //比赛日期
        let strGameDate = self.arrayGameDateList[section] as! String
        return strGameDate
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        //比赛日期
        let strGameDate = self.arrayGameDateList[indexPath.section] as! String
        //比赛日期下的比赛日程表
        let schedules = self.data[strGameDate] as! NSArray
        let schedule = schedules[indexPath.row] as! Schedule
        
        let subtitle = String(format: "%@ | %@", schedule.GameInfo!, schedule.Event!.EventName!)
        
        cell.textLabel?.text = schedule.GameTime as? String
        cell.detailTextLabel?.text = subtitle
        
        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        // 2016-08-09 -> 08-09
        for item in self.arrayGameDateList {
            let title = (item as! NSString).substringFromIndex(5)
            listTitles.append(title)
        }
        return listTitles
    }
}
