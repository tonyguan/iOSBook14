//
//  ViewController.swift
//  IndexTable
//
//  Created by 关东升 on 15/12/21.
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
    
    //从team_dictionary.plist文件中读取出来的数据
    var dictData : NSDictionary!
    //小组名集合
    var listGroupname : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plistPath = NSBundle.mainBundle().pathForResource("team_dictionary", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        
        let tempList  = self.dictData.allKeys as NSArray
        //对key进行排序
        self.listGroupname = tempList.sortedArrayUsingSelector("compare:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: --UITableViewDataSource 协议方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //按照节索引从小组名数组中获得组名
        let groupName = self.listGroupname[section] as! String
        //将组名作为key，从字典中取出球队数组集合
        let listTeams = self.dictData[groupName] as! NSArray
        
        return listTeams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        //获得选择的节
        let section = indexPath.section
        //获得选择节中选中的行索引
        let row = indexPath.row
        //按照节索引从小组名数组中获得组名
        let groupName = self.listGroupname[section] as! String
        //将组名作为key，从字典中取出球队数组集合
        let listTeams = self.dictData[groupName] as! NSArray
        
        cell.textLabel?.text = listTeams[row] as? String
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.listGroupname.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupName = self.listGroupname[section] as! String
        return groupName
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        //把 A组 改为 A
        for item in self.listGroupname {
            let title = item.substringToIndex(1) as String
            listTitles.append(title)
        }
        return listTitles
    }
    
}