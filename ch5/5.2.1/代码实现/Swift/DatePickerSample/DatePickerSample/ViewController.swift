//
//  ViewController.swift
//  DatePickerSample
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

    var datePicker: UIDatePicker!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen().bounds
    
        /// 1.日期选择器
        let datePickerWidth:CGFloat = 320
        let datePickerHeight:CGFloat = 167
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 0, datePickerWidth, datePickerHeight))
        //zh-Hans简体中文
        self.datePicker.locale = NSLocale(localeIdentifier: "zh-Hans")
        //设置日期时间模式
        self.datePicker.datePickerMode = .DateAndTime
        self.view.addSubview(self.datePicker)
        
        ///2.添加标签
        let labelWidth:CGFloat = 200
        let labelHeight:CGFloat = 21
        let labelTopView:CGFloat = 281
        self.label = UILabel(frame: CGRectMake((screen.size.width - labelWidth)/2 , labelTopView, labelWidth, labelHeight))
        
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = .Center
        self.view.addSubview(self.label)
        
        /// 3.Button按钮
        let button = UIButton(type: UIButtonType.System)
        button.setTitle("Button", forState: UIControlState.Normal)
        
        let buttonWidth:CGFloat = 46
        let buttonHeight:CGFloat = 30
        let buttonTopView:CGFloat = 379
        
        button.frame = CGRectMake((screen.size.width - buttonWidth)/2 , buttonTopView, buttonWidth, buttonHeight)
        //指定事件处理方法
        button.addTarget(self, action: Selector("onclick:"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func onclick(sender: AnyObject) {
        
        let theDate : NSDate = self.datePicker.date
        let desc = theDate.descriptionWithLocale(NSLocale.currentLocale())
        NSLog("the date picked is: %@", desc)
        
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        NSLog("the date formate is: %@", dateFormatter.stringFromDate(theDate))
        
        self.label.text = dateFormatter.stringFromDate(theDate)
        
    }
    
}

