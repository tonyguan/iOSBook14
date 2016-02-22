//
//  ViewController.swift
//  MoveCell
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

    var listTeams : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏
        self.navigationItem.rightBarButtonItem =  self.editButtonItem()
        self.navigationItem.title = "单元格移动"
        
        self.listTeams = NSMutableArray(array: ["黑龙江", "吉林", "辽宁"])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: --UIViewController生命周期方法，用于响应视图编辑状态变化
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
    }

    // MARK: --实现UITableViewSource数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
        }

        cell.textLabel?.text = self.listTeams[indexPath.row] as? String
        
        return cell
    }

	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let stringToMove = self.listTeams[sourceIndexPath.row] as! String
        
        self.listTeams .removeObjectAtIndex(sourceIndexPath.row)
        self.listTeams.insertObject(stringToMove, atIndex: destinationIndexPath.row)
    }
    
    // MARK: --UITableViewDelegate协议方法
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }

}

