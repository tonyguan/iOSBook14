//
//  ViewController.swift
//  DeleteAddCell
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

class ViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var txtField: UITextField!
    
    var listTeams : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏
        self.navigationItem.rightBarButtonItem =  self.editButtonItem()
        self.navigationItem.title = "单元格插入和删除"
        
        //设置单元格文本框
        self.txtField.hidden = true
        self.txtField.delegate = self
        
        self.listTeams = NSMutableArray(array: ["黑龙江", "吉林", "辽宁"])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: --UIViewController生命周期方法，用于响应视图编辑状态变化
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        if editing {
            self.txtField.hidden = false
        } else {
            self.txtField.hidden = true
        }
    }
    
    //MARK: --实现数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        let b_addCell = (indexPath.row == self.listTeams.count)
        
        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if (!b_addCell) {
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = self.listTeams[indexPath.row] as? String
        } else {
            self.txtField.frame = CGRectMake(40,0,300,cell.frame.size.height)
            self.txtField.borderStyle = .None
            self.txtField.placeholder = "Add..."
            self.txtField.text = ""
            cell.addSubview(self.txtField)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPaths = [indexPath]
        
        if (editingStyle == .Delete) {
            self.listTeams.removeObjectAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        } else if (editingStyle == .Insert) {
            self.listTeams.insertObject(self.txtField.text! , atIndex: self.listTeams.count)
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        }
        self.tableView.reloadData()
    }
    
    //MARK: --实现委托协议方法
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.row == self.listTeams.count) {
            return .Insert
        } else {
            return .Delete
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.row == self.listTeams.count) {
            return false
        } else {
            return true
        }
    }
    
    //MARK: --UITextFieldDelegate委托方法,关闭键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
