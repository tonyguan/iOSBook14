//
//  CountDownViewController.swift
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

class CountDownViewController: UIViewController {

    //显示倒计时
    @IBOutlet weak var lblCountDown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建NSDateComponents对象
        let comps = NSDateComponents()
        //设置NSDateComponents日期
        comps.day = 5
        //设置NSDateComponents月
        comps.month = 8
        //设置NSDateComponents年
        comps.year = 2016
        
        //创建日历对象
        let calender = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)
        
        //获得2016-8-5日的NSDate日期对象
        let destinationDate = calender!.dateFromComponents(comps)
        
        let date:NSDate = NSDate()
        
        //获得当前日期到2016-8-5时间的NSDateComponents对象
        let components = calender!.components(NSCalendarUnit.Day, fromDate: date , toDate:destinationDate!, options:NSCalendarOptions.WrapComponents)
        
        //获得当前日期到2016-8-5相差的天数
        let days = components.day

        let strLabel = NSMutableAttributedString(string: String(format:"%i天", days))
        
        strLabel.addAttribute(NSFontAttributeName,
            value: UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote),
            range: NSMakeRange(strLabel.length - 1, 1))
        
        self.lblCountDown.attributedText = strLabel        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
