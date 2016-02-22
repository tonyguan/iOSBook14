//
//  ViewController.swift
//  NavigationBarSample
//
//  Created by 关东升 on 15/12/14.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
        
        /// 1.创建NavigationBar
        let navigationBarHeight:CGFloat = 44 //44默认高度
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 20, screen.size.width, navigationBarHeight))
        
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: Selector("save:"))
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("add:"))
        
        let navigationItem = UINavigationItem(title: "")
        navigationItem.leftBarButtonItem = saveButtonItem
        navigationItem.rightBarButtonItem = addButtonItem
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        ///2.添加标签
        let labelWidth:CGFloat = 84
        let labelHeight:CGFloat = 21
        let labelTopView:CGFloat = 198
        self.label = UILabel(frame: CGRectMake((screen.size.width - labelWidth)/2 , labelTopView, labelWidth, labelHeight))
        
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = .Center
        self.view.addSubview(self.label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func save(sender: AnyObject) {
        self.label.text = "点击Save"
    }
    
    func add(sender: AnyObject) {
        self.label.text = "点击Add"
    }

}

